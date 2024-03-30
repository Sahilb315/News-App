import 'dart:convert';

import 'package:news_app/api_key.dart';
import 'package:news_app/features/home/model/news_model.dart';
import 'package:http/http.dart' as http;

class HomeRepo {
  Future<List<NewsModel>> fetchAllNews() async {
    List<NewsModel> newsList = [];
    try {
      var response = await http.get(
        Uri.parse("$BASE_URL/everything?q=keyword&apiKey=$API_KEY"),
      );
      if (response.statusCode == 200) {
        var jsonRes = jsonDecode(response.body);
        List articles = jsonRes['articles'] as List;

        /// Can change how many articles you want
        for (var element in articles.getRange(0, 35)) {
          /// Due to these one author and source, there is a error as they do not have images
          if (element['author'] == "Tim Cushing" ||
              element['source']['name'] == "Semrush.com" ||
              element['urlToImage'] == null) {
            continue;
          }
          newsList.add(NewsModel.fromMap(element));
        }
        return newsList;
      }
      throw Exception("Failed to load news Status Code: ${response.statusCode}");
    } catch (e) {
      return [];
    }
  }

  Future<List<NewsModel>> fetchTopStories() async {
    List<NewsModel> topStories = [];
    try {
      var responseUs = await http.get(
        Uri.parse("$BASE_URL/top-headlines?country=us&apiKey=$API_KEY"),
      );
      var responseIn = await http.get(
        Uri.parse("$BASE_URL/top-headlines?country=in&apiKey=$API_KEY"),
      );
      if (responseIn.statusCode == 200 && responseUs.statusCode == 200) {
        var jsonResUs = jsonDecode(responseUs.body);
        var jsonResIn = jsonDecode(responseIn.body);
        List articlesUs = jsonResUs['articles'] as List;
        List articlesIn = jsonResIn['articles'] as List;
        for (var element in articlesUs.getRange(0, 4)) {
          if (element['urlToImage'] == null) {
            continue;
          }
          topStories.add(NewsModel.fromMap(element));
        }
        for (var element in articlesIn.getRange(0, 4)) {
          if (element['urlToImage'] == null) {
            continue;
          }
          topStories.add(NewsModel.fromMap(element));
        }
        return topStories;
      }
      throw Exception("Failed to load news Status Code: ${responseIn.statusCode} & ${responseUs.statusCode}");
    } catch (e) {
      return [];
    }
  }
}
