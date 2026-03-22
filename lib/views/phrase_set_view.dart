import 'package:flutter/material.dart';
import 'package:phrase_app/data/phrase.dart';
import 'package:phrase_app/views/add_phrase_view.dart';

class PhraseSetView extends StatefulWidget {
  final PhraseSet phraseSet;

  const PhraseSetView({super.key, required this.phraseSet});

  @override
  State<PhraseSetView> createState() => _PhraseSetViewState();
}

class _PhraseSetViewState extends State<PhraseSetView> {
  late List<Phrase> _phrases;

  @override
  void initState() {
    super.initState();
    _phrases = List.from(widget.phraseSet.phrases);
  }

  void _showEditDialog (Phrase phrase) {
    final frontController = TextEditingController(text: phrase.front);
    final backController = TextEditingController(text: phrase.back);
    final noteController = TextEditingController(text: phrase.note ?? '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
        actionsPadding: const EdgeInsets.only(
          right: 16,
          bottom: 16,
        ),
        title: const Text(
          'Edit Phrase',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: frontController,
                decoration: const InputDecoration(
                  labelText: 'Phrase',
                  border: OutlineInputBorder(),
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  )
                ),
              ),
              const SizedBox(height: 18),
              TextField(
                controller: backController,
                decoration: const InputDecoration(
                  labelText: 'Meaning',
                  border: OutlineInputBorder(),
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              TextField(
                controller: noteController,
                decoration: const InputDecoration(
                  labelText: 'Note (optional)',
                  border: OutlineInputBorder(),
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 9,
                  ),
                ),
              )
            ],
          ),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
            ),
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              minimumSize: const Size(70, 38),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.phraseSet.setName),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Phrases',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  '${_phrases.length}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _phrases.isEmpty
                ? Center(
                  child: Text(
                    'No phrase yet',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                )
                : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  itemCount: _phrases.length,
                  itemBuilder: (context, index) {
                    final phrase = _phrases[index];
                    return Dismissible(
                      key: Key(phrase.id),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 16),
                        color: Theme.of(context).colorScheme.error,
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),                        
                      ),
                      onDismissed: (direction) {
                        setState(() {
                          _phrases.removeAt(index);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Phrase deleted')),
                        );
                      },
                      child: Card(
                        margin: const EdgeInsets.only(bottom: 13),
                        child: ListTile(
                          title: Text(
                            phrase.front,
                            style: const TextStyle(fontWeight: FontWeight.normal),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 4),
                              Text(phrase.back),
                              if (phrase.note != null && phrase.note !.isEmpty) ...[
                                const SizedBox(height: 4),
                                Text(
                                  phrase.note!,
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ],
                          ),
                          trailing: IconButton(
                            onPressed: () => _showEditDialog(phrase),
                            icon: const Icon(Icons.edit),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 1,
                          ),
                        ),
                      ),
                    );
                  },
                ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddPhraseView(phraseSetId: widget.phraseSet.id),
            ),
          );
        },
        child: const Icon(Icons.add)
      ),
    );
  }
}