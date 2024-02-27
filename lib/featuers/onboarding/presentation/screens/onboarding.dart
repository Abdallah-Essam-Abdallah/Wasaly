import 'package:auto_size_text/auto_size_text.dart';
import 'package:delivery_app/core/chache_helper/chache_helper.dart';
import 'package:delivery_app/core/components/space_boxes.dart';
import 'package:delivery_app/core/utils/appstrings.dart';
import 'package:delivery_app/core/utils/responsive.dart';
import 'package:delivery_app/featuers/authintecation/presentation/screens/login_screen.dart';
import 'package:delivery_app/featuers/onboarding/data/onboardingdata.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView.builder(
      controller: pageController,
      physics: const BouncingScrollPhysics(),
      itemCount: onBoardingData.length,
      itemBuilder: ((context, index) => SafeArea(
            child: Padding(
              padding: EdgeInsets.all(Responsive.getHeight(context) * .01),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const VerticalSpace(height: .05),
                  Lottie.asset(
                    onBoardingData[index].image,
                    width: Responsive.getWidth(context),
                    height: Responsive.getHeight(context) * .50,
                  ),
                  const VerticalSpace(height: .05),
                  Expanded(
                    child: AutoSizeText(
                      onBoardingData[index].title,
                      style: Theme.of(context).textTheme.headlineMedium,
                      maxLines: 1,
                      textScaleFactor:
                          Responsive.getWidth(context) < 500 ? 1 : 1.5,
                    ),
                  ),
                  const VerticalSpace(height: .01),
                  Expanded(
                    flex: 3,
                    child: AutoSizeText(
                      onBoardingData[index].description,
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      textScaleFactor:
                          Responsive.getWidth(context) < 500 ? 1 : 1.5,
                    ),
                  ),
                  const VerticalSpace(height: .03),
                  SmoothPageIndicator(
                    controller: pageController,
                    count: 3,
                    effect: ExpandingDotsEffect(
                        activeDotColor: const Color.fromARGB(255, 61, 103, 109),
                        dotHeight: Responsive.getHeight(context) * .02),
                  ),
                  const VerticalSpace(height: .02),
                  SizedBox(
                    width: Responsive.getWidth(context) < 500
                        ? Responsive.getWidth(context) * .50
                        : Responsive.getWidth(context) * .30,
                    height: Responsive.getHeight(context) * .06,
                    child: ElevatedButton(
                        onPressed: () {
                          index <= 1
                              ? pageController.nextPage(
                                  duration: const Duration(seconds: 1),
                                  curve: Curves.linear)
                              : {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) =>
                                              const LogInScreen()))),
                                  CacheHelper.setBoolean(
                                      key: 'isOnboardingSkipped', value: true)
                                };
                        },
                        child: AutoSizeText(
                          index <= 1 ? AppStrings.next : AppStrings.getStarted,
                          maxLines: 1,
                          textScaleFactor: 1.5,
                          style: const TextStyle(color: Colors.white),
                        )),
                  )
                ],
              ),
            ),
          )),
    ));
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
