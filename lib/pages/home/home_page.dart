import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rock_paper_scissors/utilities/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String userChoice = '';
  late String botChoice = '';
  int won = 0;
  int draw = 0;
  int lost = 0;
  final List<String> choices = ['👊🏻', '🖐🏻', '✌🏻'];
  static const String rock = '👊🏻';
  static const String paper = '🖐🏻';
  static const String scissors = '✌🏻';
  final Map<String, String> winConditions = {
    rock: scissors,
    paper: rock,
    scissors: paper,
  };
  String winner = '';

  String _determineWinner(String userChoice, String botChoice) {
    if (userChoice == botChoice) {
      return 'draw';
    } else if (winConditions[userChoice] == botChoice) {
      return 'won';
    } else {
      return 'lost';
    }
  }

  void _scoreCounter(String newUserChoice) {
    final newBotChoice = choices[Random().nextInt(choices.length)];

    setState(() {
      userChoice = newUserChoice;
      botChoice = newBotChoice;
      winner = _determineWinner(userChoice, botChoice);

      if (kDebugMode) {
        print('userChoice: $userChoice');
        print('botChoice: $botChoice');
        print('winner: $winner');
      }

      if (winner == 'draw') {
        draw++;
      } else if (winner == 'won') {
        won++;
      } else {
        lost++;
      }
    });
  }

  void _restartGame() {
    setState(() {
      userChoice = '';
      botChoice = '';
      winner = '';
    });
  }

  Color? _getBackgroundColor() {
    switch (winner) {
      case 'draw':
        return mutedColor;
      case 'won':
        return greenColor;
      case 'lost':
        return redColor;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Rock Paper Scissors',
          style: TextStyle(
            fontSize: 24,
            fontWeight: bold,
          ),
          textScaleFactor: 1.0,
        ),
        actions: [
          winner != ''
              ? IconButton(
                  onPressed: () {
                    _restartGame();
                  },
                  tooltip: 'Restart',
                  icon: Icon(
                    Icons.refresh,
                    color: blackColor,
                  ),
                )
              : Container(),
        ],
        backgroundColor: _getBackgroundColor(),
      ),
      backgroundColor: _getBackgroundColor(),
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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
          style: const TextStyle(
            fontSize: 18,
          ),
          textScaleFactor: 1.0,
        ),
        Text(
          score.toString(),
          style: TextStyle(
            fontSize: 18,
            fontWeight: bold,
          ),
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
            _getBotChoice(),
            SizedBox(height: defaultMargin),
            _getWinnerText(),
            SizedBox(height: defaultMargin),
            _getUserChoice(),
          ],
        ),
      ),
    );
  }

  Widget _getBotChoice() {
    return Text(
      botChoice == '' ? '🤖' : botChoice,
      style: const TextStyle(
        fontSize: 64,
      ),
      textScaleFactor: 1.0,
    );
  }

  Widget _getWinnerText() {
    switch (winner) {
      case 'draw':
        return _winnerText('Draw 🤝🏻');
      case 'won':
        return _winnerText('You Won 🥳');
      case 'lost':
        return _winnerText('You Lost 😭');
      default:
        return _winnerText('VS');
    }
  }

  Widget _winnerText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 24,
        fontWeight: semiBold,
      ),
      textScaleFactor: 1.0,
    );
  }

  _getUserChoice() {
    return userChoice == '' ? _gameButton() : _userChoice();
  }

  Widget _userChoice() {
    return Text(
      userChoice,
      style: const TextStyle(
        fontSize: 64,
      ),
      textScaleFactor: 1.0,
    );
  }

  Widget _gameButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: choices.map((icon) {
        final tooltip = getTitleForIcon(icon);
        return _gameButtonIcon(icon: icon, tooltip: tooltip);
      }).toList(),
    );
  }

  String getTitleForIcon(String icon) {
    switch (icon) {
      case rock:
        return 'Rock';
      case paper:
        return 'Paper';
      case scissors:
        return 'Scissors';
      default:
        return '';
    }
  }

  Widget _gameButtonIcon({required String icon, required String tooltip}) {
    return Tooltip(
      message: tooltip,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: whiteColor,
          padding: EdgeInsets.all(defaultMargin),
          shape: const CircleBorder(),
        ),
        onPressed: () {
          _scoreCounter(icon);
        },
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
