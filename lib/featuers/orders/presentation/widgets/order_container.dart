import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivery_app/core/components/custom_dialog.dart';
import 'package:delivery_app/core/components/space_boxes.dart';
import 'package:delivery_app/core/utils/appstrings.dart';
import 'package:delivery_app/core/utils/dateformater.dart';
import 'package:delivery_app/core/utils/responsive.dart';
import 'package:delivery_app/featuers/orders/cubit/orders_cubit.dart';
import 'package:delivery_app/featuers/orders/model/order_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderContainer extends StatelessWidget {
  const OrderContainer({super.key, required this.orderModel});
  final OrderModel orderModel;
  @override
  Widget build(BuildContext context) {
    final OrdersCubit ordersCubit = BlocProvider.of<OrdersCubit>(context);
    return Container(
        padding: EdgeInsets.all(Responsive.getWidth(context) * .02),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          border: Border.all(
              color: const Color.fromARGB(255, 214, 212, 212), width: .5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeText(
              '${AppStrings.orderId}${orderModel.orderId}',
              style: const TextStyle(color: Colors.grey),
              maxLines: 1,
            ),
            const VerticalSpace(height: .01),
            Row(
              children: [
                Container(
                  width: Responsive.getWidth(context) * .30,
                  height: Responsive.getHeight(context) * .10,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(
                            orderModel.cartItems[0]['cartItem']['image']),
                        fit: BoxFit.fill,
                      )),
                ),
                const HorizantalSpace(width: .02),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                        'On ${DateFormater.formatPostTime(orderModel.orderTime)}'),
                    const VerticalSpace(height: .01),
                    AutoSizeText(
                        '${AppStrings.price}${orderModel.finalPrice}\$',
                        maxLines: 1),
                    const VerticalSpace(height: .01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BlocBuilder<OrdersCubit, OrdersState>(
                          builder: (context, state) {
                            return AutoSizeText(
                              orderModel.status,
                              style: TextStyle(
                                color: orderModel.status == AppStrings.submitted
                                    ? Colors.grey
                                    : orderModel.status == AppStrings.received
                                        ? Colors.amber
                                        : orderModel.status ==
                                                AppStrings.onTheWay
                                            ? Colors.orange
                                            : orderModel.status ==
                                                    AppStrings.delivered
                                                ? Colors.green
                                                : orderModel.status ==
                                                        AppStrings.canceled
                                                    ? Colors.red
                                                    : Colors.black,
                              ),
                            );
                          },
                        ),
                        Responsive.getWidth(context) > 500
                            ? const HorizantalSpace(width: .25)
                            : const HorizantalSpace(width: .06),
                        Visibility(
                          visible: orderModel.status != AppStrings.canceled,
                          child: ElevatedButton(
                              style: Theme.of(context)
                                  .elevatedButtonTheme
                                  .style!
                                  .copyWith(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color?>(
                                    const Color.fromARGB(255, 255, 57, 57),
                                  )),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return CustomDialog(
                                          content: AppStrings
                                              .cancelOrderDialogContent,
                                          title: AppStrings.cancelOrder,
                                          buttonTitle: AppStrings.cancelOrder,
                                          function: () async {
                                            await ordersCubit.cancelOrder(
                                                orderId: orderModel.orderId);
                                            ordersCubit.getOrders();
                                            if (context.mounted) {
                                              Navigator.of(context,
                                                      rootNavigator: true)
                                                  .pop();
                                            }
                                          });
                                    });
                              },
                              child: const AutoSizeText(
                                AppStrings.cancelOrder,
                              )),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ],
        ));
  }
}
