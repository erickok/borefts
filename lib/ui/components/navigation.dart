import 'package:borefts2020/data/data_bloc.dart';
import 'package:borefts2020/data/models/beers.dart';
import 'package:borefts2020/ui/screens/beer_bloc.dart';
import 'package:borefts2020/ui/screens/beer_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void openBeer(BuildContext context, Beer beer) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (BuildContext context) {
    return BlocProvider<BeerBloc>(
      builder: (_) =>
          BeerBloc(beer, BlocProvider.of<DataBloc>(context)),
      child: BeerScreen(),
    );
  }));
}
