import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // 핸드폰 상태바 영역 지킴이
        bottom: false, // iphone은 적용 전후 차이 유
        child: Container(
          color: Colors.black,
          // height: MediaQuery.of(context).size.height, // 핸드폰 사양가져오기
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    color: Colors.red,
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    color: Colors.orange,
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    color: Colors.yellow,
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    color: Colors.green,
                  ),
                ],
              ),
              Container(
                width: 50,
                height: 50,
                color: Colors.orange,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    color: Colors.red,
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    color: Colors.orange,
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    color: Colors.yellow,
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    color: Colors.green,
                  ),
                ],
              ),
              Container(
                width: 50,
                height: 50,
                color: Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
