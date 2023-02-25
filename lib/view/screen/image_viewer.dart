import 'dart:async';

import 'package:flutter/material.dart';

class ImageViewerScreen extends StatefulWidget {
  const ImageViewerScreen({Key? key}) : super(key: key);

  @override
  State<ImageViewerScreen> createState() => _ImageViewerScreenState();
}

class _ImageViewerScreenState extends State<ImageViewerScreen> {

  PageController pageController = PageController(
    initialPage: 0
  );
  Timer? timer;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    timer = Timer.periodic(Duration(seconds: 1), (timer) { 
      if(pageController != null){
        int cureent = pageController.page!.toInt();
        int next = (cureent + 1);
        if(next > 4){
          next = 0;
        }
        pageController.animateToPage(
            next,
            duration: Duration(milliseconds: 400),
            curve: Curves.linear);
      }

    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: [1,2,3,4,5].map((e) =>
          getImage(e)
        ).toList(),
      ),
    );
  }


  Image getImage(int e){

    BoxFit fit = BoxFit.contain;

    if(e % 2 == 0){
      fit = BoxFit.cover;
    }

    return Image.asset('asset/img/image_$e.jpeg',
        fit: fit);
  }


}
