part of 'search_bloc.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}


abstract class SearchActionState extends SearchState {}

final class SearchInitialState extends SearchState {}

class SearchResultsLoadingState extends SearchState {}

class SearchResultsState extends SearchState {
  final List<NewsModel> searchedArticles;

  SearchResultsState({required this.searchedArticles});
}

class SearchNoResultsFoundState extends SearchState {}

class SearchNavigateToProductDetailsPageActionState extends SearchActionState {
  final NewsModel newsModel;
  SearchNavigateToProductDetailsPageActionState({required this.newsModel});
}
