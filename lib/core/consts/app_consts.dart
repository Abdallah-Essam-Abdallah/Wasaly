import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/core/network/internet_connection.dart';

abstract class AppConsts {
  static final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  static final InternetConnection internetConnection = InternetConnection();
}
