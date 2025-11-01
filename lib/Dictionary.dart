import 'package:flutter/material.dart';
import 'package:project/Traning.dart';
import 'package:project/api.dart';
import 'package:project/save.dart';
import 'package:project/saved_words_repository.dart';
import 'Video.dart';

class DictionaryScreen extends StatefulWidget {
  const DictionaryScreen({super.key});

  @override
  _DictionaryScreenState createState() => _DictionaryScreenState();
}

class _DictionaryScreenState extends State<DictionaryScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    DictionaryContent(),
    TrainingPage(),
    VideoPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        width: 375,
        height: 98,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(255, 255, 255, 1),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          border: Border.all(
            color: const Color.fromRGBO(190, 186, 179, 1),
            width: 1,
          ),
        ),
        child: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                _currentIndex == 0
                    ? 'assets/Icon_List/dictonaryActiv.png'
                    : 'assets/Icon_List/dictionary.png',
                width: 24,
                height: 24,
              ),
              label: 'Dictionary',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                _currentIndex == 1
                    ? 'assets/Icon_List/train.png'
                    : 'assets/Icon_List/train.png',
                width: 24,
                height: 24,
              ),
              label: 'Training',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                _currentIndex == 2
                    ? 'assets/Icon_List/videoActiv.png'
                    : 'assets/Icon_List/video.png',
                width: 24,
                height: 24,
              ),
              label: 'Video',
            ),
          ],
          selectedItemColor: const Color.fromRGBO(227, 86, 42, 1),
          unselectedItemColor: const Color.fromRGBO(190, 186, 179, 1),
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}

class DictionaryContent extends StatefulWidget {
  @override
  _DictionaryContentState createState() => _DictionaryContentState();
}

class _DictionaryContentState extends State<DictionaryContent> {
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = false;
  Map<String, dynamic>? _wordData;
  final SavedWordsRepository _savedWordsRepository = SavedWordsRepository();

  void _searchWord(String word) async {
    if (word.isEmpty) {
      setState(() {
        _wordData = null;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _wordData = null;
    });

    final wordData = await DictionaryAPI.getWordDefinition(word);

    setState(() {
      _isLoading = false;
      _wordData = wordData;
    });
  }

  void _saveCurrentWord() {
    if (_wordData != null) {
      final savedWord = SavedWord(
        word: _wordData!['word'] ?? '',
        phonetic: _wordData!['phonetic'] ?? '',
        partOfSpeech: _wordData!['partOfSpeech'] ?? '',
        definition: _wordData!['definition'] ?? '',
        example: _wordData!['example'] ?? '',
      );

      _savedWordsRepository.saveWord(savedWord);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('"${savedWord.word}" saved to dictionary!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _showSavedWords() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SavedWordsPage(savedWordsRepository: _savedWordsRepository),
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            Color.fromRGBO(227, 86, 42, 1),
          ),
        ),
      );
    }

    if (_wordData == null) {
      return _buildSavedWordsList();
    }

    return _buildWordCard();
  }

  Widget _buildSavedWordsList() {
    final savedWords = _savedWordsRepository.savedWords;

    if (savedWords.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/girl2.png", width: 375, height: 253),
            SizedBox(height: 20),
            Text(
              'No word',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Input something to find it in dictionary',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: savedWords.length,
      itemBuilder: (context, index) {
        final word = savedWords[index];
        return Card(
          margin: EdgeInsets.only(bottom: 12),
          child: ListTile(
            title: Text(
              word.word,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (word.phonetic.isNotEmpty)
                  Text(
                    word.phonetic,
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Color.fromRGBO(227, 86, 42, 1),
                    ),
                  ),
                SizedBox(height: 4),
                Text(
                  word.definition,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                setState(() {
                  _savedWordsRepository.removeWord(word.word);
                });
              },
            ),
            onTap: () {
              setState(() {
                _wordData = word.toMap();
              });
            },
          ),
        );
      },
    );
  }

  Widget _buildWordCard() {
    final word = _wordData!['word'] ?? '';
    final phonetic = _wordData!['phonetic'] ?? '';
    final partOfSpeech = _wordData!['partOfSpeech'] ?? '';
    final definition = _wordData!['definition'] ?? '';
    final example = _wordData!['example'] ?? '';

    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                word,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: 16),
              Flexible(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      phonetic,
                      style: TextStyle(
                        fontSize: 14,
                        color: const Color.fromRGBO(227, 86, 42, 1),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        _playAudio();
                      },
                      child: Image.asset(
                        'assets/images/sound.png',
                        width: 24,
                        height: 24,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.volume_up,
                            color: Color.fromRGBO(227, 86, 42, 1),
                            size: 24,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 16),

          if (partOfSpeech.isNotEmpty)
            Text(
              'Part of Speech: $partOfSpeech',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: const Color.fromRGBO(0, 0, 0, 1),
              ),
            ),

          SizedBox(height: 24),

          Text(
            'Meanings:',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),

          SizedBox(height: 12),

          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(
                color: Color.fromRGBO(190, 186, 179, 1),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (definition.isNotEmpty)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '• ',
                        style: TextStyle(fontSize: 16),
                      ),
                      Expanded(
                        child: Text(
                          definition,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),

                SizedBox(height: 16),

                if (example.isNotEmpty)
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Example: ',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        TextSpan(
                          text: example,
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromRGBO(0, 0, 0, 1),
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          SizedBox(height: 32),

          Center(
            child: SizedBox(
              width: 309,
              height: 56,
              child: ElevatedButton(
                onPressed: _saveCurrentWord,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(227, 86, 42, 1),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  'Add to Dictionary',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _playAudio() {
    print('Play audio for word: ${_wordData!['word']}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // Убрали заголовок "Dictionary"
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          if (_wordData != null) // Крестик показывается только при поиске
            IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                setState(() {
                  _wordData = null;
                  _searchController.clear();
                });
              },
            ),
          // Убрали иконку избранного (bookmark)
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Container(
                width: 343,
                height: 56,
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: '',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    contentPadding: EdgeInsets.all(16),
                    suffixIcon: _isLoading
                        ? Padding(
                      padding: EdgeInsets.all(12),
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Color.fromRGBO(227, 86, 42, 1),
                        ),
                      ),
                    )
                        : IconButton(
                      icon: Image.asset(
                        'assets/images/lup.png',
                        width: 24,
                        height: 24,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(Icons.search);
                        },
                      ),
                      onPressed: () => _searchWord(_searchController.text.trim()),
                    ),
                  ),
                  onSubmitted: (value) => _searchWord(value.trim()),
                ),
              ),
            ),

            Expanded(
              child: _buildContent(),
            ),
          ],
        ),
      ),
    );
  }
}