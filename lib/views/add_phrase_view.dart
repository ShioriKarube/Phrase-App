import 'package:flutter/material.dart';

class AddPhraseView extends StatefulWidget{
  final String phraseSetId;

  const AddPhraseView({super.key, required this.phraseSetId});

  @override
  State<AddPhraseView> createState() => _AddPhraseViewState();
}

class _AddPhraseViewState extends State<AddPhraseView> {
  final _frontController = TextEditingController();
  final _backController = TextEditingController();
  final _noteController = TextEditingController();

  @override
  void dispose() {
    _frontController.dispose();
    _backController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _save() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Phrase'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: _frontController,
                    decoration: const InputDecoration(
                      labelText: 'Front',
                      border: OutlineInputBorder(),
                    ),
                    autofocus: true,
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: _backController,
                    decoration: const InputDecoration(
                      labelText: 'Back',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: _noteController,
                    decoration: const InputDecoration(
                      labelText: 'Note (optional)',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 25),
              child: FilledButton(
                onPressed: _save,
                style: FilledButton.styleFrom(
                  minimumSize: const Size(90, 40),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text('Save'),
              ),
            ),
          ),
        ],
      )
    );
  }
}