
import 'package:recipe_application/models/category_model.dart';
List<CategoryModel>getCategories(){
  List<CategoryModel>categoryTitle=List<CategoryModel>();
  CategoryModel category=CategoryModel();
  category.categoryName='Chicken';
  category.imageUrl='https://images.unsplash.com/photo-1562967914-01efa7e87832?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1052&q=80';
  categoryTitle.add(category);

  category=new CategoryModel();
  category.categoryName='Fish';
  category.imageUrl='https://images.unsplash.com/photo-1577194509876-4bb24787a641?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80';
  categoryTitle.add(category);

  category=new CategoryModel();
  category.categoryName='Burger';
  category.imageUrl='https://images.unsplash.com/photo-1568901346375-23c9450c58cd?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=602&q=80';
  categoryTitle.add(category);

  category=new CategoryModel();
  category.categoryName='Meat';
  category.imageUrl='https://images.unsplash.com/photo-1544025162-d76694265947?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=749&q=80';
  categoryTitle.add(category);


  category = new CategoryModel();
  category.categoryName = 'Paneer';
  category.imageUrl =
  'https://images.unsplash.com/photo-1551881192-002e02ad3d87?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80';
  categoryTitle.add(category);

  // 5
  category = new CategoryModel();
  category.categoryName = 'Mutton';
  category.imageUrl =
  'https://images.unsplash.com/photo-1574653853027-5382a3d23a15?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1052&q=80';
  categoryTitle.add(category);

  // 6
  category = new CategoryModel();
  category.categoryName = 'Egg';
  category.imageUrl =
  'https://images.unsplash.com/photo-1553163147-622ab57be1c7?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80';
  categoryTitle.add(category);
  return categoryTitle;
}
