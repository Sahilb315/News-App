// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app/features/home/model/news_model.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<SearchTextFieldSubmittedEvent>(searchTextFieldSubmittedEvent);
    on<SearchClearTextFieldEvent>(searchClearTextFieldEvent);
    on<SearchNavigateToProductDetailsPageEvent>(
        searchNavigateToProductDetailsPageEvent);
  }

  FutureOr<void> searchTextFieldSubmittedEvent(
      SearchTextFieldSubmittedEvent event, Emitter<SearchState> emit) {
    if (event.searchedArticles.isEmpty) {
      emit(SearchNoResultsFoundState());
    } else {
      emit(SearchResultsState(searchedArticles: event.searchedArticles));
    }
  }

  FutureOr<void> searchClearTextFieldEvent(
      SearchClearTextFieldEvent event, Emitter<SearchState> emit) {
    emit(SearchInitial());
  }

  FutureOr<void> searchNavigateToProductDetailsPageEvent(
      SearchNavigateToProductDetailsPageEvent event,
      Emitter<SearchState> emit) {
    emit(SearchNavigateToProductDetailsPageActionState(
      newsModel: event.newsModel,
    ));
  }
}
