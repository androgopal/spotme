import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotme/HttpServices/HttpService.dart';
import 'package:spotme/Screens/Chats/ChaUserList.dart';
import 'package:spotme/Screens/LandingPage/LandingPage.dart';
import 'package:spotme/Screens/MobileLogin/Bloc/authBloc.dart';
import 'package:spotme/Screens/MobileLogin/Bloc/authState.dart';
import 'package:spotme/Screens/UserProfile/Bloc/profile_bloc.dart';
import 'package:spotme/utils/TextStyle.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Future.delayed(Duration(seconds: 2), () {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ApiService.shared.readBannersData();
    return BlocProvider(
      create: (context) => AuthCubit(),
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(fontFamily: FontName.simplified,
                useMaterial3: true),
            home:   BlocBuilder<AuthCubit, AuthState>(
              buildWhen: (oldstate, newstate) {
                return oldstate is AuthInitialState;
              },
              builder: (context, state) {
                if (state is AuthLoggedInState) {
                  return ChatUserList();
                } else if (state is AuthErrorState) {
                  return LandingScreen();
                } else {
                  return Scaffold();
                }
              },
            )),

    );
  }



}
