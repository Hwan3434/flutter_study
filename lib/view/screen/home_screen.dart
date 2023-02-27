import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'drag_down.dart';
import 'lock_screen.dart';

String homeUrl = 'https://blog.codefactory.ai';

class HomeScreen3 extends StatefulWidget {
  const HomeScreen3({Key? key}) : super(key: key);

  @override
  State<HomeScreen3> createState() => _HomeScreen3State();
}

class _HomeScreen3State extends State<HomeScreen3> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        print("resumed");
        break;
      case AppLifecycleState.inactive:
        print("inactive");
        // 현재 잠금화면이면 호출하지않도록 해야함
        // 생체인증시작하면 일로 올라온다. 참고해서 잘 하도록 !
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext buidlerContext) {
              return LockRoute();
            },
          ),
        );
        break;
      case AppLifecycleState.detached:
        print("detached");
        break;
      case AppLifecycleState.paused:
        print("paused");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return HomeScreen2();
  }
}

class HomeScreen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sample Main Home'),
      ),
      body: Container(
        margin: EdgeInsets.only(right: 8, left: 8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(8),
                    child: ElevatedButton(
                      child: _myWidget(context,
                          btnTitle: 'Image Viewer Sample',
                          wordToStyle: 'e viewer',
                          wordStyle: TextStyle(
                            color: Colors.red,
                            backgroundColor: Colors.amberAccent,
                          )),
                      onPressed: () {
                        showGeneralDialog(
                          barrierLabel: "Label",
                          barrierDismissible: false,
                          barrierColor: Colors.black.withOpacity(0.5),
                          context: context,
                          pageBuilder: (context, anim1, anim2) {
                            return SecondRoute();
                          },
                          transitionBuilder: (context, anim1, anim2, child) {
                            return SlideTransition(
                              position:
                                  Tween(begin: Offset(0, 1), end: Offset(0, 0))
                                      .animate(anim1),
                              child: child,
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(8),
                    child: ElevatedButton(
                      child: _myWidget(context,
                          btnTitle: 'power start LockScreen',
                          wordToStyle: 'lockscreen',
                          wordStyle: TextStyle(
                            color: Colors.green,
                            backgroundColor: Colors.white,
                          )),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext buidlerContext) {
                              return LockRoute();
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            SelectableText('selsection text masking',
                showCursor: false, cursorColor: Colors.yellow,
            onSelectionChanged: (TextSelection selection, SelectionChangedCause? cause) {
              print('ㅋㅋㅋ : ${selection.toString()}');
            },)
          ],
        ),
      ),
    );
  }

  Widget _myWidget(BuildContext context,
      {required String btnTitle,
      required String wordToStyle,
      required TextStyle wordStyle}) {
    final spans = _getSpans(btnTitle, wordToStyle, wordStyle);

    return RichText(
      text: TextSpan(
        children: spans,
      ),
    );
  }

  List<TextSpan> _getSpans(String text, String matchWord, TextStyle style) {
    List<TextSpan> spans = [];
    int spanBoundary = 0;

    do {
      // 전체 String 에서 키워드 검색
      final startIndex =
          text.toLowerCase().indexOf(matchWord.toLowerCase(), spanBoundary);

      // 전체 String 에서 해당 키워드가 더 이상 없을때 마지막 KeyWord부터 끝까지의 TextSpan 추가
      if (startIndex == -1) {
        spans.add(TextSpan(text: text.substring(spanBoundary)));
        return spans;
      }

      // 전체 String 사이에서 발견한 키워드들 사이의 text에 대한 textSpan 추가
      if (startIndex > spanBoundary) {
        print(text.substring(spanBoundary, startIndex));
        spans.add(TextSpan(text: text.substring(spanBoundary, startIndex)));
      }

      // 검색하고자 했던 키워드에 대한 textSpan 추가
      final endIndex = startIndex + matchWord.length;
      final spanText = text.substring(startIndex, endIndex);
      spans.add(TextSpan(text: spanText, style: style));

      // mark the boundary to start the next search from
      spanBoundary = endIndex;

      // continue until there are no more matches
    }
    //String 전체 검사
    while (spanBoundary < text.length);

    return spans;
  }
}

class HomeScreen extends StatelessWidget {
  WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse(homeUrl));

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('CodeFactory'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              controller.loadRequest(Uri.parse(homeUrl));
            },
            icon: Icon(Icons.home),
          )
        ],
      ),
      body: Center(
          child: WebViewWidget(
        controller: controller,
      )
          // WebView(
          //   onWebViewCreated: (WebViewController controller) {
          //     this.controller = controller;
          //   },
          //   initialUrl: homeUrl,
          //   javascriptMode: JavascriptMode.unrestricted,
          // ),
          ),
    );
  }
}
