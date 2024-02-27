import 'package:bloc/bloc.dart';
import 'package:delivery_app/core/network/internet_connection.dart';
import 'package:delivery_app/core/utils/appstrings.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitial());

  final InternetConnection internetConnection = InternetConnection();
  CameraPosition? cameraInitialPosition;
  Set<Marker>? markers;
  LatLng? dragPosition;
  late Position currentPosition;
  final geolocator = Geolocator();

  Future<void> getCurrentPosition() async {
    if (await internetConnection.isInternetConnected) {
      emit(GetLocationInitialState());
      LocationPermission permission;

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          emit(const GetLocationErrorState(
              error: AppStrings.permissionDenidMsg));
        }
      }

      if (permission == LocationPermission.deniedForever) {
        emit(const GetLocationErrorState(
            error: AppStrings.permissionDenidForeverMsg));
      }

      try {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        cameraInitialPosition = CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 15,
        );
        markers = {
          Marker(
            markerId: const MarkerId(AppStrings.markerId),
            position:
                dragPosition ?? LatLng(position.latitude, position.longitude),
            draggable: true,
            onDragEnd: (value) {
              dragPosition = value;
              print(dragPosition);
            },
          ),
        };
        currentPosition = position;
        emit(GetLocationSuccessState(currentPosition: position));
      } catch (error) {
        emit(const GetLocationErrorState(
            error: AppStrings.getPossitionErrorMsg));
      }
    } else {
      emit(const GetLocationErrorState(
          error: AppStrings.internetFaliureMessage));
    }
  }

/*void convertCordinatesToAdress({
 required double lat,
    required double lng,
})async{
final placeMark = await Geocoder
}*/
  /*CameraPosition getCameraPosition({
   
  }) {
    return 
  }*/
}
