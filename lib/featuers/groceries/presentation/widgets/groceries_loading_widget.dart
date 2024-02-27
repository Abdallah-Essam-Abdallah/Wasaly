import 'package:delivery_app/core/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class GroceriesLoadingWidget extends StatelessWidget {
  const GroceriesLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: 10,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: Responsive.getWidth(context) > 500 ? 1.5 : 1,
            mainAxisSpacing: Responsive.getHeight(context) * .01,
            crossAxisSpacing: Responsive.getWidth(context) * .02,
            crossAxisCount: Responsive.getWidth(context) > 500 ? 3 : 2),
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[400]!,
            highlightColor: Colors.grey[200]!,
            child: Container(
              height: Responsive.getHeight(context) * .20,
              width: Responsive.getWidth(context) * .45,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          );
        });
  }
}
