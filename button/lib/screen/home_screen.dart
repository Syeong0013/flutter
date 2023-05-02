import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('버튼'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              // onPressed에 null을 넣으면 비활성화 상태가 되므로 글자와 애니메이션이 안됨
              onPressed: (){},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Colors.black,
                ),
                foregroundColor: MaterialStateProperty.resolveWith(
                  /*
                  * Material State
                  *
                  * hovered - 호버링 상태
                  * focused - 포커스 상태
                  * !pressed - 눌렀을 때
                  * dragged - 드래그
                  * selected - 선택 상태 (체크박스, 라디오박스)
                  * scrollUnder - 다른 컴포넌트 밑으로 스크롤링 된 상태
                  * !disabled - 비활성화 상태
                  * error - 에러 상태
                  * */
                    (Set<MaterialState> states){
                      if(states.contains(MaterialState.pressed)){
                        return Colors.white;
                      }
                      return Colors.red;
                    }
                ),
                padding: MaterialStateProperty.resolveWith((Set<MaterialState>states) {
                  if(states.contains(MaterialState.pressed)){
                    return const EdgeInsets.all(80.0);
                  }
                  return null;
                }),
              ),
              child: const Text('Button Style'),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                // primary 는 메인 컬러라는 의미: 배경색상 제어
                primary: Colors.orange,
                // 글자색과 애니메이션 색상 제어
                onPrimary: Colors.black,
                // 그림자 색상 제어
                shadowColor: Colors.green,
                // 그림자 깊이감 제어
                elevation: 20.0,
                // 일반 글자 스타일 제어
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
                // 글자와 버튼 간 패딩
                padding: const EdgeInsets.all(25.0),
                side: const BorderSide(
                  // 테두리의 속성
                  // 색상
                  color: Colors.black,
                  // 두께
                  width: 4.0,
                ),
              ),
              child: const Text('Elevated Button'),
            ),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                // 글자와 효과의 색상 제어
                primary: Colors.green,
                // 배경색상 제어  (배경색상 제어 하려면 elevated button과 다를 것이 없음)
                backgroundColor: Colors.yellow,
              ),
              child: const Text('Outlined Button'),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                // 글자와 효과의 색상 제어
                primary: Colors.amber,
                backgroundColor: Colors.lightBlue,
              ),
              child: const Text('Text Button'),
            ),
          ],
        ),
      ),
    );
  }
}
