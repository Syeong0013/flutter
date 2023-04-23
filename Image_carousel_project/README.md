배울 것들
- PageView
- Timer
- Stateful Widget
- Life Cycle

---

## PageView
스크롤 할 수 있는 위젯 

## Image.asset
fit 속성으로 사진 외 여백을 이용할 수 있음.
- BoxFit.cover: 아래 위 여백을 없애지만 좌우 사진이 잘릴 수 있음.

---

## Timer
백그라운드에서 계속해서 실행되며 메모리를 잡아먹는 위험이 있음.
해당 위젯이 죽을 때 타이머도 종료하는 명령(`dispose`)을 해주어야함.

### Controller
Timer를 제어하기 위한 controller 사용 시, timer종료 시 컨트롤러도 종료해주어야함.

---

