import 'package:flutter/material.dart';
import 'package:jokes/home/domain/joke_model.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage(
      {required this.onRemove, required this.fetchJokes, super.key});

  final void Function(Joke) onRemove;
  final Future<List<Joke>> fetchJokes;
  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
        future: widget.fetchJokes,
        builder: (context, snapshot) => snapshot.hasData
            ? snapshot.data!.isEmpty
                ? const Text('No favorites yet')
                : ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final joke = snapshot.data![index];

                      return ListTile(
                          title: Text(joke.joke),
                          leading: const Icon(Icons.format_quote),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              widget.onRemove(joke);
                            },
                          ));
                    },
                  )
            : snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : const Text('Error'),
      ),
    );
  }
}
