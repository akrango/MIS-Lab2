import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jokes_app_lab2/models/joke.dart';
import 'package:jokes_app_lab2/models/joke_type.dart';
import 'package:jokes_app_lab2/services/api_service.dart';
import 'package:jokes_app_lab2/widgets/joke_card.dart';

class Jokes extends StatefulWidget {
  const Jokes({super.key});

  @override
  State<Jokes> createState() => _JokesState();
}

class _JokesState extends State<Jokes> {
  List<Joke> jokes = [];
  String type = '';
  bool isRandom = false;
  bool isLoading = true;
  bool hasError = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)!.settings.arguments;
    if (arguments != null) {
      final JokeType jokeType = arguments as JokeType;
      type = jokeType.type;
      if (type.isNotEmpty) {
        getJokesFromAPI();
      }
    } else {
      getRandomJokeFromAPI();
    }
  }

  void getRandomJokeFromAPI() async {
    setState(() {
      isLoading = true;
      hasError = false;
      isRandom = true;
    });
    try {
      var data = await ApiService.getRandomJoke();

      Joke randomJoke = Joke.fromJson(data as Map<String, dynamic>);
      type = randomJoke.type.type;
      setState(() {
        jokes = [randomJoke];
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        hasError = true;
        isLoading = false;
      });
      print('Error fetching jokes: $e');
    }
  }

  void getJokesFromAPI() async {
    setState(() {
      isLoading = true;
      hasError = false;
    });
    try {
      var response = await ApiService.getJokes(type);
      var data = jsonDecode(response.body) as List;

      List<Joke> jokes = data.map((joke) => Joke.fromJson(joke)).toList();
      if (mounted) {
        setState(() {
          this.jokes = jokes;
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          hasError = true;
          isLoading = false;
        });
      }
      print('Error fetching jokes: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: isRandom
            ? const Text("Random Joke")
            : Text('${type.toUpperCase()} Jokes'),
      ),
      body: Container(
        color: const Color.fromARGB(255, 189, 214, 230),
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : hasError
                ? Center(
                    child: Text(
                      'Failed to load jokes. Please try again.',
                      style: TextStyle(fontSize: 16, color: Colors.red[700]),
                    ),
                  )
                : jokes.isEmpty
                    ? Center(
                        child: Text(
                          'No jokes found for $type.',
                          style: const TextStyle(fontSize: 18),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: jokes.length,
                        itemBuilder: (context, index) {
                          final joke = jokes[index];
                          return JokeCard(
                            id: joke.id,
                            type: type,
                            setup: joke.setup,
                            punchline: joke.punchline,
                          );
                        },
                      ),
      ),
    );
  }
}
