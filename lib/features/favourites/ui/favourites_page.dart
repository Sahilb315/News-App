import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/detailed_news/ui/detailed_news_page.dart';
import 'package:news_app/features/favourites/bloc/favourites_bloc.dart';
import 'package:news_app/features/home/ui/widgets/news_card.dart';
import 'package:news_app/main.dart';

class FavouritePage extends StatelessWidget {
  FavouritePage({super.key});

  final favBloc = FavouritesBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Favourites"),
      ),
      body: BlocListener<FavouritesBloc, FavouritesState>(
        bloc: favBloc,
        listenWhen: (previous, current) => current is FavouriteActionState,
        listener: (context, state) {
          if (state is FavouritesNavigateToDetailedPageActionState) {
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
        child: Column(
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
        ),
      ),
    );
  }
}
