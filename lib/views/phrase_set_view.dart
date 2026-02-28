import 'package:flutter/material.dart';
import 'package:phrase_app/data/phrase.dart';

class PhraseSetView extends StatelessWidget {
  final PhraseSet phraseSet;

  const PhraseSetView({
    super.key,
    required this.phraseSet,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(phraseSet.setName),
      ),
      body: Center(
        child: Text(
          'This is ${phraseSet.setName}',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}