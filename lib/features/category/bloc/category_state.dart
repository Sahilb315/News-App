part of 'category_bloc.dart';

@immutable
sealed class CategoryState {}

abstract class CategoryActionState extends CategoryState {}

final class CategoryInitial extends CategoryState {}

class CategoryLoadingState extends CategoryState {}

class CategoryLoadedState extends CategoryState {
  final List<NewsModel> categoriesList;

  CategoryLoadedState({required this.categoriesList});
}

class CategoryErrorState extends CategoryState {
  final String errorMessage;

  CategoryErrorState({required this.errorMessage});
}

class CategoryListNavigateToCategoryPageActionState
    extends CategoryActionState {
  final String categoryName;

  CategoryListNavigateToCategoryPageActionState({required this.categoryName});
}

class CategoryNavigateToDetailedPageActionState extends CategoryActionState {
  final NewsModel newsModel;

  CategoryNavigateToDetailedPageActionState({required this.newsModel});
}
