import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/category/bloc/category_bloc.dart';
import 'package:news_app/features/detailed_news/ui/detailed_news_page.dart';
import 'package:news_app/features/home/ui/widgets/news_card.dart';

class CategoryPage extends StatefulWidget {
  final String categoryName;
  const CategoryPage({super.key, required this.categoryName});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final categoryBloc = CategoryBloc();

  @override
  void initState() {
    categoryBloc.add(
        CategoryFetchEvent(categoryName: widget.categoryName.toLowerCase()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<CategoryBloc, CategoryState>(
        bloc: categoryBloc,
        listener: (context, state) {
          if (state is CategoryNavigateToDetailedPageActionState) {
            Navigator.pop(context);
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    DetailedNewsPage(newsModel: state.newsModel),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  var begin = const Offset(1, 0);
                  var end = Offset.zero;
                  var curve = Curves.ease;
                  var tween = Tween(begin: begin, end: end)
                      .chain(CurveTween(curve: curve));
                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                },
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is CategoryLoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
                strokeWidth: 2.5,
                strokeCap: StrokeCap.round,
              ),
            );
          } else if (state is CategoryLoadedState) {
            final categoryList = state.categoriesList;
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.white,
                  surfaceTintColor: Colors.white,
                  title: Text(
                    "${widget.categoryName} News",
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: categoryList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              categoryBloc
                                  .add(CategoryNavigateToDetailedPageEvent(
                                newsModel: categoryList[index],
                              ));
                            },
                            child: NewsCard(
                              newsModel: categoryList[index],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if (state is CategoryErrorState) {
            return Center(
              child: Text(state.errorMessage),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
                strokeWidth: 2.5,
                strokeCap: StrokeCap.round,
              ),
            );
          }
        },
      ),
    );
  }
}
