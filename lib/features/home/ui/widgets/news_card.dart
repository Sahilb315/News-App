import 'package:flutter/material.dart';
import 'package:news_app/features/home/model/news_model.dart';

class NewsCard extends StatelessWidget {
  final NewsModel newsModel;
  const NewsCard({super.key, required this.newsModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(1, 1),
            ),
          ],
        ),
        width: double.infinity,
        height: 140,
        child: Row(
          children: [
            Container(
              width: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: Image.network(newsModel.urlToImage.toString()).image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    newsModel.title.toString(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 17,
                    ),
                  ),
                  Text(
                    newsModel.content ?? "",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(color: Colors.grey.shade700, fontSize: 15),
                  ),
                  Text(
                    newsModel.author ?? newsModel.source!.name ?? "",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(color: Colors.grey.shade900, fontSize: 14),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
