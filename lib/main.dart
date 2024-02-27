import 'package:delivery_app/core/bloc_observer/bloc_observer.dart';
import 'package:delivery_app/core/chache_helper/chache_helper.dart';
import 'package:delivery_app/core/theme/apptheme.dart';
import 'package:delivery_app/featuers/authintecation/bloc/cubit/authintecation_cubit.dart';
import 'package:delivery_app/featuers/authintecation/presentation/screens/login_screen.dart';
import 'package:delivery_app/featuers/cart/cubit/cart_cubit.dart';
import 'package:delivery_app/featuers/discount/cubit/discount_cubit.dart';
import 'package:delivery_app/featuers/groceries/cubit/groceries_cubit.dart';
import 'package:delivery_app/featuers/home_layout/cubit/home_layout_cubit.dart';
import 'package:delivery_app/featuers/home_layout/presentation/screens/home_layout.dart';
import 'package:delivery_app/featuers/location/cubit/location_cubit.dart';
import 'package:delivery_app/featuers/onboarding/presentation/screens/onboarding.dart';
import 'package:delivery_app/featuers/orders/cubit/orders_cubit.dart';
import 'package:delivery_app/featuers/payment/patment_constants/payment_constants.dart';
import 'package:delivery_app/featuers/profile/cubit/profile_cubit.dart';
import 'package:delivery_app/featuers/resturants/cubit/resturants_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Stripe.publishableKey = ApiKeys.publishableKey;
  await Stripe.instance.applySettings();
  await Firebase.initializeApp();
  await CacheHelper.sharedInit();
  Bloc.observer = MyBlocObserver();
  final bool isOnboardingSkipped =
      CacheHelper.getBoolean(key: 'isOnboardingSkipped') ?? false;
  final bool isLoggedIn = CacheHelper.getBoolean(key: 'isLoggedIn') ?? false;
  Widget startWidget;
  if (isOnboardingSkipped) {
    if (isLoggedIn) {
      startWidget = const HomeLayout();
    } else {
      startWidget = const LogInScreen();
    }
  } else {
    startWidget = const OnBoardingScreen();
  }
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp(
    isOnboardingSkipped: isOnboardingSkipped,
    isLoggedIn: isLoggedIn,
    startWidget: startWidget,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp(
      {super.key,
      required this.isOnboardingSkipped,
      required this.isLoggedIn,
      required this.startWidget});
  final bool isOnboardingSkipped;
  final bool isLoggedIn;
  final Widget startWidget;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthintecationCubit()),
        BlocProvider(create: (context) => HomeLayoutCubit()),
        BlocProvider(create: (context) => ResturantsCubit()),
        BlocProvider(create: (context) => GroceriesCubit()),
        BlocProvider(create: (context) => CartCubit()),
        BlocProvider(create: (context) => OrdersCubit()),
        BlocProvider(create: (context) => LocationCubit()),
        BlocProvider(create: (context) => ProfileCubit()),
        BlocProvider(create: (context) => DiscountCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: startWidget,
      ),
    );
  }
}
