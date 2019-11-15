import 'package:borefts2020/data/models/beers.dart';
import 'package:borefts2020/data/repository.dart';
import 'package:borefts2020/ui/screens/beer_bloc.dart';
import 'package:borefts2020/ui/screens/style_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void openBeer(BuildContext outerContext, Beer beer) {
  Navigator.of(outerContext)
      .push(MaterialPageRoute(builder: (BuildContext context) {
    return BlocProvider<BeerBloc>(
      builder: (_) =>
          BeerBloc(RepositoryProvider.of<Repository>(outerContext), beer),
      child: StyleScreen(),
    );
  }));
}
