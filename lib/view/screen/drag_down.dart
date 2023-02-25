import 'package:flutter/material.dart';


class SecondRoute extends StatelessWidget {
  PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.down,
      key: const Key('key'),
      onDismissed: (_) => Navigator.of(context).pop(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("Image Viewer"),
          leading: IconButton(
              icon: Icon(null),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ),
        body: PageView(
          controller: pageController,
          children: [1, 2, 3, 4, 5].map((e) => getImage(e)).toList(),
        ),
      ),
    );
  }

  Image getImage(int e) {
    BoxFit fit = BoxFit.cover;

    return Image.asset('asset/img/image_$e.jpeg', fit: fit);
  }
}
