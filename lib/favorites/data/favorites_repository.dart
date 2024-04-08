import 'dart:convert';

import 'package:jokes/home/domain/joke_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesRepository {
  static const String _favoritesKey = 'favorites';

  Future<void> addFavorite(Joke joke) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = (prefs.getStringList(_favoritesKey) ?? [])
      ..add(jsonEncode(joke.toJson()));
    await prefs.setStringList(_favoritesKey, favorites);
  }

  Future<void> removeFavorite(Joke joke) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = (prefs.getStringList(_favoritesKey) ?? [])
      ..remove(jsonEncode(joke.toJson()));
    await prefs.setStringList(_favoritesKey, favorites);
  }

  Future<List<Joke>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList(_favoritesKey) ?? [];
    return favorites.map((e) => Joke.fromJson(jsonDecode(e))).toList();
  }
}
