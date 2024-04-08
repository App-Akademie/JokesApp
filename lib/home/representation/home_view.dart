import 'package:flutter/material.dart';
import 'package:jokes/favorites/data/favorites_repository.dart';
import 'package:jokes/home/data/jokes_repository.dart';
import 'package:jokes/home/domain/joke_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({required this.favoritesRepository, super.key});

  final FavoritesRepository favoritesRepository;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Joke? joke;

  bool isLoading = false;

  bool isFavorite = false;

  final repository = JokesRepository();

  Future<void> _fetchJoke() async {
    // Fetch a joke from the API
    // and update the joke variable
    try {
      setState(() {
        isLoading = true;
      });
      final response = await repository.getJoke();
      setState(() {
        joke = response;
        isLoading = false;
      });
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            joke != null
                ? ListTile(
                    title: Text(
                      joke!.joke,
                      textAlign: TextAlign.center,
                    ),
                    leading: const Icon(Icons.format_quote),
                    trailing: IconButton(
                      onPressed: () {
                        widget.favoritesRepository.addFavorite(joke!);
                        setState(() {
                          isFavorite = !isFavorite;
                        });
                      },
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : null,
                      ),
                    ),
                  )
                : const Text('Press the button to fetch a joke'),
            if (isLoading) const CircularProgressIndicator(),
            FilledButton(
              onPressed: _fetchJoke,
              child: const Text('Fetch Joke'),
            ),
          ],
        ),
      ),
    );
  }
}
