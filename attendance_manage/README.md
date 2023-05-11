## 키 가리기

# attendance_manage

학습 목표

- Google Maps 지도 사용하기
- 지도에 마커 표시하기
- 지도에 동그라미 표시하기
- 현재 위치 표시하고 위경도 구하기
- 위경도 간 거리 구하기

---

## 지도 위에 마커 표시하기

### 마커란?

`Marker` 타입으로 지도 상에 특정 위치에 아이콘을 띄울 수 있다.

#### 마커 생성

```dart
  static const Marker marker = Marker(
    markerId: MarkerId(
      'marker',
    ),
    position: homeLatLng,
  );
```

`markerId`: 해당 marker의 고유 식별자
`position`: 해당 marker의 위치

#### 구글 지도에 마커 넣기

`GoogleMap`의 `markers`파라미터에 `Set 타입`의 인자를 넘겨주면 자동으로 마커를 그려준다.

```dart
GoogleMap(
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
```

---

## 지도에 동그라미 표시하기

`Circle`은 지도 상에 동그라미를 그려준다.

### circle 생성

```dart
  static Circle withinDistanceCircle = Circle(
    circleId: const CircleId('withinDistanceCircle'),
    center: homeLatLng,
    fillColor: Colors.blue.withOpacity(0.5),
    radius: okDistance, // 미터 단위
    strokeColor: Colors.blue,
    strokeWidth: 1,
  );
```

`circleId`: 해당 Circle의 고유 식별자
`center`: Circle 중심의 좌표 정보
`fillColor`: Circle 색상
`radius`: 반지름
`strokeColor`: 테두리 색상
`strokeWidth`: 테두리 두께

### 지도 위에 circle 그리기

`GoogleMap`의 `circles`파라미터에 `Set 타입`의 인자를 넘겨주면 자동으로 마커를 그려준다.

```dart
GoogleMap(
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
```

---

## 현재 위치 표시하고 위경도 구하기

### 현재 위치 값 구하기

1. `Geolocator.getPositionStream()`
   현재 위치 값을 스트림 형태로 받아옴.
   `StreamBuilder`내에서 사용하며 builder의 snapshot.data에 현재 위치 정보가 return 됨.

2. `Geolocator.getCurrentPosition()`
   현재 위치 값을 Position 형태로 받아옴.

### 위 경도 구하기

Position.latitude -> 위도
Position.longitude -> 경도

---

## 위경도 간 거리 구하기
`Geolocator.distanceBetween()`를 사용하여 간편하게 계산할 수 있음.

---

## FutureBuilder

`future` 파라미터
Future 형식의 값을 리턴하는 함수는 뭐든 넣을 수 있다.
함수의 상태가 변경될 때마다 빌더를 다시 실행하여 화면을 다시 그려줌.

다양한 결과에 따라 맞는 화면을 표출해줄 수 있음.

## StreamBuilder

## AlertDialog

알람 형식을 쉽게 띄울 수 있는 위젯
하나의 스크린으로 생각하면 된다.
