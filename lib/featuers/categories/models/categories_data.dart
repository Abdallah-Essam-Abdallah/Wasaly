import 'package:delivery_app/core/utils/appstrings.dart';
import 'package:delivery_app/featuers/groceries/presentation/screens/groceries_screen.dart';
import 'package:delivery_app/featuers/home_layout/presentation/screens/home_screen.dart';
import 'package:delivery_app/featuers/pharmacy/presentation/screens/pharmacy_screen.dart';
import 'package:delivery_app/featuers/resturants/presentation/screens/resturants_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class CategoriesData extends Equatable {
  final String title;
  final String image;

  const CategoriesData({required this.title, required this.image});

  @override
  List<Object?> get props => [title, image];
}

List<CategoriesData> categoriesData = const [
  CategoriesData(title: AppStrings.groceries, image: AppStrings.groceriesImage),
  CategoriesData(
      title: AppStrings.resturants, image: AppStrings.resturantsImage),
  CategoriesData(title: AppStrings.pharmacy, image: AppStrings.pharmacyImage),
  CategoriesData(
      title: AppStrings.specialorder, image: AppStrings.specialorderImage),
];

List<Widget> categoriesScreens = const [
  GroceriesScreen(),
  ResturantsScreen(),
  PharmacyScreen(),
  HomeScreen(),
];
