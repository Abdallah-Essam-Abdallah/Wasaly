import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/core/network/internet_connection.dart';
import 'package:delivery_app/core/utils/appstrings.dart';
import 'package:delivery_app/featuers/offer/model/offer_model.dart';
import 'package:equatable/equatable.dart';

part 'offers_state.dart';

class OffersCubit extends Cubit<OffersState> {
  OffersCubit() : super(OffersInitial());

  int carouselIndex = 0;

  final InternetConnection internetConnection = InternetConnection();
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future getOffers() async {
    emit(GetOffersLoadingState());
    if (await internetConnection.isInternetConnected) {
      try {
        final QuerySnapshot<Map<String, dynamic>> offersResponse =
            await firebaseFirestore.collection(AppStrings.offers).get();

        final List<OfferModel> offers = offersResponse.docs
            .map((offer) => OfferModel.fromJson(offer.data()))
            .toList();

        emit(GetOffersLoadedState(offers: offers));
      } catch (e) {
        emit(const GetOffersErrorState(error: AppStrings.unexpectedException));
      }
    } else {
      emit(const GetOffersErrorState(error: AppStrings.internetFaliureMessage));
    }
  }
}
