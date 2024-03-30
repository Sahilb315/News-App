part of 'category_bloc.dart';

@immutable
sealed class CategoryEvent {}

class CategoryFetchEvent extends CategoryEvent {
  final String categoryName;

  CategoryFetchEvent({required this.categoryName});
}

class CategoryListNavigateToCategoryPageEvent extends CategoryEvent {
  final String categoryName;

  CategoryListNavigateToCategoryPageEvent({required this.categoryName});
}

class CategoryNavigateToDetailedPageEvent extends CategoryEvent {
  final NewsModel newsModel;

  CategoryNavigateToDetailedPageEvent({required this.newsModel});
}
