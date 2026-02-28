import 'package:flutter/material.dart';
import 'package:phrase_app/data/phrase.dart';
import 'package:phrase_app/views/phrase_set_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<PhraseSet> _filteredSets = DummyData.sets;

  void _filterSets(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredSets = DummyData.sets;
      }
      else {
        _filteredSets = DummyData.sets
          .where((set) => 
            set.setName.toLowerCase().contains(query.toLowerCase()))
          .toList();
      }
    });
  }

  void _showCreateSetDialog() {
    final TextEditingController controller = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 15,
          right: 15,
          top: 15,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Create Set',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            const SizedBox(height: 20),
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: 'Set name',
                border: OutlineInputBorder(),
              ),
              autofocus: true,
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Create'),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: _showCreateSetDialog,
            icon: const Icon(Icons.add),
            tooltip: 'Create new set',
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search phrase',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: _filterSets,
            ),
          ),
          Expanded(
            child: _filteredSets.isEmpty
              ? const Center(
                child: Text('No sets found'),
                )
              : GridView.builder(
                padding:EdgeInsets.all(15),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.4,
                ),
                itemCount: _filteredSets.length,
                itemBuilder: (context, index) {
                  final set = _filteredSets[index];
                  return Card(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PhraseSetView(phraseSet: set),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              set.setName,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 18),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${set.phrases.length} phrases',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                              ),
                            )
                          ]
                        ),
                      ),
                    )
                  );
                },
              )
          ),
        ],
      ),
    );
  }
}