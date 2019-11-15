import 'package:borefts2020/data/models/beers.dart';
import 'package:borefts2020/ui/components/link_text.dart';
import 'package:borefts2020/ui/components/navigation.dart';
import 'package:borefts2020/ui/components/row_beer.dart';
import 'package:borefts2020/ui/identity/theme.dart';
import 'package:borefts2020/ui/screens/brewer_bloc.dart';
import 'package:borefts2020/ui/screens/events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BrewerScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BrewerBloc, BrewerState>(
      builder: (BuildContext context, BrewerState brewerBeers) {
        return Scaffold(
          body: _buildScreen(brewerBeers),
        );
      },
    );
  }

  Widget _buildScreen(BrewerState brewerBeers) {
    if (brewerBeers is BrewerBeersError) {
      return Center(
        child: Text("Error: " + brewerBeers.error.toString()),
      );
    } else if (brewerBeers is BrewerBeersLoaded) {
      return _buildList(brewerBeers);
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  Widget _buildList(BrewerBeersLoaded brewerBeers) {
    return NestedScrollView(
      headerSliverBuilder:
          (BuildContext buildContext, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            pinned: true,
            title: Text(
              brewerBeers.brewer.name,
              style: headerTextStyle(),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                      children: [
                        Text(brewerBeers.brewer.city + ", " +
                            brewerBeers.brewer.country),
                        LinkText(
                            brewerBeers.brewer.website,
                            brewerBeers.brewer.website),
                      ]),
                ))
            ,
          )
        ];
      },
      body: ListView.builder(
          itemCount: brewerBeers.beers.length,
          itemBuilder: (BuildContext context, int i) {
            final Beer beer = brewerBeers.beers[i];
            return BeerRow(beer, () => openBeer(context, beer), () {
              BlocProvider.of<BrewerBloc>(context).add(
                  BeerStarEvent(beer, !beer.isStarred));
            });
          }),
    );
  }
}
