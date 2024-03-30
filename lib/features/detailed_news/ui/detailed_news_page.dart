import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news_app/features/home/model/news_model.dart';

class DetailedNewsPage extends StatelessWidget {
  final NewsModel newsModel;
  const DetailedNewsPage({super.key, required this.newsModel});

  @override
  Widget build(BuildContext context) {
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
                  newsModel.urlToImage.toString(),
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        newsModel.title.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(CupertinoIcons.bookmark),
                    ),
                  ],
                ),
                Text(
                  newsModel.author ?? newsModel.source!.name ?? "",
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
                  newsModel.content ?? "",
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 18),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
