// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app/features/category/repo/category_repo.dart';
import 'package:news_app/features/home/model/news_model.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial()) {
    on<CategoryListNavigateToCategoryPageEvent>(
        categoryListNavigateToCategoryPageEvent);
    on<CategoryFetchEvent>(categoryFetchEvent);
    on<CategoryNavigateToDetailedPageEvent>(
        categoryNavigateToDetailedPageEvent);
  }

  final categroyRepo = CategoryRepo();

  FutureOr<void> categoryListNavigateToCategoryPageEvent(
      CategoryListNavigateToCategoryPageEvent event,
      Emitter<CategoryState> emit) {
    emit(CategoryListNavigateToCategoryPageActionState(
      categoryName: event.categoryName,
    ));
  }

  FutureOr<void> categoryFetchEvent(
      CategoryFetchEvent event, Emitter<CategoryState> emit) async {
    emit(CategoryLoadingState());
    final categoryList =
        await categroyRepo.fetchCategoryNews(event.categoryName);
    if (categoryList is CategoryLoadedState) {
      emit(CategoryLoadedState(categoriesList: categoryList.categoriesList));
    } else if (categoryList is CategoryErrorState) {
      emit(CategoryErrorState(errorMessage: categoryList.errorMessage));
    }
  }

  FutureOr<void> categoryNavigateToDetailedPageEvent(
      CategoryNavigateToDetailedPageEvent event, Emitter<CategoryState> emit) {
    emit(CategoryNavigateToDetailedPageActionState(newsModel: event.newsModel));
  }
}
