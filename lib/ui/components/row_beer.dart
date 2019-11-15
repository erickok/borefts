import 'package:borefts2020/data/models/beers.dart';
import 'package:borefts2020/ui/identity/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BeerRow extends StatelessWidget {
  final Beer _beer;
  final GestureTapCallback _onNameTap;
  final GestureTapCallback _onStarTap;

  BeerRow(this._beer, this._onNameTap, this._onStarTap);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(_beer.name),
      trailing: GestureDetector(
        child: Icon(
          _beer.isStarred ? Icons.star : Icons.star_border,
          color: _beer.isStarred ? redDark : null,
        ),
          onTap: _onStarTap,
      ),
      onTap: _onNameTap,
    );
  }

}