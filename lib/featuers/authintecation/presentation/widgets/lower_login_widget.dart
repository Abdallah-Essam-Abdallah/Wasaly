import 'package:auto_size_text/auto_size_text.dart';
import 'package:delivery_app/core/components/space_boxes.dart';
import 'package:delivery_app/core/utils/appstrings.dart';
import 'package:delivery_app/core/utils/responsive.dart';
import 'package:delivery_app/featuers/authintecation/presentation/screens/reset_password_screen.dart';
import 'package:delivery_app/featuers/authintecation/presentation/screens/signup_screen.dart';
import 'package:flutter/material.dart';

class LowerLoginWidget extends StatelessWidget {
  const LowerLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const VerticalSpace(
          height: .02,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) =>
                                const ResetPasswordScreen())));
                  },
                  child: AutoSizeText(
                    AppStrings.forgotPassword,
                    textScaleFactor:
                        Responsive.getWidth(context) > 500 ? 1.5 : 1,
                  )),
            )
          ],
        ),
        const VerticalSpace(
          height: .10,
        ),
        SizedBox(
          width: Responsive.getWidth(context) > 500
              ? Responsive.getWidth(context) * .50
              : Responsive.getWidth(context) * .80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              AutoSizeText(
                AppStrings.dontHaveAnAccount,
                maxLines: 1,
                textScaleFactor: Responsive.getWidth(context) > 500 ? 1.5 : 1,
              ),
              TextButton(
                  onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const SignUpScreen()))),
                  child: AutoSizeText(
                    AppStrings.signUp,
                    maxLines: 1,
                    textScaleFactor:
                        Responsive.getWidth(context) > 500 ? 1.5 : 1,
                  ))
            ],
          ),
        )
      ],
    );
  }
}
