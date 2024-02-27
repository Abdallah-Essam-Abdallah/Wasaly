import 'package:delivery_app/core/components/space_boxes.dart';
import 'package:delivery_app/core/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreenResturantsLoadingWidget extends StatelessWidget {
  const HomeScreenResturantsLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Responsive.getHeight(context) * .15,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[400]!,
              highlightColor: Colors.grey[200]!,
              child: Container(
                height: Responsive.getHeight(context) * .25,
                width: Responsive.getWidth(context) * .25,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const HorizantalSpace(width: .01);
          },
          itemCount: 5),
    );
  }
}
