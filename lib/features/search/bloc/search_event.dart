part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}

class SearchTextFieldSubmittedEvent extends SearchEvent {
  final List<NewsModel> searchedArticles;

  SearchTextFieldSubmittedEvent({required this.searchedArticles});
}

class SearchNavigateToProductDetailsPageEvent extends SearchEvent {
  final NewsModel newsModel;
  SearchNavigateToProductDetailsPageEvent({required this.newsModel});
}

class SearchClearTextFieldEvent extends SearchEvent {}