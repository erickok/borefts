import 'package:borefts2020/data/models/brewers.dart';
import 'package:borefts2020/data/repository.dart';
import 'package:flutter/material.dart';

import 'brewer_screen.dart';

class BrewersScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BrewersScreenState();
}

class BrewersScreenState extends State<BrewersScreen> {
  Future<List<Brewer>> _brewers;

  @override
  void initState() {
    super.initState();
    _brewers = Repository.brewers();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Brewer>>(
      future: _brewers,
      builder: (context, brewers) {
        if (brewers.hasData) {
          return ListView.builder(
              itemCount: brewers.data.length,
              itemBuilder: (BuildContext context, int i) {
                return _buildRow(brewers.data[i]);
              });
        } else if (brewers.hasError) {
          return Center(
            child: Text("Error: " + brewers.error.toString()),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _buildRow(Brewer brewer) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        backgroundImage: NetworkImage(brewer.logoUrl),
      ),
      title: Text(brewer.shortName),
      onTap: () {
        _openBrewer(context, brewer);
      },
    );
  }

  void _openBrewer(BuildContext context, Brewer brewer) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return BrewerScreen(brewer);
    }));
  }
}
