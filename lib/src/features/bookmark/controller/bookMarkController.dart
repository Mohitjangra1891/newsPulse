import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../modals/articleModal.dart';

// Bookmarks stored as JSON strings in SharedPreferences
final bookmarksProvider = StateNotifierProvider<BookmarksNotifier, List<Article>>((ref) {
  return BookmarksNotifier();
});

class BookmarksNotifier extends StateNotifier<List<Article>> {
  static const _key = 'bookmarks';
  late SharedPreferences _prefs;

  BookmarksNotifier() : super([]) {
    _load();
  }

  Future<void> _load() async {
    _prefs = await SharedPreferences.getInstance();
    final list = _prefs.getStringList(_key) ?? [];
    state = list.map((s) => Article.fromJson(json.decode(s))).toList();
  }

  void toggle(Article article) {
    final exists = state.any((a) => a.url == article.url);
    if (exists) {
      state = state.where((a) => a.url != article.url).toList();
    } else {
      state = [...state, article];
    }
    _save();
  }

  Future<void> _save() async {
    final list = state.map((a) => json.encode({
      'title': a.title,
      'description': a.description,
      'url': a.url,
      'urlToImage': a.urlToImage,
      'source': {'name': a.sourceName},
      'publishedAt': a.publishedAt.toIso8601String(),
    })).toList();
    await _prefs.setStringList(_key, list);
  }
}

