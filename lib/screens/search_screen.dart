import 'dart:convert';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:recipe_application/models/recipe_model.dart';
import 'package:recipe_application/screens/recipe_view_screen.dart';
import 'package:recipe_application/services/dynamic_theme.dart';
import 'package:recipe_application/widgets/app_bar_style.dart';
import 'package:http/http.dart'as http;
import 'package:url_launcher/url_launcher.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<RecipeModel> recipes = List<RecipeModel>();
  String ingredients;
  bool _loading;
  String query = '';
  TextEditingController textEditingController = TextEditingController();

  void changeBrightness() {
    DynamicTheme.of(context).setBrightness(
      Theme.of(context).brightness == Brightness.dark
          ? Brightness.light
          : Brightness.dark,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: AppBarTitle(),
        actions: [
          IconButton(
            icon: Icon(
                isThemeDark(context) ? Icons.wb_sunny : Icons.brightness_2),
            color: isThemeDark(context) ? Colors.white : Colors.black,
            onPressed: () {
              setState(() {
                changeBrightness();
              });
            },
          )
        ],
      ),
      body: SingleChildScrollView (
        physics: ClampingScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.only(bottom: 4),
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('What will you cook today?',style: TextStyle(fontWeight: FontWeight.bold,color:isThemeDark(context)?Colors.white:Colors.black,fontSize: 20,fontFamily: 'Overpass',
              ),),
              SizedBox(
                height: 15,
              ),
              Text('Just Enter Ingredients you have and we will show the best recipe for you',
                style: TextStyle(fontWeight: FontWeight.w400,color:isThemeDark(context)?Colors.white:Colors.black,fontSize: 15,fontFamily: 'OverpassRegular',

              ),),
              SizedBox(height: 30,),
             Container(

               margin: EdgeInsets.only(left: 7),

               decoration: BoxDecoration(
                   color: isThemeDark(context)?Colors.white:Colors.grey[300],
                 //color:isThemeDark(context)?Colors.white:Colors.grey,
                 borderRadius: BorderRadius.circular(14)
               ),
               child: Row(
                 children: [
                   Expanded(child: TextField(
                     controller: textEditingController,
                     cursorColor: Colors.amber,
                     style: TextStyle(color:Colors.black),
                     decoration: InputDecoration(
                       border: InputBorder.none,
                       focusedBorder: InputBorder.none,
                       enabledBorder: InputBorder.none,
                       disabledBorder: InputBorder.none,
                       contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                       hintText: "Enter ingredient",
                       hintStyle: TextStyle(
                         color: Colors.grey[600],
                         fontStyle: FontStyle.italic,
                       ),
                     ),
                   )),
                   InkWell(
                     onTap: ()async{
                        if(textEditingController.text.isNotEmpty){
                          setState(() {
                            _loading=true;
                          });
                          recipes=new List();
                          String url =
                              "https://api.edamam.com/search?q=${textEditingController.text}&app_id=65292ea5&app_key=bff196bbbf591892647320e1568f1a61";
                              var response =await http.get(url);
                          print(" $response this is response");
                          Map<String, dynamic> jsonData =
                          jsonDecode(response.body);
                          print("this is json Data $jsonData");
                          jsonData['hits'].forEach((element){
                            print(element.toString());
                            RecipeModel recipeModel=new RecipeModel();
                            recipeModel =
                                RecipeModel.fromMap(element['recipe']);
                            recipes.add(recipeModel);
                            print(recipeModel.url);
                          });
                         setState(() {
                           _loading=false;

                         });
                         print('doing it');
                        }else{
                          print('not doing it');
                        }
                     },
                       child: Padding(
                         padding: const EdgeInsets.only(right: 8),
                         child: Icon(Icons.search,color:Colors.black),
                       )),

                 ],
               ),
             ),
              SizedBox(height: 30,),
              Flexible(
                flex: 1,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: GridView(
                    physics: ClampingScrollPhysics() ,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        mainAxisSpacing: 10.0, maxCrossAxisExtent: 200.0,
                      ),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      children: List.generate(recipes.length, (index){
                        return GridTile(child:RecipeTile(
                          title: recipes[index].label,
                          imageUrl: recipes[index].image,
                          desc: recipes[index].source,
                          url: recipes[index].url,
                        ));
                      })
                  ),
                ),
              )
            ],
          ),

        ),
      ),
    );
  }
}
class RecipeTile extends StatefulWidget {
  final String title,desc,imageUrl,url;

  const RecipeTile({ this.title, this.desc, this.imageUrl, this.url}) ;
  @override
  _RecipeTileState createState() => _RecipeTileState();
}

class _RecipeTileState extends State<RecipeTile> {
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
    return Wrap(
      children: [
        GestureDetector(
        onTap: (){
          if(kIsWeb){
            _launchURL(widget.url);
          }else{
            print(widget.url + " this is what we are going to see");
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => RecipeViewScreen(
                      postUrl: widget.url,
                    )));
          }
        },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20)
            ),
            margin: EdgeInsets.all(8),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                  ),
                  child: Image.network(widget.imageUrl,  height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  width: 200,
                  alignment: Alignment.bottomLeft,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.white30, Colors.white],
                          begin: FractionalOffset.centerRight,
                          end: FractionalOffset.centerLeft)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.black54,
                              fontFamily: 'Overpass'),
                        ),
                        Text(
                          widget.desc,
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.black54,
                              fontFamily: 'OverpassRegular'),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
