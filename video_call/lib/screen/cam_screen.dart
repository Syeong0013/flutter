import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_call/const/agora.dart';

class CamScreen extends StatefulWidget {
  const CamScreen({super.key});

  @override
  State<CamScreen> createState() => _CamScreenState();
}

class _CamScreenState extends State<CamScreen> {
  // 아고라 엔진
  RtcEngine? _engine;

  // 내 ID, 화상 채팅 아이디 저장 변수
  // 채널 접속 전일 경우 0
  int? uid = 0;

  // 상대 ID
  int? otherUid;

  @override
  void dispose() async {
    if (_engine != null) {
      await _engine!.leaveChannel(
        options: const LeaveChannelOptions(),
      );
      _engine!.release();
    }

    uid = 0;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'LIVE',
        ),
      ),
      body: FutureBuilder<bool>(
        future: init(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    renderMainView(),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        child: renderSubView(),
                        color: Colors.grey,
                        height: 160,
                        width: 120,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ElevatedButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    '채널 나가기',
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  renderMainView() {
    // uid가 없다는 것은 채널에 입장하지 않았다.
    if (uid == null) {
      return const Center(
        child: Text(
          '채널에 참여해주세요.',
        ),
      );
    } else {
      if (_engine != null) {
        return AgoraVideoView(
          controller: VideoViewController(
            rtcEngine: _engine!,
            canvas: const VideoCanvas(
              uid: 0,
            ),
          ),
        );
      }
    }
  }

  renderSubView() {
    if (otherUid == null) {
      return const Center(
        child: Text(
          '채널에 유저가 없습니다.',
        ),
      );
    } else {
      if (_engine != null) {
        return AgoraVideoView(
          controller: VideoViewController.remote(
            rtcEngine: _engine!,
            canvas: VideoCanvas(uid: otherUid),
            connection: const RtcConnection(
              channelId: CHANNEL_NAME,
            ),
          ),
        );
      }
    }
  }

  // 카메라 마이크 권한 요청 함수
  Future<bool> init() async {
    // 카메라 권한과 마이크 권한 요청
    final resp = await [Permission.camera, Permission.microphone].request();

    // resp 에서 요청한 카메라 권한에 대한 응답 값을 받아옴
    final cameraPermission = resp[Permission.camera];

    // resp 에서 요청한 마이크 권한에 대한 응답 값을 받아옴
    final microphonePermission = resp[Permission.microphone];

    /*
    PermissionStatus 
    denied -> 권한 없음. 권한을 묻기 전 상태 
    granted -> 권한 있음.
    restricted -> ios 용 / 부분용 권한 (아이들 핸드폰에 부모가 권한 설정한 경우 )
    limited -> ios 용 / 사용자가 직접 몇 가지 권한만 허가한 경우 
    permanentlyDenied -> 권한 거절. 다시 묻기 불가능 
     */
    if (cameraPermission != PermissionStatus.granted ||
        microphonePermission != PermissionStatus.granted) {
      throw '카메라 또는 마이크 권한이 없습니다.';
    }

    // engine 생성
    if (_engine == null) {
      _engine = createAgoraRtcEngine();

      await _engine!.initialize(
        const RtcEngineContext(
          appId: APP_ID,
        ),
      );

      // 이벤트 핸들링 등록
      _engine!.registerEventHandler(
        RtcEngineEventHandler(
          // 내가 채널에 입장했을 때
          onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
            // connection -> 연결 정보
            // elapsed -> 연결된 시간 (연결된지 얼마나 됐는지)
            debugPrint(
                '채널 입장 / uid : ${connection.localUid} / ${_engine == null}');
            setState(() {
              uid = connection.localUid;
            });

            debugPrint(uid.toString());
          },

          // 채널에서 나갔을 때
          onLeaveChannel: (RtcConnection connection, RtcStats stats) {
            // stats -> 영상통화에 대한 통계 정보
            debugPrint('채널 퇴장');
            setState(() {
              uid = 0;
            });
          },

          // 상대방 유저가 들어왔을 때
          onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
            // remoteUid -> 들어온 사용자의 id
            debugPrint('상대 입장, otherUid = $remoteUid');
            setState(() {
              otherUid = remoteUid;
            });
          },

          // 상대가 나갔을 때
          onUserOffline: (connection, remoteUid, UserOfflineReasonType reason) {
            // reason
            debugPrint('상대가 나갔습니다.');
            setState(() {
              otherUid = null;
            });
          },

          onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
            debugPrint(
                '[onTokenPrivilegeWillExpire] connection: ${connection
                    .toJson()}, token: $token');
          },
        ),
      );

      // engine 구동
      await _engine!.enableVideo();
      await _engine!.startPreview();

      debugPrint('엔진 생성');
      ChannelMediaOptions options = const ChannelMediaOptions();

      await _engine!.joinChannel(
        token: TEMP_TOKEN,
        channelId: CHANNEL_NAME,
        uid: 0,
        options: options,
      );
    }
    return true;
  }

}
