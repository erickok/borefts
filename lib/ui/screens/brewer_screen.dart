import 'package:borefts2020/data/models/beers.dart';
import 'package:borefts2020/data/models/brewers.dart';
import 'package:borefts2020/data/repository.dart';
import 'package:borefts2020/ui/identity/color.dart';
import 'package:borefts2020/ui/identity/theme.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BrewerScreen extends StatefulWidget {
  final Brewer brewer;

  BrewerScreen(this.brewer);

  @override
  State<StatefulWidget> createState() => BrewerScreenState(brewer);
}

class BrewerScreenState extends State<BrewerScreen> {
  final Brewer brewer;
  Future<List<Beer>> _beers;

  BrewerScreenState(this.brewer);

  @override
  void initState() {
    super.initState();
    _beers = Repository.brewerBeers(brewer);
  }

  void _starBeer(Beer beer) {
    setState(() {
      Repository.starBeer(beer, beer.isStarred);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder:
            (BuildContext buildContext, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              pinned: true,
              title: Text(
                brewer.name,
                style: headerTextStyle(),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Text(brewer.city + ", " + brewer.country),
                    InkWell(
                      child: Text(
                        brewer.website,
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: redDark),
                      ),
                      onTap: () {
                        launch(brewer.website);
                      },
                    ),
                  ],
                ),
              ),
            )
          ];
        },
        body: FutureBuilder<List<Beer>>(
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
        ),
      ),
    );
  }

  Widget _buildRow(Beer beer) {
    return ListTile(
      title: Text(beer.name),
      trailing: Icon(
        beer.isStarred ? Icons.star : Icons.star_border,
        color: beer.isStarred ? redDark : null,
      ),
      onTap: () {
        _starBeer(beer);
      },
    );
  }
}
