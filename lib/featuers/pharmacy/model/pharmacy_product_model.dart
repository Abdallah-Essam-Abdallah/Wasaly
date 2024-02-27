import 'package:equatable/equatable.dart';

class PharmacyProductModel extends Equatable {
  final String prescriptionImage;

  const PharmacyProductModel({required this.prescriptionImage});

  factory PharmacyProductModel.fromJson(Map<String, dynamic> json) =>
      PharmacyProductModel(
        prescriptionImage: json['prescriptionImage'],
      );

  Map<String, dynamic> toJson() => {
        'prescriptionImage': prescriptionImage,
      };

  @override
  List<Object?> get props => [prescriptionImage];
}
