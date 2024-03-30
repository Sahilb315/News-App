import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app/features/detailed_news/bloc/detailed_news_bloc.dart';
import 'package:news_app/features/home/model/news_model.dart';

class DetailedNewsRepo {
  static Future<void> addArticleInBookmark(NewsModel newsModel) async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.email)
          .update({
        'bookmarks': FieldValue.arrayUnion([newsModel.toMap()])
      });
    } catch (e) {
      log(e.toString());
    }
  }

  static Future<void> removeArticleInBookmark(NewsModel newsModel) async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.email)
          .update({
        'bookmarks': FieldValue.arrayRemove([newsModel.toMap()])
      });
    } catch (e) {
      log(e.toString());
    }
  }

  static Future<DetailedNewsState> fetchAllBookmarks() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.email)
          .get();
      final data = snapshot.data() as Map<String, dynamic>;
      List bookmarksFromDB = data['bookmarks'];
      List<NewsModel> bookmarks =
          bookmarksFromDB.map((e) => NewsModel.fromMap(e)).toList();
      return DetailedLoadedState(bookmarksList: bookmarks);
    } catch (e) {
      log(e.toString());
      return DetailedErrorState(message: e.toString());
    }
  }
}
