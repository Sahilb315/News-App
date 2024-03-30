// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app/features/favourites/repo/bookmark_repo.dart';
import 'package:news_app/features/home/model/news_model.dart';

part 'favourites_event.dart';
part 'favourites_state.dart';

class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  FavouritesBloc() : super(FavouritesInitial()) {
    on<FavouritesNavigateToDetailedPageEvent>(
        favouritesNavigateToDetailedPageEvent);
    on<FavouritesFetchEvent>(favouritesFetchEvent);
    on<LogOutEvent>(logOutEvent);
  }

  FutureOr<void> favouritesNavigateToDetailedPageEvent(
      FavouritesNavigateToDetailedPageEvent event,
      Emitter<FavouritesState> emit) {
    emit(FavouritesNavigateToDetailedPageActionState(
      newsModel: event.newsModel,
    ));
  }

  FutureOr<void> favouritesFetchEvent(
      FavouritesFetchEvent event, Emitter<FavouritesState> emit) async {
    emit(FavouritesLoadingState());
    final result = await BookmarkRepo.fetchAllBookmarks();
    if (result is FavouritesLoadedState) {
      emit(FavouritesLoadedState(favourites: result.favourites));
    } else if (result is FavouritesErrorState) {
      emit(FavouritesErrorState(errorMessage: result.errorMessage));
    }
  }

  FutureOr<void> logOutEvent(
      LogOutEvent event, Emitter<FavouritesState> emit) async {
    await BookmarkRepo.logOut();
    emit(LogOutActionState());
  }
}
