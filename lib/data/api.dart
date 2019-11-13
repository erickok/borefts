import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import 'models/beers.dart';
import 'models/brewers.dart';
import 'models/styles.dart';

class Api {
  static const String _baseUrl = "https://borefts-staging.firebaseio.com/";

  Future<List<Style>> styles() async {
    Response response = await http.get(_baseUrl + "styles/2019.json");
    return Styles.fromJson(json.decode(response.body)).styles;
  }

  Future<List<Brewer>> brewers() async {
    Response response = await http.get(_baseUrl + "brewers/2019.json");
    return Brewers.fromJson(json.decode(response.body)).brewers;
  }

  Future<List<Beer>> rawBeers() async {
    Response response = await http.get(_baseUrl + "beers/2019.json");
    return Beers.fromJson(json.decode(response.body)).beers;
  }
}
