import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipe_application/screens/home_screen.dart';
import 'package:splashscreen/splashscreen.dart';
class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SplashScreen(
       seconds: 4,
        navigateAfterSeconds: HomeScreen(),
      image: Image.asset('devs/recipe.png',alignment: Alignment.center,),
        loaderColor: Colors.deepOrange[600],
        photoSize: 70,

      ),
    );
  }
}
