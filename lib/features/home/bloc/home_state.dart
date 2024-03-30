part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

abstract class HomeActionState extends HomeState {}

final class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  final List<NewsModel> newsList;
  final List<NewsModel> topStories;
  HomeLoadedState({required this.topStories, required this.newsList});
}

class HomeErrorState extends HomeState {
  final String errorMessage;

  HomeErrorState({required this.errorMessage});
}

class HomeNavigateToDetailedNewsPageActionState extends HomeActionState {
  final NewsModel newsModel;

  HomeNavigateToDetailedNewsPageActionState({required this.newsModel});
}

class HomeNavigateToTopStoriesPageActionState extends HomeActionState {}
