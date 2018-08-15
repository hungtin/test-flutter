import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        body: Center(
          child: RandomWords(),
        ),
      ),
    );
  }
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final Set<WordPair> _saves = Set<WordPair>();
  @override
  Widget build(BuildContext context) {
    // final wordPair = WordPair.random();
    return Scaffold(
        appBar: AppBar(
          title: Text('Welcome to Flutter'),
          actions: <Widget>[
            new IconButton(icon: const Icon(Icons.list), onPressed: _pushSave,)
          ],),
        body: Center(
          child: _buildSuggestion(),
        ),
    );
  }

  _pushSave() {
    print("Click _pushSave()");
  }

  _buildSuggestion() {
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();
          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }

          return _buildListTile(_suggestions[index]);
        });
  }

  _buildListTile(WordPair wordPair) {
    final alreadySaved = _saves.contains(wordPair);
    return ListTile(
      title: Text(
        wordPair.asPascalCase,
        style: TextStyle(fontSize: 18.0),
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState((){
          if (alreadySaved) {
            _saves.remove(wordPair);
          } else {
            _saves.add(wordPair);
          }
        });
      },
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() {
    // TODO: implement createState
    return new RandomWordsState();
  }
}
