import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app/features/home/model/news_model.dart';

part 'favourites_event.dart';
part 'favourites_state.dart';

class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  FavouritesBloc() : super(FavouritesInitial()) {
    on<FavouritesNavigateToDetailedPageEvent>(
        favouritesNavigateToDetailedPageEvent);
  }

  FutureOr<void> favouritesNavigateToDetailedPageEvent(
      FavouritesNavigateToDetailedPageEvent event,
      Emitter<FavouritesState> emit) {
    emit(FavouritesNavigateToDetailedPageActionState(
      newsModel: event.newsModel,
    ));
  }
}
