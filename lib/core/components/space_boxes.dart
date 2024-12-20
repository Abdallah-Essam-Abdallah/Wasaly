import 'package:delivery_app/core/utils/responsive.dart';
import 'package:flutter/material.dart';

class VerticalSpace extends StatelessWidget {
  const VerticalSpace({super.key, required this.height});
  final double height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Responsive.getHeight(context) * height,
    );
  }
}

class HorizantalSpace extends StatelessWidget {
  const HorizantalSpace({super.key, required this.width});
  final double width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Responsive.getWidth(context) * width,
    );
  }
}
