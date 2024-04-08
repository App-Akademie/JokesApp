class Joke {
  final String joke;

  final String id;

  const Joke({
    required this.joke,
    required this.id,
  });

  factory Joke.fromJson(Map<String, dynamic> json) {
    return Joke(
      joke: json['joke'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'joke': joke,
      'id': id,
    };
  }
}
