#### layout을 이용한 중복제거

#### Text는 Column이 strech가 되어있어도 왼쪽에서부터 적힘

---

# navigation - 화면 간 값 전달

## 1. push(), pop()을 이용한 값 전달

### push()

HomeScreen에서 RouteOneScreen으로 화면 이동할 때 값을 전달하는 방법

1. RouteOneScreen에 인자 선언
2. HomeScreen에서 push할 때 전달할 값 입력

```dart
Navigator.of(context).push(
             MaterialPageRoute(
               builder: (BuildContext context) => const RouteOneScreen(
                 number: 123,
               ),
             ),
           );
```

### pop()

`push()`로 이동한 RouteOneScreen에서 `pop()`을 이용해 HomeScreen으로 돌아올 때 값 전달 방법

```dart
Navigator.of(context).pop(456);
```

## 2. settings 이용하기

RouteOneScreen 에서 RouteTwoScreen으로 이동 시 `settings`를 이용하여 값 전달

```dart
Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const RouteTwoScreen(),
                settings: const RouteSettings(
                  arguments: 789,
                ),
              ),
            );
```

RouteTwoScreen에서는 `build`안에 arg 변수를 선언하고 사용함.

```dart
final arg = ModalRoute.of(context)!.settings.arguments;
```

---

## 3. Named Route

web 과 같은 형식
`main.dart`에 `HomeScreen()`을 지정하는 것이 아닌 `routes`를 이용해 route를 지정하는 방식.

### `routes`

맵 형식으로 도메인 값인 키와 빌더 값을 가진다.

### `initialRoute`

처음 앱 실행 시 로딩되는 페이지 지정

### 페이지 이동 시 인자 전달 방법

```dart
Navigator.of(context).pushNamed(
              '/three',
              arguments: 999,
            );
```

---

## 4. replace

### `pushReplacement` / `pushReplacementNamed`

스택에 쌓인 현재 스크린을 지우고 이동한 스크린을 저장.
뒤로가기 했을 때 전 전의 화면으로 이동.

## 5. `pushAndRemoveUntil` / `pushNamedAndRemoveUntil`

두번째 인자 `true/false`에 따라 기존 스택의 모든 화면을 보존/삭제한다.

```dart
Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (_) => const RouteThreeScreen(),
              ),
              (route) => true,
            );
```

또는 조건을 통해 특정 화면만 남기는 게 가능하다.

```dart
(route) => route.settings.name == '/'
```

로 설정한다면 `Pop` 버튼을 눌렀을 때 홈스크린으로 이동한다.

---

## 5. maybePop()

Route 스택에 뒤로 이동할 페이지가 없을 경우 동작하지 않음.

## 6. canPop()

현재 뒤로가기가 가능할 지 여부를 반환
`maybePop`은 `canPop()`이 `true`일 경우에만 실행된다.

## 7. WillPopScope Widget

홈 화면에서 뒤로가기 눌렀을 때, 앱이 종료되는 현상을 방지하기 위함.
`onWillPop`에 `async`로 참 또는 거짓을 반환하여야 한다.
true일 경우, Pop 가능
false일 경우, Pop 불가능

---

화면 이동은 스택구조로 쌓인다.
[HomeScreen(), RouteOneScreen(), RouteTwoScreen()]
오른쪽 방향으로 쌓이고 왼쪽 방향으로 삭제된다.
