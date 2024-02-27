import 'package:delivery_app/core/components/app_padding.dart';
import 'package:delivery_app/core/components/space_boxes.dart';
import 'package:delivery_app/core/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CartLoadingWidget extends StatelessWidget {
  const CartLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPadding(
      width: .02,
      child: ListView.separated(
          itemBuilder: (context, index) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[400]!,
              highlightColor: Colors.grey[200]!,
              child: Container(
                height: Responsive.getHeight(context) * .10,
                width: Responsive.getWidth(context),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const VerticalSpace(height: .02);
          },
          itemCount: 5),
    );
  }
}
