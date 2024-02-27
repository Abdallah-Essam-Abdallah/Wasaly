import 'package:bloc/bloc.dart';
import 'package:delivery_app/core/utils/appstrings.dart';
import 'package:delivery_app/featuers/categories/presentation/categoris_widget.dart';
import 'package:delivery_app/featuers/home_layout/presentation/screens/home_screen.dart';
import 'package:delivery_app/featuers/profile/presentation/screens/profile_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'home_layout_state.dart';

class HomeLayoutCubit extends Cubit<HomeLayoutState> {
  HomeLayoutCubit() : super(HomeLayoutInitial());

  int pageIndex = 0;

  final List<Widget> layoutScreens = const [
    HomeScreen(),
    CategoriesWidget(),
    ProfileScreen()
  ];

  final List<String> appbarTitels = [
    AppStrings.home,
    AppStrings.categories,
    AppStrings.profile,
  ];

  void changeLayoutScreenIndex(int index) {
    emit(ChangeLayoutScreenIndexInitialLayoutState());
    pageIndex = index;
    emit(ChangeLayoutScreenIndexLayoutState());
  }
}
