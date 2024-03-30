import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/detailed_news/bloc/detailed_news_bloc.dart';
import 'package:news_app/features/home/model/news_model.dart';

class DetailedNewsPage extends StatefulWidget {
  final NewsModel newsModel;
  const DetailedNewsPage({super.key, required this.newsModel});

  @override
  State<DetailedNewsPage> createState() => _DetailedNewsPageState();
}

class _DetailedNewsPageState extends State<DetailedNewsPage> {
  @override
  void initState() {
    detailedBloc.add(DetailedFetchEvent());
    super.initState();
  }

  final detailedBloc = DetailedNewsBloc();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailedNewsBloc, DetailedNewsState>(
      bloc: detailedBloc,
      builder: (context, state) {
        if (state is DetailedLoadingState) {
          return const Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
                strokeWidth: 2.5,
                strokeCap: StrokeCap.round,
              ),
            ),
          );
        } else if (state is DetailedLoadedState) {
          final bookmarks = state.bookmarksList;
          return Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: [
                Container(
                  height: MediaQuery.sizeOf(context).height * 0.5,
                  width: MediaQuery.sizeOf(context).width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        widget.newsModel.urlToImage.toString(),
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                widget.newsModel.title.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                if (bookmarks.contains(widget.newsModel)) {
                                  detailedBloc
                                      .add(DetailedRemoveArticleInBookmarkEvent(
                                    newsModel: widget.newsModel,
                                  ));
                                } else {
                                  detailedBloc
                                      .add(DetailedAddArticleInBookmarkEvent(
                                    newsModel: widget.newsModel,
                                  ));
                                }
                              },
                              icon: bookmarks.contains(widget.newsModel)
                                  ? const Icon(CupertinoIcons.bookmark_fill)
                                  : const Icon(CupertinoIcons.bookmark),
                            ),
                          ],
                        ),
                        Text(
                          "Author: ${widget.newsModel.author}",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                            color: Colors.grey.shade900,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(
                          widget.newsModel.content ?? "",
                          style: TextStyle(
                              color: Colors.grey.shade700, fontSize: 18),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(
                          "Source: ${widget.newsModel.source!.name}",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                            color: Colors.grey.shade900,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "Published at: ${widget.newsModel.publishedAt!.split('T').first}",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                            color: Colors.grey.shade900,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (state is DetailedErrorState) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Text(state.message),
            ),
          );
        } else {
          return const Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
                strokeWidth: 2.5,
                strokeCap: StrokeCap.round,
              ),
            ),
          );
        }
      },
    );
  }
}
