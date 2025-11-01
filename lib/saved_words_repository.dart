// saved_words_repository.dart
class SavedWord {
  final String word;
  final String phonetic;
  final String partOfSpeech;
  final String definition;
  final String example;

  SavedWord({
    required this.word,
    required this.phonetic,
    required this.partOfSpeech,
    required this.definition,
    required this.example,
  });

  Map<String, dynamic> toMap() {
    return {
      'word': word,
      'phonetic': phonetic,
      'partOfSpeech': partOfSpeech,
      'definition': definition,
      'example': example,
    };
  }

  factory SavedWord.fromMap(Map<String, dynamic> map) {
    return SavedWord(
      word: map['word'] ?? '',
      phonetic: map['phonetic'] ?? '',
      partOfSpeech: map['partOfSpeech'] ?? '',
      definition: map['definition'] ?? '',
      example: map['example'] ?? '',
    );
  }
}

class SavedWordsRepository {
  static final SavedWordsRepository _instance = SavedWordsRepository._internal();
  factory SavedWordsRepository() => _instance;
  SavedWordsRepository._internal();

  final List<SavedWord> _savedWords = [];

  List<SavedWord> get savedWords => List.from(_savedWords);

  void saveWord(SavedWord word) {
    if (!_savedWords.any((savedWord) => savedWord.word == word.word)) {
      _savedWords.add(word);
    }
  }

  void removeWord(String word) {
    _savedWords.removeWhere((savedWord) => savedWord.word == word);
  }

  bool isWordSaved(String word) {
    return _savedWords.any((savedWord) => savedWord.word == word);
  }
}