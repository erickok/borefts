import 'package:borefts2020/data/models/beers.dart';
import 'package:borefts2020/data/repository.dart';
import 'package:borefts2020/ui/identity/color.dart';
import 'package:borefts2020/ui/screens/starred_screen.dart';
import 'package:flutter/material.dart';

class BeersScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BeersScreenState();
}

class BeersScreenState extends State<BeersScreen> {
  final Set<Beer> _starred = Set();
  Future<List<Beer>> _beers;

  @override
  void initState() {
    super.initState();
    _beers = Repository.beers();
  }

  void _starBeer(Beer beer) {
    setState(() {
      if (_starred.contains(beer)) {
        _starred.remove(beer);
      } else {
        _starred.add(beer);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Beer>>(
      future: _beers,
      builder: (context, beersOpt) {
        if (beersOpt.hasData) {
          return ListView.builder(
              itemCount: beersOpt.data.length,
              itemBuilder: (BuildContext context, int i) {
                return _buildRow(beersOpt.data[i]);
              });
        } else if (beersOpt.hasError) {
          return Center(
            child: Text("Error: " + beersOpt.error.toString()),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _buildRow(Beer beer) {
    final bool _isStarred = _starred.contains(beer);
    return ListTile(
      title: Text(beer.fullName()),
      trailing: Icon(
        _isStarred ? Icons.star : Icons.star_border,
        color: _isStarred ? redDark : null,
      ),
      onTap: () {
        _starBeer(beer);
      },
    );
  }

  void _openStarred(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return StarredScreen(_starred);
    }));
  }
}
