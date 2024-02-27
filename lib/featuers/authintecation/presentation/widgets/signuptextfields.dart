import 'package:auto_size_text/auto_size_text.dart';
import 'package:delivery_app/core/components/space_boxes.dart';
import 'package:delivery_app/featuers/authintecation/bloc/cubit/authintecation_cubit.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/components/text_form_field.dart';
import '../../../../core/utils/appstrings.dart';
import '../../../../core/utils/responsive.dart';
import '../screens/login_screen.dart';

class SignupTextFields extends StatefulWidget {
  const SignupTextFields({super.key});

  @override
  State<SignupTextFields> createState() => _SignupTextFieldsState();
}

class _SignupTextFieldsState extends State<SignupTextFields> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController signupEmailController = TextEditingController();

  final TextEditingController signupPasswordController =
      TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  bool isVisible = true;

  bool isVisible2 = true;

  @override
  Widget build(BuildContext context) {
    final AuthintecationCubit authintecationCubit =
        BlocProvider.of<AuthintecationCubit>(context);
    return Form(
        key: formKey,
        child: Column(
          children: [
            AppTextFormField(
              controller: nameController,
              hintText: AppStrings.name,
              prefixIcon: const Icon(Icons.text_fields),
              obscureText: false,
              keyboardType: TextInputType.name,
              validator: (name) {
                return name!.isEmpty ? AppStrings.emptyName : null;
              },
            ),
            const VerticalSpace(height: .01),
            AppTextFormField(
              controller: signupEmailController,
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
            const VerticalSpace(height: .01),
            AppTextFormField(
              controller: signupPasswordController,
              hintText: AppStrings.password,
              prefixIcon: const Icon(Icons.lock),
              maxLines: 1,
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isVisible = !isVisible;
                    });
                  },
                  icon: isVisible
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off)),
              obscureText: isVisible,
              keyboardType: TextInputType.visiblePassword,
              validator: (password) {
                if (password!.isEmpty) {
                  return AppStrings.emptyPassword;
                } else if (password.length < 8) {
                  return AppStrings.shortPassword;
                }
                return null;
              },
            ),
            const VerticalSpace(height: .01),
            AppTextFormField(
              controller: confirmPasswordController,
              hintText: AppStrings.confirmPassword,
              prefixIcon: const Icon(Icons.lock),
              maxLines: 1,
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isVisible2 = !isVisible2;
                    });
                  },
                  icon: isVisible2
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off)),
              obscureText: isVisible2,
              keyboardType: TextInputType.visiblePassword,
              validator: (password) {
                if (password!.isEmpty) {
                  return AppStrings.emptyPassword;
                } else if (password.length < 8) {
                  return AppStrings.shortPassword;
                } else if (signupPasswordController.text !=
                    confirmPasswordController.text) {
                  return AppStrings.passwordDoNotMatch;
                }
                return null;
              },
            ),
            const VerticalSpace(height: .01),
            AppTextFormField(
              controller: phoneController,
              hintText: AppStrings.phone,
              prefixIcon: const Icon(Icons.phone_android),
              obscureText: false,
              keyboardType: TextInputType.phone,
              validator: (phone) {
                return phone!.isEmpty || phone.length < 11
                    ? AppStrings.emptyPhone
                    : null;
              },
            ),
            const VerticalSpace(height: .05),
            Center(
              child: SizedBox(
                width: Responsive.getWidth(context) > 500
                    ? Responsive.getWidth(context) * .30
                    : Responsive.getWidth(context) * .50,
                height: Responsive.getHeight(context) * .05,
                child: BlocBuilder<AuthintecationCubit, AuthintecationState>(
                  builder: (context, state) {
                    return state is AuthenticationLoadingState
                        ? const Center(
                            child: CircularProgressIndicator.adaptive(),
                          )
                        : ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                authintecationCubit.signUp(
                                  email: signupEmailController.text,
                                  password: signupPasswordController.text,
                                  userName: nameController.text,
                                  phoneNumber: phoneController.text,
                                );
                              }
                            },
                            child: SizedBox(
                                width: Responsive.getWidth(context) * .40,
                                child: AutoSizeText(
                                  AppStrings.signUp,
                                  textScaleFactor:
                                      Responsive.getWidth(context) > 500
                                          ? 1.5
                                          : 1,
                                  textAlign: TextAlign.center,
                                )));
                  },
                ),
              ),
            ),
            const VerticalSpace(height: .03),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AutoSizeText(
                  AppStrings.alreadyHaveAnAccount,
                  textScaleFactor: Responsive.getWidth(context) > 500 ? 1.5 : 1,
                  maxLines: 1,
                ),
                TextButton(
                    onPressed: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const LogInScreen()))),
                    child: AutoSizeText(
                      AppStrings.login,
                      textScaleFactor:
                          Responsive.getWidth(context) > 500 ? 1.5 : 1,
                      maxLines: 1,
                    ))
              ],
            ),
          ],
        ));
  }

  @override
  void dispose() {
    signupEmailController.dispose();

    signupPasswordController.dispose();

    confirmPasswordController.dispose();

    nameController.dispose();

    phoneController.dispose();
    super.dispose();
  }
}
