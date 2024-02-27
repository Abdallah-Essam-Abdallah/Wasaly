import 'package:equatable/equatable.dart';

class ResturantModel extends Equatable {
  final String title;
  final String category;
  final String deliveryTime;
  final String image;
  final String rating;

  const ResturantModel(
      {required this.title,
      required this.category,
      required this.deliveryTime,
      required this.image,
      required this.rating});

  factory ResturantModel.fromJson(Map<String, dynamic> json) => ResturantModel(
        title: json['title'],
        category: json['category'],
        deliveryTime: json['deliveryTime'],
        image: json['image'],
        rating: json['rating'],
      );

  @override
  List<Object?> get props => [title, category, deliveryTime, image, rating];
}
