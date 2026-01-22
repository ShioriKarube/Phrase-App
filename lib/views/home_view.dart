import 'package:flutter/material.dart';
import 'package:phrase_app/data/phrase.dart';

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
          ),
        ],
      ),
      body: const Center(child: Text('HomeView')),
    );
  }
}