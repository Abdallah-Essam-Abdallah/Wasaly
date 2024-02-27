import 'package:equatable/equatable.dart';

class GroceriesProductModel extends Equatable {
  final String title;
  final String description;
  final String image;
  final int price;

  const GroceriesProductModel({
    required this.title,
    required this.description,
    required this.image,
    required this.price,
  });

  factory GroceriesProductModel.fromJson(Map<String, dynamic> json) =>
      GroceriesProductModel(
        title: json['title'],
        description: json['description'],
        image: json['image'],
        price: json['price'],
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'image': image,
        'price': price,
      };

  @override
  List<Object?> get props => [title, description, image, price];
}
