import 'package:flutter/material.dart';
import 'map.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Covid 19 map',
      home: HomeWidget(),
      theme: ThemeData(primaryColor: Colors.red),
    );
  }
}

class HomeWidget extends StatefulWidget {
  @override
  HomeWidgetState createState() => HomeWidgetState();
}

class HomeWidgetState extends State<StatefulWidget> {
  final List<String> _continents = <String>[
    'Europe',
    'North America',
    'Africa',
    'India',
    'South America',
    'Asia',
    'World'
  ];
  final List<String> _continentsKey = <String>[
    'eu',
    'na',
    'af',
    'in',
    'sa',
    'as',
    'ww'
  ];

  // final Set<WordPair> _saved = Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Covid 19'),
        ),
        body: _buildSuggestions());
  }

  void _openMap(String continent, String continentKey) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text(continent),
            ),
            body: GmapApp(continent, continentKey),
          );
        },
      ),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i < _continents.length * 2) {
            if (i.isOdd) return Divider();
            final index = i ~/ 2;
            return _buildRow(_continents[index], index);
          }
          return null;
        });
  }

  Widget _buildRow(String country, index) {
    return ListTile(
      title: Text(
        country,
        style: _biggerFont,
      ),
      onTap: () {
        _openMap(country, _continentsKey[index]);
      },
    );
  }
}
