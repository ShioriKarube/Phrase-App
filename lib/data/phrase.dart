class Phrase {
  final String id;
  final String front;
  final String back;
  final String? note;

  Phrase({
    required this.id,
    required this.front,
    required this.back,
    this.note,
  });
}

class PhraseSet {
  final String id;
  final String setName;
  final List<Phrase> phrases;

  PhraseSet({
    required this.id,
    required this.setName,
    required this.phrases,
  });
}

class DummyData {
  static final List<PhraseSet> sets = [
    PhraseSet(
      id: 'set-1',
      setName: 'Daily Conversation',
      phrases: [
        Phrase(
          id: 'set-1-1',
          front: 'How are you?',
          back: '元気ですか？',
          note: 'Casual greeting',
        ),
        Phrase(
          id: 'set-1-2',
          front: 'I’m fine, thank you.',
          back: '元気です、ありがとう。',
        ),
      ],
    ),
    PhraseSet(
      id: 'set-2',
      setName: 'Travel English',
      phrases: [
        Phrase(
          id: 'set-2-1',
          front: 'Where is the restroom?',
          back: 'トイレはどこですか？',
          note: 'Useful when traveling',
        ),
        Phrase(
          id: 'set-2-2',
          front: 'How much is this?',
          back: 'これはいくらですか？',
        ),
      ],
    ),
  ];
}