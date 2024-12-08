import 'package:jokes_app_lab2/models/joke_type.dart';

class Joke {
  int id;
  JokeType type;
   String setup;
   String punchline;

  Joke({
    required this.id,
    required this.type,
    required this.setup,
    required this.punchline,
  });

  factory Joke.fromJson(Map<String, dynamic> json) {
    return Joke(
      id: json['id'],
      type: JokeType.fromJson(json),
      setup: json['setup'],
      punchline: json['punchline'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.toJson(),
      'setup': setup,
      'punchline': punchline,
    };
  }
}