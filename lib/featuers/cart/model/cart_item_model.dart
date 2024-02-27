import 'package:equatable/equatable.dart';

class CartItem extends Equatable {
  final Map<String, dynamic> cartItem;
  final int quantity;
  final int price;

  const CartItem(
      {required this.cartItem, required this.quantity, required this.price});

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        cartItem: json['cartItem'],
        quantity: json['quantity'],
        price: json['price'],
      );

  Map<String, dynamic> toJson() => {
        'cartItem': cartItem,
        'quantity': quantity,
        'price': price,
      };

  @override
  List<Object?> get props => [cartItem, quantity, price];
}
