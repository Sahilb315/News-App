part of 'favourites_bloc.dart';

@immutable
sealed class FavouritesState {}

abstract class FavouriteActionState extends FavouritesState {}

final class FavouritesInitial extends FavouritesState {}

class FavouritesNavigateToDetailedPageActionState extends FavouriteActionState {
  final NewsModel newsModel;

  FavouritesNavigateToDetailedPageActionState({required this.newsModel});
}

class FavouritesLoadingState extends FavouritesState {}

class FavouritesLoadedState extends FavouritesState {
  final List<NewsModel> favourites;

  FavouritesLoadedState({required this.favourites});
}

class FavouritesErrorState extends FavouritesState {
  final String errorMessage;

  FavouritesErrorState({required this.errorMessage});
}

class LogOutActionState extends FavouriteActionState {}