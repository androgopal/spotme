import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:spotme/Screens/UserProfile/models/profile_model.dart';



class ApiService {
  late DatabaseReference _usersRef;
  late DatabaseReference _messagesRef;
  late StreamSubscription<DatabaseEvent> _counterSubscription;
  late StreamSubscription<DatabaseEvent> _messagesSubscription;
  static final _authFB = FirebaseAuth.instance;
  bool USE_DATABASE_EMULATOR = true;
  int emulatorPort = 9000;
// so let's use that if running on Android.
  final emulatorHost =
  (!kIsWeb && defaultTargetPlatform == TargetPlatform.android)   ? '10.0.2.2'  : 'localhost';
  static final shared = ApiService();

  @override
  void initState() {
    _usersRef = FirebaseDatabase.instance.ref('users');
    final database = FirebaseDatabase.instance;
    _messagesRef = database.ref('messages');
    database.setLoggingEnabled(false);
  }

  void createUser(ProfileModel? model) async{
    if (model?.phone != null) {
      DatabaseReference ref = FirebaseDatabase.instance.ref("users/${model!.phone}");
      await ref.set( model?.toJson());
      readUserData(model?.phone);
    }
  }

  void updateUser(ProfileModel model) async{
    if (model?.phone != null) {
      DatabaseReference ref = FirebaseDatabase.instance.ref("users/${model!.phone}");
      await ref.set( model?.toJson());
      readUserData(model?.phone);
    }
  }

  Future<ProfileModel?> readUserData(String? phoneNumber)async{
    User? user = _authFB.currentUser;
    String? number = phoneNumber ?? _authFB.currentUser?.phoneNumber;
    if (number != null) {
      final ref = FirebaseDatabase.instance.ref();
      final snapshot = await ref.child('users/${user!.phoneNumber}').get();
      if (snapshot.exists) {

        Map<String, dynamic> targetMap = {};

        if (snapshot.exists) {
           var values = snapshot.value as Map<Object?,Object?>;

           Map<String, dynamic> transformedMap = {};

            values.forEach((key, value) {
             transformedMap[key.toString()] = value;
          });
           print("parseData ${transformedMap}");
           ProfileModel.fromJson(transformedMap);
        } else {
          print('No data available.');
          return null;
        }
        // return ProfileModel.fromJson(snapshot.value as Map<String, dynamic> );
        // print('user record fetched .');
      } else {
        print('No data available.');
        createUser(ProfileModel(phone:user!.phoneNumber ));
        return null;
      }
    }
    else{
      print('Mobile number is not found');
     }
    return null;
  }

  void readBannersData()async{
        final ref = FirebaseDatabase.instance.ref();
      final snapshot = await ref.child('banners').get();
      if (snapshot.exists) {
        print(snapshot.value);
      } else {
        print('No data available.');
      }
    }

  void createBannersData() async{
    User? user = _authFB.currentUser;

      DatabaseReference ref = FirebaseDatabase.instance.ref("banners/");
      await ref.set( [
        {
          "title":"Spot Near ",
          "description":"Connect with near and get solutions around ",
          "image":"https://firebasestorage.googleapis.com/v0/b/spotme-a7701.appspot.com/o/landing1.png?alt=media&token=d6e1ce3a-f1a3-4de1-8899-edb707c31c2a"
        },
        {
          "title":"connect ",
          "description":"Connect and discuss the possibilities and needs",
          "image":"https://firebasestorage.googleapis.com/v0/b/spotme-a7701.appspot.com/o/landing2.png?alt=media&token=513298f6-696b-45df-be1c-0ea167a24042"
        }
      ] );
  }

  void logoutUser() async{
    _authFB.signOut();
  }

}