import 'package:delivery_app/core/components/space_boxes.dart';
import 'package:delivery_app/core/components/text_form_field.dart';
import 'package:delivery_app/core/utils/appstrings.dart';
import 'package:delivery_app/core/utils/responsive.dart';
import 'package:delivery_app/featuers/authintecation/bloc/cubit/authintecation_cubit.dart';
import 'package:delivery_app/featuers/authintecation/presentation/widgets/lower_login_widget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';

class LoginSharedWidget extends StatefulWidget {
  const LoginSharedWidget({super.key});

  @override
  State<LoginSharedWidget> createState() => _LoginSharedWidgetState();
}

class _LoginSharedWidgetState extends State<LoginSharedWidget> {
  final loginFormKey = GlobalKey<FormState>();

  final TextEditingController loginEmailController = TextEditingController();

  final TextEditingController loginPasswordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();

  FocusNode passwordFocusNode = FocusNode();

  StateMachineController? riveController;

  SMIInput<bool>? isChecking;
  SMIInput<double>? numLook;
  SMIInput<bool>? isHandsUp;

  SMIInput<bool>? trigSuccess;
  SMIInput<bool>? trigFail;

  bool isVisible = true;

  @override
  void initState() {
    emailFocusNode.addListener(emailFocus);
    passwordFocusNode.addListener(passwordFocus);
    super.initState();
  }

  void emailFocus() {
    isChecking?.change(emailFocusNode.hasFocus);
  }

  void passwordFocus() {
    isHandsUp?.change(passwordFocusNode.hasFocus);
  }

  @override
  Widget build(BuildContext context) {
    final AuthintecationCubit authintecationCubit =
        BlocProvider.of<AuthintecationCubit>(context);
    return Form(
        key: loginFormKey,
        child: Column(
          children: [
            SizedBox(
              height: Responsive.getHeight(context) * .35,
              width: Responsive.getWidth(context),
              child: RiveAnimation.asset(
                "assets/lotties/login-teddy.riv",
                fit: BoxFit.fitHeight,
                stateMachines: const ["Login Machine"],
                onInit: (artboard) {
                  riveController = StateMachineController.fromArtboard(
                    artboard,
                    "Login Machine",
                  );
                  if (riveController == null) return;

                  artboard.addController(riveController!);
                  isChecking = riveController?.findInput("isChecking");
                  numLook = riveController?.findInput("numLook");
                  isHandsUp = riveController?.findInput("isHandsUp");
                  trigSuccess = riveController?.findInput("trigSuccess");
                  trigFail = riveController?.findInput("trigFail");
                },
              ),
            ),
            AppTextFormField(
              focusNode: emailFocusNode,
              controller: loginEmailController,
              hintText: AppStrings.email,
              prefixIcon: const Icon(Icons.email_rounded),
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
              height: .02,
            ),
            AppTextFormField(
              focusNode: passwordFocusNode,
              controller: loginPasswordController,
              hintText: AppStrings.password,
              maxLines: 1,
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isVisible = !isVisible;
                    });
                    passwordFocusNode.unfocus();
                  },
                  icon: isVisible
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off)),
              obscureText: isVisible ? true : false,
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
            const VerticalSpace(
              height: .02,
            ),
            SizedBox(
              width: Responsive.getWidth(context),
              height: Responsive.getHeight(context) * .05,
              child: BlocConsumer<AuthintecationCubit, AuthintecationState>(
                listener: (context, state) {
                  if (state is AuthenticationErrorState) {
                    trigFail?.change(true);
                  } else if (state
                      is AuthenticationSignInWithEmailAndPassworsLoadedState) {
                    trigSuccess?.change(true);
                  }
                },
                builder: (context, state) {
                  return state is AuthenticationLoadingState
                      ? const Center(
                          child: CircularProgressIndicator.adaptive(),
                        )
                      : ElevatedButton(
                          onPressed: () {
                            emailFocusNode.unfocus();
                            passwordFocusNode.unfocus();
                            if (loginFormKey.currentState!.validate()) {
                              authintecationCubit.signInWithEmailAndPassword(
                                  email: loginEmailController.text,
                                  password: loginPasswordController.text);
                            }
                          },
                          child: Text(
                            AppStrings.login,
                            style: const TextStyle(color: Colors.white),
                            textScaleFactor:
                                Responsive.getWidth(context) > 500 ? 1.5 : 1,
                          ));
                },
              ),
            ),
            const LowerLoginWidget(),
          ],
        ));
  }

  @override
  void dispose() {
    loginEmailController.dispose();

    loginPasswordController.dispose();
    riveController!.dispose();
    emailFocusNode.removeListener(emailFocus);
    passwordFocusNode.removeListener(passwordFocus);
    super.dispose();
  }
}
