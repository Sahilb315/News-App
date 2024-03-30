part of 'detailed_news_bloc.dart';

@immutable
sealed class DetailedNewsEvent {}

class DetailedFetchEvent extends DetailedNewsEvent {}

class DetailedOnTapBookmarkEvent extends DetailedNewsEvent {
  final NewsModel newsModel;

  DetailedOnTapBookmarkEvent({required this.newsModel});
}

class DetailedAddArticleInBookmarkEvent extends DetailedNewsEvent {
  final NewsModel newsModel;

  DetailedAddArticleInBookmarkEvent({required this.newsModel});
}

class DetailedRemoveArticleInBookmarkEvent extends DetailedNewsEvent {
  final NewsModel newsModel;

  DetailedRemoveArticleInBookmarkEvent({required this.newsModel});
}
