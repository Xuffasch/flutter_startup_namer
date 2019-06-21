import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
    // Variables to store words and set word size
    // They have to be created at the top to be 
    // available to the functions
    final List<WordPair> _suggestions = <WordPair>[];
    // Save the preferred WordPairs
    final Set<WordPair> _saved = Set<WordPair>();

    final TextStyle _biggerFont = const TextStyle(fontSize: 18);
    
    // Function to create a row for listview of words
    // It has to be created before it can be called in
    // _buildSuggestions()
    Widget _buildRow(WordPair pair) {
      // State whether the corresponding WordPair has been saved
      final bool alreadySaved = _saved.contains(pair);
      
      return ListTile(
        title: 
        Text(
          pair.asPascalCase,
          style: _biggerFont,
        ),
        trailing: 
        Icon(
          alreadySaved ? Icons.favorite : Icons.favorite_border,
          color: alreadySaved ? Colors.red : null,
        ),
      );
    }

    // Function to create and update a list view with rows
    // containing words
    // It has to be created before it can be called in
    // the returned 'Scaffold' widget for the RandomWordsState
    // build function
    Widget _buildSuggestions() {
      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemBuilder: (BuildContext context, int i) {
          if (i.isOdd) {
            return Divider();
          }

          final int index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        }
      );
    }

  // The build function should be put at the end of the class.
  // It will be called to rebuild the entire scaffold every time
  // the state parameters such as _saved is updated. Putting the
  // "_saved" inside as in the previous commit, will reinitialize
  // the state data and nothing would seem to be saved.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: 
        AppBar(
          title: Text('Startup Name Generator'),
        ),
      body: 
        _buildSuggestions(),
    );
  }
}