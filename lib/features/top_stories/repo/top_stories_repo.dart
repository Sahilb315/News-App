import 'dart:convert';

import 'package:news_app/api_key.dart';
import 'package:news_app/features/home/model/news_model.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/features/top_stories/bloc/top_stories_bloc.dart';

class TopStoriesRepo {
  Future<TopStoriesState> fetchTopStories() async {
    List<NewsModel> topStories = [];
    try {
      var responseUs = await http.get(
        Uri.parse("$BASE_URL/top-headlines?country=us&apiKey=$API_KEY"),
      );
      var responseIn = await http.get(
        Uri.parse("$BASE_URL/top-headlines?country=in&apiKey=$API_KEY"),
      );
      var jsonResUs = jsonDecode(responseUs.body);
      var jsonResIn = jsonDecode(responseIn.body);
      List articlesUs = jsonResUs['articles'] as List;
      List articlesIn = jsonResIn['articles'] as List;
      for (var element in articlesUs.getRange(0, 20)) {
        topStories.add(NewsModel.fromMap(element));
      }
      for (var element in articlesIn.getRange(0, 20)) {
        topStories.add(NewsModel.fromMap(element));
      }
      return TopStoriesLoadedState(topStories: topStories);
    } catch (e) {
      return TopStoriesErrorState(errorMessage: e.toString());
    }
  }
}
