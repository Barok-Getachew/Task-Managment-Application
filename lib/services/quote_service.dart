import 'dart:convert';
import 'package:http/http.dart' as http;

class QuoteService {
  static const String apiUrl = 'https://api.api-ninjas.com/v1/quotes';
  static const String apiKey = 'pxVuOsAAwUkmDf94fUYJ1g==ozBAMIS8XDOWhBPi';

  static Future<String> fetchRandomQuote() async {
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'X-Api-Key': apiKey,
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> quotes = jsonDecode(response.body);
      return quotes[DateTime.now().millisecondsSinceEpoch % quotes.length]
          ['quote']; // Extract the 'quote' text from the response
    } else {
      throw Exception('Failed to load quotes');
    }
  }
}
