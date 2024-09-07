import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/app_exports.dart';

class QuoteService {
  static Future<String> fetchRandomQuote() async {
    final response = await http.get(
      Uri.parse(dotenv.env['API_URL']!),
      headers: {
        'X-Api-Key': dotenv.env['API_KEY']!,
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
