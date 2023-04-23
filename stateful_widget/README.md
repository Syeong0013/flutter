# StatefulWidget
- 위젯은 변하지 않는 성질을 지님.
- 변경이 필요 시, 기존 위젯 삭제 후 새로운 위젯으로 대체한다.

## StatelessWidget Life Cycle
상태 관리가 불가능한 위젯
생성자 생성 후, 단 한번만 build 함수 실행

## StatefulWidget Life Cycle
상태 관리가 가능한 위젯
상태 관리가 가능하다 -> build 함수를 여러번 수행해 줄 수 있다.
`StatefulWidget` class와 `State` class로 구성

### StatefulWidget class
위젯은 변하지 않는 성질을 지녀야 하기 때문에 StatefulWidget 클래스가 그 성질을 지님
`StatelessWidget`은 생성자 생성 후 `build`메서드가 실행되지만, `StatefulWidget`은 `createState`라는 메서드가 실행

### State class
변하지 않는 성질을 가진 위젯의 상태 관리를 하는 역할
`build`메서드를 포함하고 있어 여러번 빌드 수행을 할 수 있도록 하는 역할

---

## StatefulWidget 생성 시 Life Cycle
1. 새로운 `Stateful Widget` 생성
2. `createState` 함수 실행
3. `initState` 함수 실행
4. `didUpdateWidget` 함수 실행
5. `build` 함수 실행

---

## 파라미터 변경 시 Life Cycle
1. 새로운 `Stateful Widget` 생성 (`createState` 메서드 미실행)
2. 기존 위젯과 연관되어있는 `State`를 찾아 연결
3. `didUpdateWidget` 함수 실행
4. `build` 함수 실행

---

## setState 실행 시 Life Cycle
`StatefulWidget` 변경 없이 `setState`함수를 실행하여 `build` 재실행

### setState 함수 
`State` class에서 제공해주는 함수
실행 시 `build` 실행