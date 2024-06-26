// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/bottom_navigation/ui/bottom_nav_page.dart';
import 'package:news_app/features/detailed_news/ui/detailed_news_page.dart';
import 'package:news_app/features/favourites/bloc/favourites_bloc.dart';
import 'package:news_app/features/home/ui/widgets/news_card.dart';
import 'package:news_app/features/login/ui/login_page.dart';

class BookmarksPage extends StatefulWidget {
  const BookmarksPage({super.key});

  @override
  State<BookmarksPage> createState() => _BookmarksPageState();
}

class _BookmarksPageState extends State<BookmarksPage> {
  final favBloc = FavouritesBloc();
  @override
  void initState() {
    favBloc.add(FavouritesFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Favourites",
          style: TextStyle(
            fontFamily: "Poppins",
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              favBloc.add(LogOutEvent());
            },
            icon: const Icon(Icons.logout_rounded),
          ),
        ],
      ),
      body: BlocConsumer<FavouritesBloc, FavouritesState>(
        bloc: favBloc,
        listenWhen: (previous, current) => current is FavouriteActionState,
        listener: (context, state) {
          if (state is FavouritesNavigateToDetailedPageActionState) {
            Navigator.popUntil(
                context, (route) => route == const BookmarksPage());
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyBottomNavigationPage(index: 2),
                ));
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
          } else if (state is LogOutActionState) {
            Navigator.popUntil(
              context,
              (route) => route == const BookmarksPage(),
            );
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ));
          }
        },
        builder: (context, state) {
          if (state is FavouritesLoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
                strokeWidth: 2.5,
                strokeCap: StrokeCap.round,
              ),
            );
          } else if (state is FavouritesLoadedState) {
            final favourites = state.favourites;
            if (favourites.isEmpty) {
              return const Center(
                child: Text(
                  "No favourite articles",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: favourites.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          favBloc.add(FavouritesNavigateToDetailedPageEvent(
                            newsModel: favourites[index],
                          ));
                        },
                        child: NewsCard(
                          newsModel: favourites[index],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (state is FavouritesErrorState) {
            return Center(
              child: Text(state.errorMessage),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
