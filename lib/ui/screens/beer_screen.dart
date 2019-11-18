import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'beer_bloc.dart';

class BeerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BeerBloc, BeerLoadedState>(
      builder: (BuildContext context, BeerLoadedState state) {
        return Scaffold(
          body: _buildScreen(state),
        );
      },
    );
  }

  Widget _buildScreen(BeerLoadedState state) {
    return Center(
      child: Text(state.beer.fullName()),
    );
  }
}
