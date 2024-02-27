import 'package:auto_size_text/auto_size_text.dart';
import 'package:delivery_app/core/chache_helper/chache_helper.dart';
import 'package:delivery_app/core/components/app_padding.dart';
import 'package:delivery_app/core/components/snack_bar.dart';
import 'package:delivery_app/core/components/space_boxes.dart';
import 'package:delivery_app/core/utils/appstrings.dart';
import 'package:delivery_app/core/utils/responsive.dart';
import 'package:delivery_app/featuers/authintecation/bloc/cubit/authintecation_cubit.dart';
import 'package:delivery_app/featuers/authintecation/presentation/screens/verifyemail_screen.dart';
import 'package:delivery_app/featuers/authintecation/presentation/widgets/signuptextfields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocConsumer<AuthintecationCubit, AuthintecationState>(
          listener: (context, state) {
            if (state is AuthenticationSignUpLoadedState) {
              CacheHelper.setBoolean(key: 'isLoggedIn', value: true);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const VerifyEmailScreen())));
            } else if (state is AuthenticationErrorState) {
              showSnackBar(state.error, context, Colors.red);
            }
          },
          builder: (context, state) {
            return SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: AppPadding(
                  width: Responsive.getWidth(context) > 500 ? .25 : .02,
                  child: Column(children: [
                    const VerticalSpace(height: .01),
                    SizedBox(
                      width: Responsive.getWidth(context) * .50,
                      child: AutoSizeText(
                        AppStrings.signUp,
                        style: Theme.of(context).textTheme.headlineMedium,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const VerticalSpace(height: .03),
                    const SignupTextFields(),
                  ]),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
