import 'package:contacts_app_new/presentation/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:contacts_app_new/constans/screens.dart' as screens;

import '../screens/home/home_layout.dart';

class AppRouter{
  late Widget startwidget;
  Route? onGenerateRoute(RouteSettings settings){
    startwidget = const SplashScreen();
    switch(settings.name ){
      case '/':
        return MaterialPageRoute(builder: (_) => startwidget);
        case screens.homeLayout:
         return MaterialPageRoute(builder: (_) => HomeLayout());
      default:
        return null;
    }
  }
}