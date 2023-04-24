import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.getAlphaFromOpacity('0xFFABABAB'),
      body: SafeArea(
        bottom: false,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              _TopPart(),
              _BottomPart(),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopPart extends StatelessWidget {
  const _TopPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(
            'D-day',
            style: TextStyle(
              fontFamily: 'noto',
              fontSize: 80,
            ),
          ),
          const Text(
            '2022.03.02',
            style: TextStyle(
              fontFamily: 'noto',
              fontSize: 30,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite),
            iconSize: 60.0,
            color: Colors.red,
          ),
          const Text(
            'D+1',
            style: TextStyle(
              fontFamily: 'noto',
              fontSize: 35,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomPart extends StatelessWidget {
  const _BottomPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Image.asset('asset/img/image.jpg'),
    );
  }
}
