import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:recipe_application/models/category_model.dart';
import 'package:recipe_application/screens/search_screen.dart';
import 'package:recipe_application/services/data.dart';
import 'package:recipe_application/services/dynamic_theme.dart';
import 'package:recipe_application/widgets/app_bar_style.dart';
import 'package:recipe_application/widgets/category_tile.dart';
import 'package:recipe_application/models/recipe_model.dart';
import 'package:recipe_application/services/recipe.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:recipe_application/widgets/recipe_title.dart';
import 'package:url_launcher/url_launcher.dart';
class HomeScreen extends StatefulWidget {


  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CategoryModel> categoryList=List<CategoryModel>();
  List<RecipeModel> recipeList = List<RecipeModel>();
  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categoryList=getCategories();
    getRecipes();
  }
  getRecipes() async {
    Recipe recipe = Recipe();
    await recipe.getRecipes();
    recipeList = recipe.recipes;
    setState(() {
      _loading = false;
    });
  }
  _launchURL(String url)async{
    print(url);
    if(await canLaunch(url)){
      await launch(url);
    }
    else {
      throw 'Could not launch $url';
    }
  }
  void changeBrightness() {
    DynamicTheme.of(context).setBrightness(
      Theme.of(context).brightness == Brightness.dark
          ? Brightness.light
          : Brightness.dark,
    );
  }
  Widget _buildContent(){
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        height: MediaQuery.of(context).size.height,
      //  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 25),
        child: Column(
     crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 12,top: 10),
            height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: ScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                itemCount: categoryList.length,
                itemBuilder: (context,index){
                  return GestureDetector(
                    onTap: (){
                      setState(() {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SearchScreen()));
                      });
                    },
                    child: CategoryTile(
                      imageUrl: categoryList[index].imageUrl,
                      title: categoryList[index].categoryName,
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                "Today's Special Dishes",
                style: TextStyle(
                  fontSize: 18.0,
                  //color: Colors.black, ~dynamic
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          _loading==true?Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Center( child: CircularProgressIndicator(),),
          ):
          Flexible(
            flex: 1,
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 12,vertical: 25),
              child: StaggeredGridView.countBuilder(
                 physics: ScrollPhysics(
                   parent: BouncingScrollPhysics(),
                 ),
                crossAxisCount: 4,
                shrinkWrap: true,
                itemCount: recipeList.length,
                itemBuilder: (context,index){
                   return RecipeTitle(
                     imageUrl: recipeList[index].image,
                     recipeName: recipeList[index].label,
                     recipeSource: recipeList[index].source,


                   );
                },

                staggeredTileBuilder: (int index) =>
                new StaggeredTile.fit(2),
                mainAxisSpacing: 16.0,
                crossAxisSpacing: 16.0,
              ),
            ),
          )
          ],

        ),
      ),


    );
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
           IconButton(icon: Icon(isThemeDark(context)?Icons.wb_sunny:Icons.brightness_2),
             color: isThemeDark(context) ? Colors.white : Colors.black,
             onPressed: (){
             setState(() {
               changeBrightness();
             });
             },
           )
        ],
      ),
      body:_buildContent() ,

    );
  }
}
