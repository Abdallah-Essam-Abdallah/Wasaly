import 'package:auto_size_text/auto_size_text.dart';
import 'package:delivery_app/core/components/app_padding.dart';
import 'package:delivery_app/core/components/space_boxes.dart';
import 'package:delivery_app/core/utils/appstrings.dart';
import 'package:delivery_app/featuers/authintecation/bloc/cubit/authintecation_cubit.dart';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/snack_bar.dart';
import '../../../../core/components/text_form_field.dart';
import '../../../../core/utils/responsive.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController resetPasswordEmailController =
      TextEditingController();

  final resetPasswordFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final AuthintecationCubit authintecationCubit =
        BlocProvider.of<AuthintecationCubit>(context);
    return BlocListener<AuthintecationCubit, AuthintecationState>(
      listener: (context, state) {
        if (state is ResetPasswordLoadedState) {
          showSnackBar(AppStrings.resetPasswordSnackBar, context, Colors.green);
        } else if (state is ResetPasswordErrorState) {
          showSnackBar(state.error, context, Colors.red);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const AutoSizeText(AppStrings.resetPassword),
        ),
        body: Form(
          key: resetPasswordFormKey,
          child: AppPadding(
            width: Responsive.getWidth(context) < 500 ? .02 : .15,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: Responsive.getHeight(context) * .10,
                    child: AutoSizeText(
                      AppStrings.resetPasswordText,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineMedium,
                      maxLines: 2,
                    ),
                  ),
                  const VerticalSpace(
                    height: .03,
                  ),
                  AppTextFormField(
                    controller: resetPasswordEmailController,
                    hintText: AppStrings.email,
                    prefixIcon: const Icon(Icons.email),
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                    validator: (email) {
                      if (email!.isEmpty || !EmailValidator.validate(email)) {
                        return AppStrings.invalidEmail;
                      }
                      return null;
                    },
                  ),
                  const VerticalSpace(
                    height: .03,
                  ),
                  SizedBox(
                      height: Responsive.getHeight(context) * .05,
                      width: Responsive.getWidth(context) < 500
                          ? Responsive.getWidth(context) * .50
                          : Responsive.getWidth(context) * .30,
                      child: ElevatedButton(
                          onPressed: () {
                            if (resetPasswordFormKey.currentState!.validate()) {
                              authintecationCubit.resetPassword(
                                  email: resetPasswordEmailController.text);
                            }
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(child: Icon(Icons.email)),
                              Expanded(
                                flex: 2,
                                child: AutoSizeText(
                                  AppStrings.resetPassword,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    resetPasswordEmailController.dispose();
    super.dispose();
  }
}
