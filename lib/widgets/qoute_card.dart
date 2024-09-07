import 'package:flutter/material.dart';
import 'package:taskmanagnent/utils/app_exports.dart';

class QouteCard extends StatelessWidget {
  const QouteCard({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: QuoteService.fetchRandomQuote(), // Fetch the quote from the API
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LinearProgressIndicator(
            color: Color.fromARGB(255, 15, 81, 17),
          );
        } else if (snapshot.hasError) {
          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('Failed to load quote'),
          );
        } else {
          return Container(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.02, vertical: size.height * 0.01),
            height: size.height * 0.21,
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.all(Radius.circular(size.width * 0.04)),
              color: const Color.fromARGB(115, 36, 52, 37),
            ),
            child: Center(
              child: Text(
                '"${snapshot.data}"',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
                style: const TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  color: Color.fromARGB(255, 255, 239, 239),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
