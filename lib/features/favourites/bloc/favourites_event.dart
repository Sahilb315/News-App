part of 'favourites_bloc.dart';

@immutable
sealed class FavouritesEvent {}

class FavouritesNavigateToDetailedPageEvent extends FavouritesEvent {
  final NewsModel newsModel;

  FavouritesNavigateToDetailedPageEvent({required this.newsModel});
}

class FavouritesFetchEvent extends FavouritesEvent {}

class LogOutEvent extends FavouritesEvent {}
