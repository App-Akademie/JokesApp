import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jokes/home/domain/joke_model.dart';

class JokesRepository {
  Future<Joke> getJoke() async {
    final client = http.Client();

    const url = 'https://icanhazdadjoke.com/';

    final response = await client.get(
      Uri.parse(
        url,
      ),
      headers: {
        'Accept': 'application/json',
      },
    );
    final jsonResponse = jsonDecode(response.body);
    print(jsonResponse);
    return Joke.fromJson(jsonResponse);
  }
}
