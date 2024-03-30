part of 'top_stories_bloc.dart';

@immutable
sealed class TopStoriesEvent {}

class TopStoriesFetchEvent extends TopStoriesEvent {}

class TopStoriesNavigateToDetailedPageEvent extends TopStoriesEvent {
  final NewsModel newsModel;

  TopStoriesNavigateToDetailedPageEvent({required this.newsModel});
}

