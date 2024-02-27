import 'package:delivery_app/core/utils/responsive.dart';
import 'package:flutter/material.dart';

class AppPadding extends StatelessWidget {
  const AppPadding({super.key, required this.width, required this.child});
  final double width;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Responsive.getWidth(context) * width),
      child: child,
    );
  }
}
