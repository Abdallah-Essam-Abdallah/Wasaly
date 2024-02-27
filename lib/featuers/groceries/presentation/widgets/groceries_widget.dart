import 'package:delivery_app/core/components/app_padding.dart';
import 'package:delivery_app/core/components/snack_bar.dart';
import 'package:delivery_app/core/utils/appstrings.dart';
import 'package:delivery_app/core/utils/responsive.dart';
import 'package:delivery_app/featuers/cart/cubit/cart_cubit.dart';
import 'package:delivery_app/featuers/groceries/model/groceries_product_model.dart';
import 'package:delivery_app/featuers/groceries/presentation/widgets/groceries_product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroceriesWidget extends StatelessWidget {
  const GroceriesWidget({super.key, required this.products});
  final List<GroceriesProductModel> products;
  @override
  Widget build(BuildContext context) {
    return BlocListener<CartCubit, CartState>(
      listener: (context, state) {
        if (state is AddItemToCartLoadedState) {
          showSnackBar(AppStrings.cartSuccsesMessage, context, Colors.green);
        } else if (state is AddItemToCartErrorState) {
          showSnackBar(state.error, context, Colors.red);
        }
      },
      child: AppPadding(
        width: .02,
        child: GridView.builder(
            itemCount: products.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: Responsive.getWidth(context) > 500 ? 1.5 : 1,
                mainAxisSpacing: Responsive.getHeight(context) * .01,
                crossAxisSpacing: Responsive.getWidth(context) * .02,
                crossAxisCount: Responsive.getWidth(context) > 500 ? 3 : 2),
            itemBuilder: (context, index) {
              return GroceriesProductCard(product: products[index]);
            }),
      ),
    );
  }
}
