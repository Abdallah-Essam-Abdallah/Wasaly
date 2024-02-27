import 'package:auto_size_text/auto_size_text.dart';
import 'package:delivery_app/core/utils/appstrings.dart';
import 'package:flutter/material.dart';

class TitleRow extends StatelessWidget {
  const TitleRow({super.key, required this.screen, required this.title});
  final Widget screen;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AutoSizeText(
          title,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        TextButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: ((context) => screen)));
            },
            child: const Row(
              children: [
                AutoSizeText(AppStrings.seeMore),
                Icon(Icons.arrow_forward_ios_outlined)
              ],
            )),
      ],
    );
  }
}
