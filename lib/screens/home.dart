import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jokes_app_lab2/models/joke_type.dart';
import 'package:jokes_app_lab2/services/api_service.dart';
import 'package:jokes_app_lab2/widgets/joke_type_grid.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<JokeType> jokeTypes = [];

  @override
  void initState() {
    super.initState();
    getJokeTypesFromAPI();
  }

  void getJokeTypesFromAPI() async {
    var response = await ApiService.getJokeTypes();
    var data = List<String>.from(jsonDecode(response.body));
    List<JokeType> jokeTypes = data.map((type) {
      return JokeType.fromJson({'type': type});
    }).toList();

    setState(() {
      this.jokeTypes = jokeTypes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jokes App'),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/random_joke',
                );
              },
              icon: const Icon(
                Icons.shuffle,
                size: 24,
              )),
        ],
      ),
      body: JokeTypeGrid(jokeTypes: jokeTypes),
    );
  }
}
