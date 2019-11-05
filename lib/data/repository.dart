import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import 'models/beers.dart';
import 'models/brewers.dart';
import 'models/styles.dart';

class Repository {
  static const String _baseUrl = "https://borefts-staging.firebaseio.com/";
  static Set<Beer> _starredBeers = Set();

  static Future<List<Style>> styles() async {
    Response response = await http.get(_baseUrl + "styles/2019.json");
    return Styles.fromJson(json.decode(response.body)).styles;
  }

  static Future<List<Brewer>> brewers() async {
    Response response = await http.get(_baseUrl + "brewers/2019.json");
    return Brewers.fromJson(json.decode(response.body)).brewers;
  }

  static Future<List<Beer>> _rawBeers() async {
    Response response = await http.get(_baseUrl + "beers/2019.json");
    return Beers.fromJson(json.decode(response.body)).beers;
  }

  static Future<List<Beer>> beers() async {
    List<Style> rawStyles = await styles();
    List<Brewer> rawBrewers = await brewers();
    List<Beer> rawBeers = await _rawBeers();
    rawBeers.forEach((beer) => beer.brewer =
        rawBrewers.firstWhere((brewer) => brewer.id == beer.brewerId));
    rawBeers.forEach((beer) =>
        beer.style = rawStyles.firstWhere((style) => style.id == beer.styleId));
    rawBeers.forEach((beer) => beer.isStarred = _starredBeers.contains(beer));
    return rawBeers;
  }

  static Future<List<Beer>> brewerBeers(Brewer brewer) async {
    List<Style> rawStyles = await styles();
    List<Beer> rawBeers = await _rawBeers();
    rawBeers.retainWhere((beer) => beer.brewerId == brewer.id);
    rawBeers.forEach((beer) => beer.brewer = brewer);
    rawBeers.forEach((beer) =>
        beer.style = rawStyles.firstWhere((style) => style.id == beer.styleId));
    rawBeers.forEach((beer) => beer.isStarred = _starredBeers.contains(beer));
    return rawBeers;
  }

  static void starBeer(Beer beer, bool starred) {
    if (starred) {
      _starredBeers.add(beer);
    } else {
      _starredBeers.remove(beer);
    }
  }
}
