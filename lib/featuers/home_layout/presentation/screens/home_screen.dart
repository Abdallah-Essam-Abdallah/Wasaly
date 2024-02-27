import 'package:delivery_app/core/components/app_padding.dart';
import 'package:delivery_app/core/components/space_boxes.dart';
import 'package:delivery_app/core/components/text_form_field.dart';
import 'package:delivery_app/core/utils/appstrings.dart';
import 'package:delivery_app/featuers/groceries/presentation/screens/groceries_screen.dart';
import 'package:delivery_app/featuers/home_layout/presentation/widgets/greetings_widget.dart';
import 'package:delivery_app/featuers/home_layout/presentation/widgets/homescreen_groceries_widget.dart';
import 'package:delivery_app/featuers/home_layout/presentation/widgets/resturants_widget.dart';
import 'package:delivery_app/featuers/home_layout/presentation/widgets/title_row.dart';
import 'package:delivery_app/featuers/offer/presentation/widgets/offer_widget.dart';
import 'package:delivery_app/featuers/resturants/presentation/screens/resturants_screen.dart';

import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: AppPadding(
        width: .02,
        child: Column(
          children: [
            VerticalSpace(height: .02),
            GreetingsWidget(),
            VerticalSpace(height: .01),
            AppTextFormField(
                hintText: AppStrings.search,
                obscureText: false,
                suffixIcon: Icon(
                  Icons.search,
                  color: Color.fromARGB(255, 61, 103, 109),
                ),
                keyboardType: TextInputType.text),
            VerticalSpace(height: .01),
            OffersWidget(),
            VerticalSpace(height: .01),
            TitleRow(
              screen: ResturantsScreen(),
              title: AppStrings.resturants,
            ),
            ResturantsWidget(),
            VerticalSpace(height: .01),
            TitleRow(
              screen: GroceriesScreen(),
              title: AppStrings.groceries,
            ),
            HomeScreenGroceriesWidget(),
          ],
        ),
      ),
    );
  }
}
