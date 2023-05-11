import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool choolCheckDone = false;
  GoogleMapController? mapController;

  // latitude 위도, longitude 경도
  static const LatLng homeLatLng = LatLng(
    37.4947648084,
    126.997558651,
  );

  static const CameraPosition initialPosition = CameraPosition(
    target: homeLatLng,
    zoom: 16,
  );

  static const double okDistance = 100;
  static Circle withinDistanceCircle = Circle(
    circleId: const CircleId('withinDistanceCircle'),
    center: homeLatLng,
    fillColor: Colors.blue.withOpacity(0.5),
    radius: okDistance, // 미터 단위
    strokeColor: Colors.blue,
    strokeWidth: 1,
  );

  static Circle notDistanceCircle = Circle(
    circleId: const CircleId('notDistanceCircle'),
    center: homeLatLng,
    fillColor: Colors.red.withOpacity(0.5),
    radius: okDistance, // 미터 단위
    strokeColor: Colors.red,
    strokeWidth: 1,
  );

  static Circle checkDoneCircle = Circle(
    circleId: const CircleId('checkDoneCircle'),
    center: homeLatLng,
    fillColor: Colors.green.withOpacity(0.5),
    radius: okDistance, // 미터 단위
    strokeColor: Colors.green,
    strokeWidth: 1,
  );

  static const Marker marker = Marker(
    markerId: MarkerId(
      'marker',
    ),
    position: homeLatLng,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: renderAppBar(),
      body: FutureBuilder<String>(
        future: checkPerission(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          // 로딩 중일 경우
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data == '위치 권한이 허가되었습니다.') {
            return StreamBuilder<Position>(
                // Geolocator.getPositionStream() -> 현재 위치가 변경될 때마다 위치 정보 리턴
                stream: Geolocator.getPositionStream(),
                builder: (context, snapshot) {
                  bool isWithinRange = false;

                  if (snapshot.hasData) {
                    final start = snapshot.data!;
                    const end = homeLatLng;

                    final distance = Geolocator.distanceBetween(
                      start.latitude,
                      start.longitude,
                      end.latitude,
                      end.longitude,
                    );

                    if (distance < okDistance) {
                      isWithinRange = true;
                    }
                  }

                  return Column(
                    children: [
                      _CustomGoogleMap(
                        initialPosition: initialPosition,
                        // 2중 if
                        circle: choolCheckDone
                            ? checkDoneCircle
                            : isWithinRange
                                ? withinDistanceCircle
                                : notDistanceCircle,
                        marker: marker,
                        onMapCreated: onMapCreated,
                      ),
                      _ChoolCheckButton(
                        isWithinRange: isWithinRange,
                        choolCheckDone: choolCheckDone,
                        onPressed: onChoolCheckPressed,
                      ),
                    ],
                  );
                });
          }

          return Center(
            child: Text(snapshot.data),
          );
        },
      ),
    );
  }

  onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  onChoolCheckPressed() async {
    // return 값은 pop에서 담겨오는 값을 받음.
    final result = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              '출근하기',
            ),
            content: const Text(
              '출근을 하시겠습니까?',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text(
                  '취소',
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text(
                  '출근하기',
                ),
              ),
            ],
          );
        });

    if (result) {
      setState(
        () => choolCheckDone = true,
      );
    }
  }

  // 권한 요청 및 권한 상태 관리
  Future<String> checkPerission() async {
    // Geolocator.isLocationServiceEnabled() -> 위치 서비스가 활성화 되어있는 지 확인해주는 함수
    final isLocationEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isLocationEnabled) {
      return '위치 서비스를 활성화 해주세요.';
    }
    // Geolocator.checkPermission() -> 현재 앱이 가지고 있는 위치 서비스의 권한
    LocationPermission checkedPermission = await Geolocator.checkPermission();

    /*  LocationPermission Enum 
        always
          권한 허가 상태 

        whileInUse
          권한 허가 상태 
          다만, 앱 실행 중일 때만 위치 권한 허가 

        denied(default)
          권한을 요구해야할 상태
        
        deniedForever
          denied에서 권한을 요구했지만 거절된 상태 
          이 상태인 경우 앱 내에서 다시는 권한을 요청할 수 없음

        unbleToDetermine
          앱에서는 볼 일 없지만, 웹에서 워치 권한을 사용할 수 없는 경우 
     */
    if (checkedPermission == LocationPermission.denied) {
      // 권한 요청 다이알로그 표출
      checkedPermission = await Geolocator.requestPermission();

      if (checkedPermission == LocationPermission.denied) {
        return '위치 권한을 허가해주세요.';
      }
    }

    if (checkedPermission == LocationPermission.deniedForever) {
      // deniedForever => 앱 내에서 권한 요청이 불가능한 상태
      return '앱 위치 권한을 세팅해서 허가해주세요.';
    }

    return '위치 권한이 허가되었습니다.';
  }

  AppBar renderAppBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.white,
      title: const Text(
        '근태 관리',
        style: TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () async {
            if (mapController == null) {
              return;
            } else {
              // 현재 위치 가져오기 
              final location = await Geolocator.getCurrentPosition();

              // 현재 위치로 이동하기
              mapController!.animateCamera(
                CameraUpdate.newLatLng(
                  LatLng(
                    location.latitude,
                    location.longitude,
                  ),
                ),
              );
            }
          },
          icon: const Icon(
            Icons.my_location,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }
}

class _CustomGoogleMap extends StatelessWidget {
  final CameraPosition initialPosition;
  final Circle circle;
  final Marker marker;
  final MapCreatedCallback onMapCreated;

  const _CustomGoogleMap({
    required this.initialPosition,
    required this.circle,
    required this.marker,
    required this.onMapCreated,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: initialPosition,
        // 내 위치 표시 여부
        myLocationEnabled: true,
        // 내 위치로 가기 버튼 표시 여부
        myLocationButtonEnabled: false,
        // Set으로 Circle을 넘김
        circles: {circle},
        markers: {marker},
        onMapCreated: onMapCreated,
      ),
    );
  }
}

class _ChoolCheckButton extends StatelessWidget {
  final bool isWithinRange;
  final VoidCallback onPressed;
  final bool choolCheckDone;

  const _ChoolCheckButton({
    required this.isWithinRange,
    required this.onPressed,
    required this.choolCheckDone,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.timelapse_outlined,
            size: 50.0,
            color: choolCheckDone
                ? Colors.green
                : isWithinRange
                    ? Colors.blue
                    : Colors.red,
          ),
          const SizedBox(
            height: 20.0,
          ),
          if (!choolCheckDone && isWithinRange)
            TextButton(
              onPressed: onPressed,
              child: const Text('출근하기'),
            ),
        ],
      ),
    );
  }
}
