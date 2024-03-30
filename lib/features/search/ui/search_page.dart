
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/detailed_news/ui/detailed_news_page.dart';
import 'package:news_app/features/home/model/news_model.dart';
import 'package:news_app/features/home/ui/widgets/news_card.dart';
import 'package:news_app/features/search/bloc/search_bloc.dart';

class SearchPage extends StatelessWidget {
  final List<NewsModel> newsList;
  SearchPage({super.key, required this.newsList});

  final searchController = TextEditingController();

  final searchBloc = SearchBloc();

  final searchedArticles = <NewsModel>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: SizedBox(
          height: 45,
          child: TextFormField(
            controller: searchController,
            textAlignVertical: TextAlignVertical.top,
            autofocus: true,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w400,
            ),
            cursorColor: Colors.blue,
            decoration: InputDecoration(
              labelText: "Search Articles",
              labelStyle: TextStyle(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w400,
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  searchController.clear();
                  searchBloc.add(SearchClearTextFieldEvent());
                },
                icon: Icon(
                  Icons.clear,
                  color: Colors.grey.shade600,
                ),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
            ),
            onFieldSubmitted: (value) {
              searchedArticles.clear();
              for (var element in newsList) {
                if (element.title!
                        .toLowerCase()
                        .contains(value.toLowerCase()) ||
                    element.source!.name!
                        .toLowerCase()
                        .contains(value.toLowerCase())) {
                  if (searchedArticles.contains(element)) return;
                  searchedArticles.add(element);
                }
              }
              searchBloc.add(SearchTextFieldSubmittedEvent(
                searchedArticles: searchedArticles,
              ));
            },
          ),
        ),
      ),
      body: BlocConsumer<SearchBloc, SearchState>(
        bloc: searchBloc,
        listenWhen: (previous, current) => current is SearchActionState,
        buildWhen: (previous, current) => current is! SearchActionState,
        listener: (context, state) {
          if (state is SearchNavigateToProductDetailsPageActionState) {
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
          if (state is SearchResultsLoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
                strokeWidth: 2.5,
                strokeCap: StrokeCap.round,
              ),
            );
          } else if (state is SearchInitial) {
            return const SizedBox();
          } else if (state is SearchResultsState) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: searchedArticles.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          searchBloc
                              .add(SearchNavigateToProductDetailsPageEvent(
                            newsModel: searchedArticles[index],
                          ));
                        },
                        child: NewsCard(
                          newsModel: searchedArticles[index],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (state is SearchNoResultsFoundState) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Article Not Found",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
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
