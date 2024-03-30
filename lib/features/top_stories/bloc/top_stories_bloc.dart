// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app/features/home/model/news_model.dart';
import 'package:news_app/features/top_stories/repo/top_stories_repo.dart';

part 'top_stories_event.dart';
part 'top_stories_state.dart';

class TopStoriesBloc extends Bloc<TopStoriesEvent, TopStoriesState> {
  TopStoriesBloc() : super(TopStoriesInitial()) {
    on<TopStoriesFetchEvent>(topStoriesFetchEvent);
    on<TopStoriesNavigateToDetailedPageEvent>(
        topStoriesNavigateToDetailedPageEvent);
  }

  final topStoriesRepo = TopStoriesRepo();

  FutureOr<void> topStoriesFetchEvent(
      TopStoriesFetchEvent event, Emitter<TopStoriesState> emit) async {
    emit(TopStoriesLoadingState());
    final result = await topStoriesRepo.fetchTopStories();
    if (result is TopStoriesLoadedState) {
      emit(TopStoriesLoadedState(topStories: result.topStories));
    } else if (result is TopStoriesErrorState) {
      emit(TopStoriesErrorState(errorMessage: result.errorMessage));
    }
  }

  FutureOr<void> topStoriesNavigateToDetailedPageEvent(
      TopStoriesNavigateToDetailedPageEvent event,
      Emitter<TopStoriesState> emit) {
    emit(TopStoriesNavigateToDetailedPageActionState(
        newsModel: event.newsModel));
  }
}
