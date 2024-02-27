import 'package:auto_size_text/auto_size_text.dart';
import 'package:delivery_app/core/components/app_padding.dart';
import 'package:delivery_app/core/utils/appstrings.dart';
import 'package:delivery_app/core/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyOrders extends StatelessWidget {
  const EmptyOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPadding(
      width: .01,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: Responsive.getHeight(context) * .05,
          ),
          Lottie.asset(
            'assets/lotties/empty_box.json',
            fit: BoxFit.fill,
            height: Responsive.getHeight(context) * .50,
          ),
          SizedBox(
            height: Responsive.getHeight(context) * .03,
          ),
          Expanded(
            child: AutoSizeText(
              AppStrings.emptyOrders,
              style: Theme.of(context).textTheme.headlineMedium,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}