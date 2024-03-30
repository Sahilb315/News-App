// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app/features/detailed_news/repo/detailed_news_repo.dart';
import 'package:news_app/features/home/model/news_model.dart';

part 'detailed_news_event.dart';
part 'detailed_news_state.dart';

class DetailedNewsBloc extends Bloc<DetailedNewsEvent, DetailedNewsState> {
  DetailedNewsBloc() : super(DetailedNewsInitial()) {
    on<DetailedFetchEvent>(detailedFetchEvent);
    on<DetailedAddArticleInBookmarkEvent>(detailedAddArticleInBookmarkEvent);
    on<DetailedRemoveArticleInBookmarkEvent>(
        detailedRemoveArticleInBookmarkEvent);
  }

  FutureOr<void> detailedFetchEvent(
      DetailedFetchEvent event, Emitter<DetailedNewsState> emit) async {
    emit(DetailedLoadingState());
    final result = await DetailedNewsRepo.fetchAllBookmarks();
    if (result is DetailedLoadedState) {
      emit(DetailedLoadedState(bookmarksList: result.bookmarksList));
    } else if (result is DetailedErrorState) {
      emit(DetailedErrorState(message: result.message));
    }
  }

  FutureOr<void> detailedAddArticleInBookmarkEvent(
      DetailedAddArticleInBookmarkEvent event,
      Emitter<DetailedNewsState> emit) async {
    await DetailedNewsRepo.addArticleInBookmark(event.newsModel);
    final result = await DetailedNewsRepo.fetchAllBookmarks();
    if (result is DetailedLoadedState) {
      emit(DetailedLoadedState(bookmarksList: result.bookmarksList));
    } else if (result is DetailedErrorState) {
      emit(DetailedErrorState(message: result.message));
    }
  }

  FutureOr<void> detailedRemoveArticleInBookmarkEvent(
      DetailedRemoveArticleInBookmarkEvent event,
      Emitter<DetailedNewsState> emit) async {
    await DetailedNewsRepo.removeArticleInBookmark(event.newsModel);
    final result = await DetailedNewsRepo.fetchAllBookmarks();
    if (result is DetailedLoadedState) {
      emit(DetailedLoadedState(bookmarksList: result.bookmarksList));
    } else if (result is DetailedErrorState) {
      emit(DetailedErrorState(message: result.message));
    }
  }
}
