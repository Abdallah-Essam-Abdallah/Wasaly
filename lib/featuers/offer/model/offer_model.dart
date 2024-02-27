import 'package:equatable/equatable.dart';

class OfferModel extends Equatable {
  final String title;
  final String description;
  final String image;
  final int price;
  final int priceAfterDiscount;

  const OfferModel(
      {required this.title,
      required this.description,
      required this.image,
      required this.price,
      required this.priceAfterDiscount});

  factory OfferModel.fromJson(Map<String, dynamic> json) => OfferModel(
        title: json['title'],
        description: json['description'],
        image: json['image'],
        price: json['price'],
        priceAfterDiscount: json['priceAfterDiscount'],
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'image': image,
        'price': price,
        'priceAfterDiscount': priceAfterDiscount,
      };

  @override
  List<Object?> get props =>
      [title, description, image, price, priceAfterDiscount];
}
