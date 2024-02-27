import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:delivery_app/core/components/error_widget.dart';
import 'package:delivery_app/core/components/space_boxes.dart';
import 'package:delivery_app/core/utils/appstrings.dart';
import 'package:delivery_app/core/utils/responsive.dart';
import 'package:delivery_app/featuers/offer/cubit/offers_cubit.dart';
import 'package:delivery_app/featuers/offer/presentation/screens/offer_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class OffersWidget extends StatelessWidget {
  const OffersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OffersCubit()..getOffers(),
      child: BlocBuilder<OffersCubit, OffersState>(
        builder: (context, state) {
          if (state is GetOffersLoadingState) {
            return Center(
              child: Shimmer.fromColors(
                baseColor: Colors.grey[400]!,
                highlightColor: Colors.grey[200]!,
                child: Container(
                  height: Responsive.getHeight(context) * .25,
                  width: Responsive.getWidth(context) * .90,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            );
          } else if (state is GetOffersLoadedState) {
            return SizedBox(
                height: Responsive.getHeight(context) * .28,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      AppStrings.offers,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const VerticalSpace(height: .01),
                    Expanded(
                      child: CarouselSlider.builder(
                          itemCount: state.offers.length,
                          itemBuilder: (context, index, realIndex) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            OfferDetailsScreen(
                                              offer: state.offers[index],
                                            ))));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: CachedNetworkImageProvider(
                                          state.offers[index].image,
                                        ))),
                              ),
                            );
                          },
                          options: CarouselOptions(
                            aspectRatio: Responsive.getWidth(context) / 200,
                            autoPlay: true,
                            enlargeCenterPage: true,
                            autoPlayInterval: const Duration(seconds: 2),
                          )),
                    ),
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
