import 'dart:math';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      fontSize: 16.0,
    );
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<int>(
            //FutureBuilder(
            //future: getNumber(),
            stream: streamNumber(),
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              // 보통의 위젯 렌더링
              if (snapshot.hasData) {
                // data가 있을 때 위젯 렌더링
              }

              if (snapshot.hasError) {
                // error가 났을 때 위젯 렌더링
              }

              // 로딩 중일 때 위젯 렌더링

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    // 'FutureBuilder',
                    'StreamBuilder',
                    style: textStyle.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 30.0,
                    ),
                  ),
                  Text(
                    'Constate: ${snapshot.connectionState}',
                    style: textStyle,
                  ),
                  Text(
                    'Data: ${snapshot.data}',
                    style: textStyle,
                  ),
                  Text(
                    'Error: ${snapshot.error}',
                    style: textStyle,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {});
                    },
                    child: const Text(
                      'setState',
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }

  Future<int> getNumber() async {
    await Future.delayed(const Duration(seconds: 3));

    final random = Random();

    // throw Exception('에러 발생!');

    return random.nextInt(100);
  }

  Stream<int> streamNumber() async* {
    for (int i = 0; i < 10; i++) {
      await Future.delayed(
        const Duration(
          seconds: 1,
        ),
      );
      yield i;
    }
  }
}
