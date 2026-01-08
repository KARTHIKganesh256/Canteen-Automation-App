import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

/// Voice to Book Widget
/// This widget provides voice-based booking functionality for the canteen app.
/// Users can tap the mic button to speak booking commands, which are converted to text,
/// parsed for item and quantity, and added to a local booking list after confirmation.
class VoiceBookWidget extends StatefulWidget {
  @override
  _VoiceBookWidgetState createState() => _VoiceBookWidgetState();
}

class _VoiceBookWidgetState extends State<VoiceBookWidget> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = 'Press the button and start speaking';
  List<Map<String, dynamic>> _bookings = []; // Local list: [{'item': 'biryani', 'quantity': 2}]

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  /// Mic Button Logic: Starts or stops listening
  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
          }),
          localeId: 'en_US', // Change to 'te_IN' for Telugu if supported offline
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
      _parseAndBook(_text);
    }
  }

  /// NLP/Regex Parsing: Extracts intent, quantity, and item from speech text
  void _parseAndBook(String text) {
    // Rule-based intent detection: Check for action words
    RegExp actionRegex = RegExp(r'\b(book|add|order|buy|book chey|ivvu)\b', caseSensitive: false);
    if (!actionRegex.hasMatch(text)) return; // No booking intent, ignore

    // Quantity detection: Numbers or word numbers
    Map<String, int> numberWords = {
      'one': 1, 'two': 2, 'three': 3, 'four': 4, 'five': 5,
      'six': 6, 'seven': 7, 'eight': 8, 'nine': 9, 'ten': 10,
      'రెండు': 2, 'మూడు': 3, // Telugu numbers if transcribed
    };
    RegExp quantityRegex = RegExp(r'\b(\d+|one|two|three|four|five|six|seven|eight|nine|ten|రెండు|మూడు)\b', caseSensitive: false);
    int quantity = 1; // Default quantity
    var match = quantityRegex.firstMatch(text);
    if (match != null) {
      String q = match.group(1)!.toLowerCase();
      quantity = int.tryParse(q) ?? numberWords[q] ?? 1;
    }

    // Item detection: Remove action and quantity words, assume rest is item
    String itemText = text
        .replaceAll(actionRegex, '')
        .replaceAll(quantityRegex, '')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
    if (itemText.isEmpty) return;

    // Booking Handler: Show confirmation
    _showConfirmation(itemText, quantity);
  }

  /// Booking Handler: Adds to local list after confirmation
  void _showConfirmation(String item, int quantity) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Booking'),
        content: Text('Do you want to book $quantity $item?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _bookings.add({'item': item, 'quantity': quantity});
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Booked $quantity $item')),
              );
            },
            child: Text('Yes'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Voice to Book')),
      body: Column(
        children: [
          // Live transcription display
          Container(
            padding: EdgeInsets.all(16),
            child: Text(
              _text,
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
          // UI Display for Bookings: List of booked items
          Expanded(
            child: ListView.builder(
              itemCount: _bookings.length,
              itemBuilder: (context, index) {
                var booking = _bookings[index];
                return ListTile(
                  title: Text('${booking['quantity']} x ${booking['item']}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        _bookings.removeAt(index);
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      // Mic Button Widget: Animated FAB
      floatingActionButton: FloatingActionButton(
        onPressed: _listen,
        child: Icon(_isListening ? Icons.mic : Icons.mic_none),
        backgroundColor: _isListening ? Colors.red : Colors.blue,
      ),
    );
  }
}
