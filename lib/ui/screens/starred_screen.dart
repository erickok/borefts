import 'package:borefts2020/data/models/beers.dart';
import 'package:flutter/material.dart';

class StarredScreen extends StatelessWidget {
  final Set<Beer> _starred;

  StarredScreen(this._starred);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Starred'),
      ),
      body: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          itemCount: _starred.length,
          itemBuilder: (BuildContext _context, int i) {
            return ListTile(
              title: Text(_starred.elementAt(i).name),
            );
          }),
    );
  }
}
