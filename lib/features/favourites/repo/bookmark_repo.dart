import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app/features/favourites/bloc/favourites_bloc.dart';
import 'package:news_app/features/home/model/news_model.dart';

class BookmarkRepo {
  static Future<FavouritesState> fetchAllBookmarks() async {
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
      return FavouritesLoadedState(favourites: bookmarks);
    } catch (e) {
      return FavouritesErrorState(errorMessage: e.toString());
    }
  }

  static Future<void> logOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      log(e.toString());
    }
  }
}
