part of 'favourites_bloc.dart';

@immutable
sealed class FavouritesState {}

abstract class FavouriteActionState extends FavouritesState {}

final class FavouritesInitial extends FavouritesState {}

class FavouritesNavigateToDetailedPageActionState extends FavouriteActionState {
  final NewsModel newsModel;

  FavouritesNavigateToDetailedPageActionState({required this.newsModel});
}
