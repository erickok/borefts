import 'package:borefts2020/data/data_bloc.dart';
import 'package:borefts2020/data/models/brewers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'brewer_bloc.dart';
import 'brewer_screen.dart';
import 'brewers_bloc.dart';

class BrewersScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BrewersBloc, BrewersState>(
      builder: (BuildContext context, BrewersState brewers) {
        return Scaffold(
          body: _buildScreen(brewers),
        );
      },
    );
  }

  Widget _buildScreen(BrewersState brewers) {
    if (brewers is BrewersLoaded) {
      return _buildList(brewers.brewers);
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  Widget _buildList(List<Brewer> brewers) {
    return ListView.builder(
        itemCount: brewers.length,
        itemBuilder: (BuildContext context, int i) {
          return _buildRow(context, brewers[i]);
        });
  }

  Widget _buildRow(BuildContext context, Brewer brewer) {
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

  void _openBrewer(BuildContext outerContext, Brewer brewer) {
    Navigator.of(outerContext)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return BlocProvider<BrewerBloc>(
        builder: (_) =>
            BrewerBloc(brewer, BlocProvider.of<DataBloc>(outerContext)),
        child: BrewerScreen(),
      );
    }));
  }
}
