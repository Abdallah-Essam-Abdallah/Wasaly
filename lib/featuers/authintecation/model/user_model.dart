import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class UserModel extends Equatable {
  final String userName;
  final String userId;
  final String email;
  final String phoneNumber;

  const UserModel({
    required this.userName,
    required this.userId,
    required this.email,
    required this.phoneNumber,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userName: json['displayName'],
        userId: json['userId'],
        email: json['email'],
        phoneNumber: json['phoneNumber'],
      );

  Map<String, dynamic> toJson() => {
        'displayName': userName,
        'userId': userId,
        'email': email,
        'phoneNumber': phoneNumber,
      };

  @override
  List<Object?> get props => [userName, userId, email, phoneNumber];
}
