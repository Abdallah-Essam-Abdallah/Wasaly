import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivery_app/core/components/error_widget.dart';
import 'package:delivery_app/core/components/space_boxes.dart';
import 'package:delivery_app/core/utils/responsive.dart';
import 'package:delivery_app/featuers/groceries/presentation/screens/product_details_screen.dart';
import 'package:delivery_app/featuers/resturants/cubit/resturants_cubit.dart';
import 'package:delivery_app/featuers/resturants/model/returant_model.dart';
import 'package:delivery_app/featuers/resturants/presentation/widgets/menu_upper_widget.dart';
import 'package:delivery_app/featuers/resturants/presentation/widgets/resturants_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key, required this.resturantModel});

  final ResturantModel resturantModel;
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: ResturantsCubit()..getResturantMenu(title: resturantModel.title),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: Column(
          children: [
            MenuUpperWidget(
              resturantModel: resturantModel,
            ),
            BlocBuilder<ResturantsCubit, ResturantsState>(
              builder: (context, state) {
                if (state is GetResturantMenuLoadingState) {
                  return const Expanded(child: ResturantsLoadingWidget());
                } else if (state is GetResturantMenuLoadedState) {
                  return Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          ProductDetailsScreen(
                                            image: state.menuItems[index].image,
                                            title: state.menuItems[index].title,
                                            description: state
                                                .menuItems[index].description,
                                            price: state.menuItems[index].price,
                                            model:
                                                state.menuItems[index].toJson(),
                                          ))));
                            },
                            isThreeLine: true,
                            leading: CachedNetworkImage(
                              width: Responsive.getWidth(context) * .25,
                              imageUrl: state.menuItems[index].image,
                            ),
                            title: Text(
                              state.menuItems[index].title,
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(state.menuItems[index].description),
                                const VerticalSpace(height: .01),
                                Text('${state.menuItems[index].price} Egp'),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                        itemCount: state.menuItems.length),
                  );
                } else {
                  return const AppErrorWidget();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
