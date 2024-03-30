import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/detailed_news/ui/detailed_news_page.dart';
import 'package:news_app/features/home/ui/widgets/news_card.dart';
import 'package:news_app/features/top_stories/bloc/top_stories_bloc.dart';

class TopStoriesPage extends StatefulWidget {
  const TopStoriesPage({super.key});

  @override
  State<TopStoriesPage> createState() => _TopStoriesPageState();
}

class _TopStoriesPageState extends State<TopStoriesPage> {
  final topStoriesBloc = TopStoriesBloc();
  @override
  void initState() {
    topStoriesBloc.add(TopStoriesFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<TopStoriesBloc, TopStoriesState>(
        listenWhen: (previous, current) => current is TopStoriesActionState,
        buildWhen: (previous, current) => current is! TopStoriesActionState,
        bloc: topStoriesBloc,
        listener: (context, state) {
          if (state is TopStoriesNavigateToDetailedPageActionState) {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    DetailedNewsPage(newsModel: state.newsModel),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  var begin = const Offset(0, 1);
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
          if (state is TopStoriesLoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
                strokeWidth: 2.5,
                strokeCap: StrokeCap.round,
              ),
            );
          } else if (state is TopStoriesLoadedState) {
            final newsList = state.topStories;
            return CustomScrollView(
              slivers: [
                const SliverAppBar(
                  title: Text('Top Stories'),
                  backgroundColor: Colors.white,
                  surfaceTintColor: Colors.white,
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      ListView.builder(
                        itemCount: newsList.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              topStoriesBloc
                                  .add(TopStoriesNavigateToDetailedPageEvent(
                                newsModel: newsList[index],
                              ));
                            },
                            child: NewsCard(
                              newsModel: newsList[index],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if (state is TopStoriesErrorState) {
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
