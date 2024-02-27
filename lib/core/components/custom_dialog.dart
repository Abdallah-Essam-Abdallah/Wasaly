import 'package:delivery_app/core/utils/appstrings.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String content;
  final Function()? function;
  final String? buttonTitle;

  const CustomDialog({
    required this.content,
    required this.title,
    super.key,
    this.function,
    this.buttonTitle,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: Text(
        title,
      ),
      content: Text(
        content,
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
            child: const Text(
              AppStrings.close,
            )),
        TextButton(
            onPressed: function,
            child: Text(
              buttonTitle ?? '',
            ))
      ],
    );
  }
}
