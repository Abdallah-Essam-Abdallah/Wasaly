import 'package:auto_size_text/auto_size_text.dart';
import 'package:delivery_app/core/components/space_boxes.dart';
import 'package:delivery_app/core/utils/appstrings.dart';
import 'package:delivery_app/core/utils/responsive.dart';
import 'package:flutter/material.dart';

class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error,
            color: Colors.red,
            size: Responsive.getWidth(context) * .10,
          ),
          const VerticalSpace(height: .01),
          AutoSizeText(
            AppStrings.unexpectedException,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
            maxLines: 2,
          )
        ],
      ),
    );
  }
}
