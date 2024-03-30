part of 'detailed_news_bloc.dart';

@immutable
sealed class DetailedNewsState {}

final class DetailedNewsInitial extends DetailedNewsState {}

class DetailedLoadingState extends DetailedNewsState {}

class DetailedErrorState extends DetailedNewsState {
  final String message;

  DetailedErrorState({required this.message});
}

class DetailedLoadedState extends DetailedNewsState {
  final List<NewsModel> bookmarksList;

  DetailedLoadedState({required this.bookmarksList});
}
