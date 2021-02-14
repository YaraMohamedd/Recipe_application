import 'package:recipe_application/models/recipe_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class Recipe{
  List<RecipeModel>recipes=[];
  Future<void> getRecipes()async{
    String url= "https://api.edamam.com/search?q=dishes&app_id=65292ea5&app_key=bff196bbbf591892647320e1568f1a61";
    var response =await http.get(url);
    var jsonData = jsonDecode(response.body);
     if(jsonData['more']==true){
       jsonData['hits'].forEach((element){
        if(element['recipe']['url']!=null&& element['recipe']['image'] != null){
          RecipeModel recipeModel = RecipeModel(
            label: element['recipe']['label'],
            image: element['recipe']['image'],
            source: element['recipe']['source'],
          );
    recipes.add(recipeModel);
        }
       });
     }
  }
}