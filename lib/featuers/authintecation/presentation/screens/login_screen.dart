import 'package:auto_size_text/auto_size_text.dart';
import 'package:delivery_app/core/chache_helper/chache_helper.dart';
import 'package:delivery_app/core/components/app_padding.dart';
import 'package:delivery_app/core/components/snack_bar.dart';
import 'package:delivery_app/core/utils/appstrings.dart';
import 'package:delivery_app/core/utils/responsive.dart';
import 'package:delivery_app/featuers/authintecation/bloc/cubit/authintecation_cubit.dart';
import 'package:delivery_app/featuers/authintecation/presentation/widgets/login_shared_widget.dart';
import 'package:delivery_app/featuers/home_layout/presentation/screens/home_layout.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD6E2EA),
      body: BlocConsumer<AuthintecationCubit, AuthintecationState>(
        listener: (context, state) {
          if (state is AuthenticationSignInWithEmailAndPassworsLoadedState) {
            CacheHelper.setBoolean(key: 'isLoggedIn', value: true);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: ((context) => const HomeLayout())),
                (route) => false);
          } else if (state is AuthenticationErrorState) {
            showSnackBar(state.error, context, Colors.red);
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: AppPadding(
              width: Responsive.getWidth(context) < 500 ? .02 : .10,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AutoSizeText(
                      AppStrings.login,
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    const LoginSharedWidget()
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
