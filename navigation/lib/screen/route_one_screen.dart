import 'package:flutter/material.dart';
import 'package:navigation/layout/main_layout.dart';

class RouteOneScreen extends StatelessWidget {
  const RouteOneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Route One',
      children: [
        //뒤로가기
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('뒤로가기 = POP'),
        ),
      ],
    );
  }
}
