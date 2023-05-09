import 'package:flutter/material.dart';
import 'package:navigation/layout/main_layout.dart';
import 'package:navigation/screen/route_one_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // true -> pop 가능
        // false -> pop 불가능
        final canPop = Navigator.of(context).canPop();
        return canPop;
      },
      child: MainLayout(
        title: 'Home Screen',
        children: [
          ElevatedButton(
            onPressed: () {
              print(Navigator.of(context).canPop());
              Navigator.of(context).maybePop();
            },
            child: const Text('maybe Pop'),
          ),
          ElevatedButton(
            // 다음 라우트로 이동
            onPressed: () async {
              final re = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => const RouteOneScreen(
                    number: 123,
                  ),
                ),
              );

              print(re);
            },
            child: const Text('Push'),
          )
        ],
      ),
    );
  }
}
