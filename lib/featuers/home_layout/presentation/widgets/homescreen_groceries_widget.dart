import 'package:delivery_app/core/components/error_widget.dart';
import 'package:delivery_app/core/components/space_boxes.dart';
import 'package:delivery_app/core/utils/responsive.dart';
import 'package:delivery_app/featuers/groceries/cubit/groceries_cubit.dart';
import 'package:delivery_app/featuers/groceries/presentation/widgets/groceries_product_card.dart';
import 'package:delivery_app/featuers/home_layout/presentation/widgets/homescreen_loading_resturants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreenGroceriesWidget extends StatelessWidget {
  const HomeScreenGroceriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: GroceriesCubit()..getGroceriesProducts(),
      child: BlocBuilder<GroceriesCubit, GroceriesState>(
        builder: (context, state) {
          if (state is GetGroceriesProductsLoadingState) {
            return const HomeScreenResturantsLoadingWidget();
          } else if (state is GetGroceriesProductsLoadedState) {
            return SizedBox(
                height: Responsive.getHeight(context) * .25,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const VerticalSpace(height: .01),
                    Expanded(
                        child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return GroceriesProductCard(
                            product: state.products[index]);
                      },
                      separatorBuilder: (context, index) {
                        return const HorizantalSpace(width: .02);
                      },
                      itemCount: 6,
                    )),
                  ],
                ));
          } else {
            return const AppErrorWidget();
          }
        },
      ),
    );
  }
}
