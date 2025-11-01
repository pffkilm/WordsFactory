// saved_words_page.dart
import 'package:flutter/material.dart';
import 'package:project/saved_words_repository.dart';


class SavedWordsPage extends StatelessWidget {
  final SavedWordsRepository savedWordsRepository;

  const SavedWordsPage({super.key, required this.savedWordsRepository});

  @override
  Widget build(BuildContext context) {
    final savedWords = savedWordsRepository.savedWords;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Saved Words'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: savedWords.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.bookmark_border,
              size: 64,
              color: Colors.grey[400],
            ),
            SizedBox(height: 16),
            Text(
              'No saved words yet',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Save words from dictionary to see them here',
              style: TextStyle(
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      )
          : ListView.builder(
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
                  savedWordsRepository.removeWord(word.word);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}