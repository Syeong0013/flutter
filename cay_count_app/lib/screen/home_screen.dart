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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              const Text(
                'D-day',
                style: TextStyle(
                  fontFamily: 'noto',
                  fontSize: 80,
                ),
              ),
              const Text(
                '2022-203-02',
                style: TextStyle(
                  fontFamily: 'noto',
                  fontSize: 30,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.favorite),
              ),
              const Text(
                'D+1',
                style: TextStyle(
                  fontFamily: 'noto',
                  fontSize: 25,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
