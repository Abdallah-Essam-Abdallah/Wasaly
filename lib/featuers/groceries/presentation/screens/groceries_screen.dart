import 'package:auto_size_text/auto_size_text.dart';
import 'package:delivery_app/core/components/error_widget.dart';
import 'package:delivery_app/core/utils/appstrings.dart';
import 'package:delivery_app/featuers/groceries/cubit/groceries_cubit.dart';
import 'package:delivery_app/featuers/groceries/presentation/widgets/groceries_loading_widget.dart';
import 'package:delivery_app/featuers/groceries/presentation/widgets/groceries_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroceriesScreen extends StatelessWidget {
  const GroceriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: GroceriesCubit()..getGroceriesProducts(),
      child: Scaffold(
        appBar: AppBar(
          title: const AutoSizeText(AppStrings.groceries),
        ),
        body: BlocBuilder<GroceriesCubit, GroceriesState>(
          builder: (context, state) {
            if (state is GetGroceriesProductsLoadingState) {
              return const GroceriesLoadingWidget();
            } else if (state is GetGroceriesProductsLoadedState) {
              return GroceriesWidget(
                products: state.products,
              );
            } else {
              return const AppErrorWidget();
            }
          },
        ),
      ),
    );
  }
}
