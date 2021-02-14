import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:recipe_application/services/dynamic_theme.dart';
class AppBarTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Food',style: TextStyle(
          color: isThemeDark(context)?Colors.white:Colors.black,
          fontWeight: FontWeight.w600
        ),
        ),
        Text(
          'Recipe',style: TextStyle(
            color: Colors.amber[500],
            fontWeight: FontWeight.w600
        ),
        )
      ],
    );
  }
}
