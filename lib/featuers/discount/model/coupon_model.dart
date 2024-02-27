import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class CouponModel extends Equatable {
  final String code;
  final int value;
  final Timestamp expirationDate;

  const CouponModel(
      {required this.code, required this.value, required this.expirationDate});

  factory CouponModel.fromJson(Map<String, dynamic> json) => CouponModel(
        code: json['code'],
        value: json['value'],
        expirationDate: json['expirationDate'],
      );

  @override
  List<Object?> get props => [code, value, expirationDate];
}
