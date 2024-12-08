import 'package:flutter/material.dart';
import 'package:jokes_app_lab2/models/joke_type.dart';
import 'package:jokes_app_lab2/widgets/joke_type_card.dart';

class JokeTypeGrid extends StatefulWidget {
  final List<JokeType> jokeTypes;
  const JokeTypeGrid({super.key, required this.jokeTypes});

  @override
  State<JokeTypeGrid> createState() => _JokeTypeGridState();
}

class _JokeTypeGridState extends State<JokeTypeGrid> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 189, 214, 230),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Select a Joke Type',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(4),
              shrinkWrap: true,
              itemCount: widget.jokeTypes.length,
              itemBuilder: (context, index) {
                return JokeTypeCard(type: widget.jokeTypes[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
