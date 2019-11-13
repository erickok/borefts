import 'package:borefts2020/data/models/beers.dart';
import 'package:borefts2020/ui/identity/color.dart';
import 'package:borefts2020/ui/identity/theme.dart';
import 'package:borefts2020/ui/screens/style_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'events.dart';

class StyleScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StyleBloc, StyleState>(
      builder: (BuildContext context, StyleState styleBeers) {
        return Scaffold(
          body: _buildScreen(styleBeers),
        );
      },
    );
  }

  Widget _buildScreen(StyleState styleBeers) {
    if (styleBeers is StyleBeersError) {
      return Center(
        child: Text("Error: " + styleBeers.error.toString()),
      );
    } else if (styleBeers is StyleBeersLoaded) {
      return _buildList(styleBeers);
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  Widget _buildList(StyleBeersLoaded styleBeers) {
    return NestedScrollView(
      headerSliverBuilder:
          (BuildContext buildContext, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            pinned: true,
            title: Text(
              styleBeers.style.name,
              style: headerTextStyle(),
            ),
          ),
/* TODO style flavour bars
          SliverToBoxAdapter(
            child: Container(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                      children: [
                        Text(styleBeers.style.city + ", " +
                            styleBeers.style.country),
                        LinkText(
                            styleBeers.style.website,
                            styleBeers.style.website),
                      ]),
                ))
            ,
          )
*/
        ];
      },
      body: ListView.builder(
          itemCount: styleBeers.beers.length,
          itemBuilder: (BuildContext context, int i) {
            return _buildRow(context, styleBeers.beers[i]);
          }),
    );
  }

  Widget _buildRow(BuildContext context, Beer beer) {
    return ListTile(
      title: Text(beer.name),
      trailing: Icon(
        beer.isStarred ? Icons.star : Icons.star_border,
        color: beer.isStarred ? redDark : null,
      ),
      onTap: () {
        BlocProvider.of<StyleBloc>(context).add(
            BeerStarEvent(beer, !beer.isStarred));
      },
    );
  }
}
