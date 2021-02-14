import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:recipe_application/services/dynamic_theme.dart';
import 'package:recipe_application/screens/search_screen.dart';

class RecipeTitle extends StatelessWidget {
  final String imageUrl;
  final String recipeName;
  final String recipeSource;
    final String url;
  const RecipeTitle({this.imageUrl, this.recipeName, this.recipeSource,this.url}) ;
  _launchURL(String url)async{
    print(url);
    if(await canLaunch(url)){
      await launch(url);
    }
    else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(8),
      elevation: 2,
      child: GestureDetector(
        onTap: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SearchScreen(
                  )));
        },
        child: Container(
          decoration: BoxDecoration(
            color: isThemeDark(context)?Colors.grey[800]:Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                  ),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                padding: EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipeName,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: isThemeDark(context)?Colors.white:Colors.black,),
                    ),
                    SizedBox(height: 8,),
                    Text(
                      'Source:$recipeSource',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: isThemeDark(context)?Colors.white:Colors.black),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
