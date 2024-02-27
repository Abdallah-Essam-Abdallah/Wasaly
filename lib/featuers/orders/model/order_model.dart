import 'package:equatable/equatable.dart';

class OrderModel extends Equatable {
  final String userName;
  final String userId;
  final String deliveryGuy;
  final String note;
  final List cartItems;
  final int finalPrice;
  final String orderId;
  final double lat;
  final double lng;
  final String status;
  final String paymentMethod;
  final String paymentStatus;
  final String orderTime;

  const OrderModel({
    required this.cartItems,
    required this.finalPrice,
    required this.lat,
    required this.lng,
    required this.userName,
    required this.status,
    required this.paymentMethod,
    required this.orderId,
    required this.paymentStatus,
    required this.userId,
    required this.deliveryGuy,
    required this.note,
    required this.orderTime,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        cartItems: json['cartItems'],
        finalPrice: json['finalPrice'],
        lat: json['lat'],
        lng: json['lng'],
        userName: json['userName'],
        status: json['status'],
        paymentMethod: json['paymentMethod'],
        orderId: json['orderId'],
        paymentStatus: json['paymentStatus'],
        userId: json['userId'],
        deliveryGuy: json['deliveryGuy'],
        note: json['note'],
        orderTime: json['orderTime'],
      );

  Map<String, dynamic> toJson() => {
        'cartItems': cartItems,
        'finalPrice': finalPrice,
        'lat': lat,
        'lng': lng,
        'userName': userName,
        'status': status,
        'paymentMethod': paymentMethod,
        'orderId': orderId,
        'paymentStatus': paymentStatus,
        'userId': userId,
        'deliveryGuy': deliveryGuy,
        'note': note,
        'orderTime': orderTime,
      };

  @override
  List<Object?> get props => [
        userName,
        cartItems,
        finalPrice,
        lat,
        lng,
        status,
        paymentMethod,
        orderId,
        paymentStatus,
        userId,
        deliveryGuy,
        note,
        orderTime
      ];
}
