import 'package:div_news/model/category_model.dart';

List<CategoryModel> getCategories(){
  List<CategoryModel> list = [];

  list.add(CategoryModel(imageUrl: 'https://images.unsplash.com/photo-1612550761236-e813928f7271?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80',categoryName: 'business'));

  list.add(CategoryModel(imageUrl: 'https://images.unsplash.com/photo-1496169514208-d9affacc58ba?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1189&q=80',categoryName: 'Entertainment'));

  list.add(CategoryModel(imageUrl: 'https://images.unsplash.com/photo-1612550761236-e813928f7271?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80',categoryName: 'General'));

  list.add(CategoryModel(imageUrl: 'https://images.unsplash.com/photo-1434494878577-86c23bcb06b9?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80',categoryName: 'Health'));

  list.add(CategoryModel(imageUrl: 'https://images.unsplash.com/photo-1461896836934-ffe607ba8211?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80',categoryName: 'Sports'));

  list.add(CategoryModel(imageUrl: 'https://images.unsplash.com/photo-1519389950473-47ba0277781c?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80',categoryName: 'Technology'));

  return list;
}