import 'package:flutter/material.dart';
import 'package:suitmedia/screen/first_screen.dart';
import 'package:suitmedia/screen/second_screen.dart';
import 'package:suitmedia/screen/third_screen.dart';
import 'package:suitmedia/util/screen_argument.dart';

class Routes{
  static const firstScreen = "/first";
  static const secondScreen = "/second";
  static const thirdScreen = "/third";

  static Route<dynamic>? onGenerateRoutes(RouteSettings settings){
    switch(settings.name){
      case firstScreen:
        return MaterialPageRoute(builder: (_) => const FirstScreen());
      case secondScreen:
        final args = settings.arguments as ScreenArgument<String>;
        return MaterialPageRoute(builder: (_) => SecondScreen(name: args.data));
      case thirdScreen:
        return MaterialPageRoute(builder: (_) => const ThirdScreen());
      default:
        return MaterialPageRoute(builder: (_){
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}