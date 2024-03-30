part of 'top_stories_bloc.dart';

@immutable
sealed class TopStoriesState {}

abstract class TopStoriesActionState extends TopStoriesState {}

final class TopStoriesInitial extends TopStoriesState {}

class TopStoriesLoadingState extends TopStoriesState {}

class TopStoriesLoadedState extends TopStoriesState {
  final List<NewsModel> topStories;

  TopStoriesLoadedState({required this.topStories});
}

class TopStoriesErrorState extends TopStoriesState {
  final String errorMessage;

  TopStoriesErrorState({required this.errorMessage});
}

class TopStoriesNavigateToDetailedPageActionState extends TopStoriesActionState {
  final NewsModel newsModel;

  TopStoriesNavigateToDetailedPageActionState({required this.newsModel});
}