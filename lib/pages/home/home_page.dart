import 'package:flutter/material.dart';
import 'package:rock_paper_scissors/utilities/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final int won = 0;
  final int draw = 0;
  final int lost = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          _scoreBoard(),
          _gameplay(),
        ],
      ),
    );
  }

  Widget _scoreBoard() {
    return Container(
      padding: EdgeInsets.all(defaultMargin),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _scoreText(title: 'Won', score: won),
          _scoreText(title: 'Draw', score: draw),
          _scoreText(title: 'Lost', score: lost),
        ],
      ),
    );
  }

  Widget _scoreText({required String title, required int score}) {
    return Row(
      children: [
        Text(
          '$title ',
          textScaleFactor: 1.0,
        ),
        Text(
          score.toString(),
          textScaleFactor: 1.0,
        ),
      ],
    );
  }

  Widget _gameplay() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      padding: EdgeInsets.all(defaultMargin),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '🤖',
              style: TextStyle(
                fontSize: 64,
              ),
              textScaleFactor: 1.0,
            ),
            SizedBox(height: defaultMargin),
            Text(
              style: TextStyle(
                fontSize: 24,
                fontWeight: semiBold,
              ),
              'Rock, Paper, Scissors?',
              textScaleFactor: 1.0,
            ),
            SizedBox(height: defaultMargin),
            _gameButton(),
          ],
        ),
      ),
    );
  }

  Widget _gameButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _gameButtonIcon(icon: '👊🏻', tooltip: 'Rock'),
        _gameButtonIcon(icon: '🖐🏻', tooltip: 'Paper'),
        _gameButtonIcon(icon: '✌🏻', tooltip: 'Scissors'),
      ],
    );
  }

  Widget _gameButtonIcon({required String icon, required String tooltip}) {
    return Tooltip(
      message: tooltip,
      child: TextButton(
        onPressed: () {},
        child: Text(
          icon,
          style: const TextStyle(
            fontSize: 64,
          ),
          textScaleFactor: 1.0,
        ),
      ),
    );
  }
}
