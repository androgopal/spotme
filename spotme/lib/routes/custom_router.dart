import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotme/Screens/LandingPage/LandingPage.dart';
import 'package:spotme/Screens/MobileLogin/Bloc/authBloc.dart';
 /// Application Routes generator
/// This class provides routes of all screen for navigation(and send data from screen to other)
class CustomRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {

      /// Auth screens --------------------------------///
      case LandingScreen.id:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (context) => AuthCubit(

            ),
            child:   LandingScreen(),
          ),
        );


      /// Default path ---------------------------------------///
      default:
        return MaterialPageRoute<void>(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
