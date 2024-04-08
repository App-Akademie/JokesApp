import 'package:flutter/material.dart';
import 'package:jokes/favorites/data/favorites_repository.dart';
import 'package:jokes/favorites/representation/favorites_page.dart';
import 'package:jokes/home/domain/joke_model.dart';
import 'package:jokes/home/representation/home_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  final FavoritesRepository favoritesRepository = FavoritesRepository();

  late Future<List<Joke>> fetchJokes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: [
          HomeView(
            favoritesRepository: favoritesRepository,
          ),
          FavoritesPage(
            fetchJokes: favoritesRepository.getFavorites(),
            onRemove: (joke) {
              favoritesRepository
                  .removeFavorite(joke)
                  .then((value) => setState(() {}));
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
