import 'package:borefts2020/data/data_bloc.dart';
import 'package:borefts2020/ui/components/navigation.dart';
import 'package:borefts2020/ui/components/row_beer.dart';
import 'package:borefts2020/ui/screens/starred_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StarredScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StarredBloc, StarredState>(
      builder: (BuildContext context, StarredState styleBeers) {
        return Scaffold(
          body: _buildScreen(styleBeers),
        );
      },
    );
  }

  Widget _buildScreen(StarredState starredState) {
    if (starredState is StarredError) {
      return Center(
        child: Text("Error: " + starredState.error.toString()),
      );
    } else if (starredState is StarredLoaded && starredState.beers.isEmpty) {
      return Center(
        child: Text("No starred beers yet"),
      );
    } else if (starredState is StarredLoaded) {
      return _buildList(starredState);
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  Widget _buildList(StarredLoaded styleBeers) {
    return ListView.builder(
        itemCount: styleBeers.beers.length,
        itemBuilder: (BuildContext context, int i) {
          var beer = styleBeers.beers[i];
          return BeerRow(beer, () => openBeer(context, beer), () {
            BlocProvider.of<StarredBloc>(context).add(
                UpdateStarEvent(
                    beer, !beer.isStarred));
          });
        });
  }
}
