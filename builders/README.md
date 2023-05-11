# builders

## FutureBuilder

파라미터 : `future`, `builder`

### future

Future<> 타입을 리턴하는 모든 함수 가능

### builder

`future` 파라미터가 없으면 연결 none, 데이터 및 에러는 null 상태
함수이며 두번째 인자인 `snapshot`에서 다양한 데이터를 받아옴.

`snapshot.connectionState`: 연결 상태
`snapshot.data`: future의 리턴 데이터
`snapshot.error`: error 정보

`snapshot`값이 변경되면 `build` 재실행
=> `setState((){})` 함수를 실행하지 않고도 `FutureBuilder`가 자동으로 state를 관리해줌.

## 캐싱

FutureBuilder는 기존 데이터를 기억한다.

## Error

에러 발생 시 `snapshot.error`에 에러정보 전달.
`snapshot.connectionState = done`
`snapshot.data = null`

다시 에러 없이 실행되면 `snapshot.error = null`

---

## StreamBuilder
stream이 진행중일 경우, `snapshot.connectionState`에 `active` 값이 나온다.

stream의 경우 dispose()로 stream을 닫아주어야하는데 StreamBuilder는 그러한 역할도 수행해줌.
