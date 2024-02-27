import 'package:auto_size_text/auto_size_text.dart';
import 'package:delivery_app/core/components/space_boxes.dart';
import 'package:delivery_app/core/utils/appstrings.dart';
import 'package:delivery_app/core/utils/responsive.dart';
import 'package:delivery_app/featuers/home_layout/cubit/home_layout_cubit.dart';
import 'package:delivery_app/featuers/profile/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  final PageController pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final HomeLayoutCubit homeLayoutCubit =
        BlocProvider.of<HomeLayoutCubit>(context);
    return BlocProvider.value(
      value: ProfileCubit()..getUserData(),
      child: Scaffold(
          appBar: AppBar(
            title: BlocBuilder<HomeLayoutCubit, HomeLayoutState>(
              builder: (context, state) {
                return AutoSizeText(
                    homeLayoutCubit.appbarTitels[homeLayoutCubit.pageIndex]);
              },
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            height: Responsive.getHeight(context) <= 800
                ? Responsive.getHeight(context) * .12
                : Responsive.getHeight(context) * .07,
            clipBehavior: Clip.antiAlias,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocBuilder<HomeLayoutCubit, HomeLayoutState>(
                  builder: (context, state) {
                    return TextButton(
                      onPressed: () {
                        pageController.jumpToPage(1);
                        homeLayoutCubit.changeLayoutScreenIndex(1);
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.menu,
                            color: homeLayoutCubit.pageIndex == 1
                                ? const Color.fromARGB(255, 0, 0, 0)
                                : const Color.fromARGB(255, 206, 205, 205),
                          ),
                          const HorizantalSpace(width: .01),
                          AutoSizeText(
                            AppStrings.categories,
                            style: TextStyle(
                              color: homeLayoutCubit.pageIndex == 1
                                  ? const Color.fromARGB(255, 0, 0, 0)
                                  : const Color.fromARGB(255, 206, 205, 205),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
                BlocBuilder<HomeLayoutCubit, HomeLayoutState>(
                  builder: (context, state) {
                    return TextButton(
                      onPressed: () {
                        pageController.jumpToPage(2);
                        homeLayoutCubit.changeLayoutScreenIndex(2);
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.person,
                            color: homeLayoutCubit.pageIndex == 2
                                ? const Color.fromARGB(255, 0, 0, 0)
                                : const Color.fromARGB(255, 206, 205, 205),
                          ),
                          const HorizantalSpace(width: .01),
                          Text(
                            AppStrings.profile,
                            style: TextStyle(
                              color: homeLayoutCubit.pageIndex == 2
                                  ? const Color.fromARGB(255, 0, 0, 0)
                                  : const Color.fromARGB(255, 206, 205, 205),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          floatingActionButton: BlocBuilder<HomeLayoutCubit, HomeLayoutState>(
            builder: (context, state) {
              return FloatingActionButton(
                onPressed: () {
                  pageController.jumpToPage(0);
                  homeLayoutCubit.changeLayoutScreenIndex(0);
                },
                child: Icon(
                  Icons.home,
                  color: homeLayoutCubit.pageIndex == 0
                      ? const Color.fromARGB(255, 0, 0, 0)
                      : const Color.fromARGB(255, 206, 205, 205),
                ),
              );
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          body: PageView.builder(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return homeLayoutCubit.layoutScreens[index];
              })),
    );
  }
}
