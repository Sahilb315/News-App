// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app/features/home/model/news_model.dart';
import 'package:news_app/features/home/repo/home_repo.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeFetchEvent>(homeFetchEvent);
    on<HomeNavigateToDetailedNewsPageEvent>(
        homeNavigateToDetailedNewsPageEvent);
    on<HomeNavigateToTopStoriesPageEvent>(homeNavigateToTopStoriesPageEvent);
    on<HomeNavigateToSearchPageEvent>(homeNavigateToSearchPageEvent);
  }
  final homeRepo = HomeRepo();
  FutureOr<void> homeFetchEvent(
      HomeFetchEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    final result = await homeRepo.fetchAllNews();
    final topStories = await homeRepo.fetchTopStories();
    if (result.isNotEmpty && topStories.isNotEmpty) {
      emit(HomeLoadedState(newsList: result, topStories: topStories));
    } else {
      result as HomeErrorState;
      emit(HomeErrorState(errorMessage: "Error Occured"));
    }
  }

  FutureOr<void> homeNavigateToDetailedNewsPageEvent(
      HomeNavigateToDetailedNewsPageEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigateToDetailedNewsPageActionState(newsModel: event.newsModel));
  }

  FutureOr<void> homeNavigateToTopStoriesPageEvent(
      HomeNavigateToTopStoriesPageEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigateToTopStoriesPageActionState());
  }

  FutureOr<void> homeNavigateToSearchPageEvent(
      HomeNavigateToSearchPageEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigateToSearchPageActionState(newsList: event.newsList));
  }
}
