// dictionary_api.dart
import 'package:http/http.dart' as http;
import 'dart:convert';

class DictionaryAPI {
  static const String _baseUrl = 'https://api.dictionaryapi.dev/api/v2/entries/en';

  static Future<Map<String, dynamic>?> getWordDefinition(String word) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/$word'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        if (data.isNotEmpty) {
          return _parseDictionaryResponse(data[0]);
        }
      }
      return null;
    } catch (e) {
      print('Dictionary API error: $e');
      return null;
    }
  }

  static Map<String, dynamic> _parseDictionaryResponse(Map<String, dynamic> data) {
    String word = data['word'] ?? '';
    String phonetic = data['phonetic'] ?? '';

    // Получаем первую часть речи и только первое определение
    String partOfSpeech = '';
    String definition = '';
    String example = '';

    // Ищем любой пример во всех meanings и definitions
    if (data['meanings'] != null) {
      for (var meaning in data['meanings']) {
        partOfSpeech = meaning['partOfSpeech'] ?? '';

        if (meaning['definitions'] != null && meaning['definitions'].isNotEmpty) {
          final firstDefinition = meaning['definitions'][0];
          definition = firstDefinition['definition'] ?? '';

          // Ищем пример в текущем meaning
          for (var def in meaning['definitions']) {
            if (def['example'] != null && def['example'].isNotEmpty) {
              example = def['example']!;
              break;
            }
          }
        }

        // Если нашли определение и пример, выходим
        if (definition.isNotEmpty) break;
      }
    }

    return {
      'word': word,
      'phonetic': phonetic,
      'partOfSpeech': partOfSpeech,
      'definition': definition,
      'example': example,
    };
  }
}