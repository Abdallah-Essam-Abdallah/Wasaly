import 'package:delivery_app/core/components/app_padding.dart';
import 'package:delivery_app/core/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class OrdersLoadingWidget extends StatelessWidget {
  const OrdersLoadingWidget({super.key});

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
                height: Responsive.getHeight(context) * .15,
                width: Responsive.getWidth(context),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider();
          },
          itemCount: 5),
    );
  }
}
