import 'package:flutter/material.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget? mediumScreen;
  final Widget? smallScreen;

  const ResponsiveWidget({Key? key, this.smallScreen, this.mediumScreen})
      : super(key: key);

  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 800;
  }

  static bool isMediumScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= 800 &&
        MediaQuery.of(context).size.width <= 1200;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth <= 1200 && constraints.maxWidth >= 800) {
        return mediumScreen ?? Container();
      } else {
        return smallScreen ?? Container();
      }
    });
  }
}
