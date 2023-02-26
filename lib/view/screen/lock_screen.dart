import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class LockRoute extends StatelessWidget {
  PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future(() => false);
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(children: [
            Row(children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
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
            ElevatedButton(onPressed: () {
              startBioPass();
            }, child: Text('생체인증 시작!!'))
          ]),
        ),
      ),
    );
  }


  Future<void> startBioPass() async {
    print('생체인증 시도1');
    final LocalAuthentication auth = LocalAuthentication();
    // ···
    final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    final bool canAuthenticate = canAuthenticateWithBiometrics || await auth.isDeviceSupported();

    if(canAuthenticate){
      print('이게뭐징? 1');
      final List<BiometricType> availableBiometrics = await auth.getAvailableBiometrics();
      if (availableBiometrics.isNotEmpty) {
        // Some biometrics are enrolled.
        print("canAuthenticate 이건뭐지 1");

        if (availableBiometrics.contains(BiometricType.strong) ||
            availableBiometrics.contains(BiometricType.face)) {
          // Specific types of biometrics are available.
          // Use checks like this with caution!
          print("canAuthenticate 이건뭐지 2");
          try {
            final bool didAuthenticate = await auth.authenticate(localizedReason: 'Please authenticate to show account balance');
            print('오~ : $didAuthenticate');
            if(didAuthenticate){
              print('생체인증 성공');
            }else {
              print('생체인증 실패');
            }
          } on PlatformException {
            print('에러터짐 : ');
          }
        }

      }


    }else {
      print('이게뭐징? 2');
    }


  }


}
