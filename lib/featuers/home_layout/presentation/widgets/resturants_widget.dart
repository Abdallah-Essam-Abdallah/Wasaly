import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivery_app/core/components/space_boxes.dart';
import 'package:delivery_app/core/utils/responsive.dart';
import 'package:delivery_app/featuers/home_layout/presentation/widgets/homescreen_loading_resturants.dart';
import 'package:delivery_app/featuers/resturants/cubit/resturants_cubit.dart';
import 'package:delivery_app/featuers/resturants/presentation/screens/menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResturantsWidget extends StatelessWidget {
  const ResturantsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: ResturantsCubit()..getResturants(),
      child: BlocBuilder<ResturantsCubit, ResturantsState>(
        builder: (context, state) {
          if (state is GetResturantsLoadingState) {
            return const HomeScreenResturantsLoadingWidget();
          } else if (state is GetResturantsLoadedState) {
            return SizedBox(
                height: Responsive.getHeight(context) * .15,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => MenuScreen(
                                          resturantModel:
                                              state.resturants[index],
                                        ))));
                          },
                          child: Container(
                            height: Responsive.getHeight(context) * .25,
                            width: Responsive.getWidth(context) * .25,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: CachedNetworkImageProvider(
                                        state.resturants[index].image))),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const HorizantalSpace(width: .01);
                      },
                      itemCount: 5,
                    )),
                  ],
                ));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
