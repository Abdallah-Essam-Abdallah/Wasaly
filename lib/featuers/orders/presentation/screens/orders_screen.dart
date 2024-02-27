import 'package:delivery_app/core/components/app_padding.dart';
import 'package:delivery_app/core/components/error_widget.dart';
import 'package:delivery_app/core/components/space_boxes.dart';
import 'package:delivery_app/core/utils/appstrings.dart';
import 'package:delivery_app/featuers/orders/cubit/orders_cubit.dart';
import 'package:delivery_app/featuers/orders/presentation/widgets/empty_orders.dart';
import 'package:delivery_app/featuers/orders/presentation/widgets/order_container.dart';
import 'package:delivery_app/featuers/orders/presentation/widgets/orders_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: OrdersCubit()..getOrders(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.orders),
        ),
        body: BlocBuilder<OrdersCubit, OrdersState>(
          builder: (context, state) {
            if (state is GetOrdersLoadingState) {
              return const OrdersLoadingWidget();
            } else if (state is GetOrdersLoadedState) {
              if (state.orders.isEmpty) {
                return const EmptyOrders();
              }
              return AppPadding(
                width: .02,
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return OrderContainer(
                        orderModel: state.orders[index],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const VerticalSpace(height: .01);
                    },
                    itemCount: state.orders.length),
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
