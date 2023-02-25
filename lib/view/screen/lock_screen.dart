import 'package:flutter/material.dart';

class LockRoute extends StatelessWidget {
  PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Row(children: [
            GestureDetector(
              onTap: () {
                print('1');
              },
              child: Container(
                width: 50,
                height: 50,
                color: Colors.red,
                child: Center(
                  child: Text('1'),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                print('2');
              },
              child: Container(
                width: 50,
                height: 50,
                child: Center(
                  child: Text('2'),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                print('3');
              },
              child: Container(
                width: 50,
                height: 50,
                child: Center(
                  child: Text('3'),
                ),
              ),
            ),
          ]),
        ]),
      ),
    );
  }
}
