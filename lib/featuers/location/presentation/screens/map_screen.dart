import 'package:auto_size_text/auto_size_text.dart';
import 'package:delivery_app/core/components/custom_dialog.dart';
import 'package:delivery_app/core/utils/appstrings.dart';
import 'package:delivery_app/core/utils/responsive.dart';
import 'package:delivery_app/featuers/location/cubit/location_cubit.dart';
import 'package:delivery_app/featuers/payment/presentation/screens/payment_methods_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen(
      {super.key, required this.cartItems, required this.totalPrice});
  final List<Map<String, dynamic>> cartItems;
  final int totalPrice;
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: LocationCubit()..getCurrentPosition(),
      child: Scaffold(
        appBar: AppBar(
          title: const AutoSizeText(AppStrings.location),
        ),
        body: BlocConsumer<LocationCubit, LocationState>(
          listener: (context, state) {
            if (state is GetLocationErrorState) {
              final LocationCubit locationCubit =
                  BlocProvider.of<LocationCubit>(context);
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return CustomDialog(
                        content: state.error,
                        title: AppStrings.error,
                        buttonTitle: AppStrings.getLocation,
                        function: () async {
                          Navigator.of(context, rootNavigator: true).pop();
                          await locationCubit.getCurrentPosition();
                        });
                  });
            }
          },
          builder: (context, state) {
            final locationCubit = BlocProvider.of<LocationCubit>(context);
            if (state is GetLocationInitialState) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else if (state is GetLocationSuccessState) {
              return Stack(
                // alignment: Alignment.bottomCenter,
                children: [
                  SizedBox(
                    height: Responsive.getHeight(context),
                    child: GoogleMap(
                      mapType: MapType.normal,
                      markers: locationCubit.markers!,
                      initialCameraPosition:
                          locationCubit.cameraInitialPosition!,
                      onMapCreated: (GoogleMapController controller) {
                        mapController = controller;
                      },
                    ),
                  ),
                  // const Spacer(),
                  Positioned(
                    bottom: Responsive.getHeight(context) * .01,
                    right: Responsive.getWidth(context) * .20,
                    left: Responsive.getWidth(context) * .20,
                    child: SizedBox(
                        width: Responsive.getWidth(context) > 500
                            ? Responsive.getWidth(context) * .30
                            : Responsive.getWidth(context) * .50,
                        height: Responsive.getHeight(context) * .05,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          PaymentMethodsScreen(
                                            cartItems: widget.cartItems,
                                            totalPrice: widget.totalPrice,
                                            lat: locationCubit
                                                    .dragPosition?.latitude ??
                                                locationCubit
                                                    .currentPosition.latitude,
                                            lng: locationCubit
                                                    .dragPosition?.longitude ??
                                                locationCubit
                                                    .currentPosition.latitude,
                                          ))));
                            },
                            child: const AutoSizeText(
                              AppStrings.confirmlocation,
                              textScaleFactor: 1.5,
                            ))),
                  )
                ],
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}

//API KEY:AIzaSyAysRtS4JJSyINt9CcdsiCHAFJKi4zcgC0
//maps api key:AIzaSyDEb2wXfw_IWiBf-DTl9xazuGCwxM_0SdA