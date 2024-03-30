part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeFetchEvent extends HomeEvent {}

class HomeNavigateToDetailedNewsPageEvent extends HomeEvent {
  final NewsModel newsModel;

  HomeNavigateToDetailedNewsPageEvent({required this.newsModel});
}

class HomeNavigateToTopStoriesPageEvent extends HomeEvent {}
