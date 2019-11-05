import 'package:borefts2020/data/models/styles.dart';
import 'package:borefts2020/ext/types.dart';

import 'brewers.dart';

class Beers {
  final List<Beer> beers;

  Beers(this.beers);

  factory Beers.fromJson(Map<String, dynamic> json) {
    Iterable beers = json['beers'];
    return Beers(new List<Beer>.from(
      beers.map((beer) => Beer.fromJson(beer)).toList(),
    ));
  }
}

class Beer {
  final int id;
  final String name;
  final int brewerId;
  final int styleId;
  final double abv;
  final bool oakAged;
  final bool festivalBeer;
  final String tags;
  final int untappdId;
  final String serving;
  final int color;
  final int body;
  final int bitter;
  final int sweet;
  final int sour;

  // Added by the app
  Brewer brewer;
  Style style;
  bool isStarred;

  Beer(
      this.id,
      this.name,
      this.brewerId,
      this.styleId,
      this.abv,
      this.oakAged,
      this.festivalBeer,
      this.tags,
      this.untappdId,
      this.serving,
      this.color,
      this.body,
      this.bitter,
      this.sweet,
      this.sour);

  String fullName() {
    return brewer.name + " " + name;
  }

  factory Beer.fromJson(Map<String, dynamic> json) {
    return Beer(
        json['id'],
        json['name'],
        cst(json['brewerId']),
        cst(json['styleId']),
        cst(json['abv']),
        cst(json['oakAged']),
        cst(json['festivalBeer']),
        cst(json['tags']),
        cst(json['untappdId']),
        cst(json['serving']),
        cst(json['color']),
        cst(json['body']),
        cst(json['bitter']),
        cst(json['sweet']),
        cst(json['sour']));
  }
}
