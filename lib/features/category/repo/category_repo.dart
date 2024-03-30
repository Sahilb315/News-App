import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/api_key.dart';
import 'package:news_app/features/category/bloc/category_bloc.dart';
import 'package:news_app/features/home/model/news_model.dart';

class CategoryRepo {
  Future<CategoryState> fetchCategoryNews(String categoryName) async {
    List<NewsModel> categoryList = [];
    try {
      var response = await http.get(Uri.parse(
        "$BASE_URL/top-headlines?category=$categoryName&country=us&apiKey=$API_KEY",
      ));
      var jsonRes = jsonDecode(response.body);
      List articles = jsonRes['articles'] as List;

      /// Can change how many articles you want
      for (var element in articles) {
        if (element['urlToImage'] == null || element['author'] == "Jessica Guynn, Bailey Schulz") {
          continue;
        }
        categoryList.add(NewsModel.fromMap(element));
      }
      return CategoryLoadedState(categoriesList: categoryList);
    } catch (e) {
      return CategoryErrorState(errorMessage: e.toString());
    }
  }
}
