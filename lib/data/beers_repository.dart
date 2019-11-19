import 'package:borefts2020/data/models/beers.dart';
import 'package:borefts2020/data/models/brewers.dart';
import 'package:borefts2020/data/models/styles.dart';
import 'package:rxdart/rxdart.dart';

import 'api.dart';
import 'data_bloc.dart';

class BeersRepository {
  final Api _api;

  BeersRepository(this._api);

  Future<List<Style>> _rawStyles() async {
    return _api.styles();
  }

  Future<List<Brewer>> _rawBrewers() async {
    return _api.brewers();
  }

  Future<List<Beer>> _rawBeers() async {
    return _api.rawBeers();
  }

  Future<List<Style>> _relevantStyles() async {
    final List<Beer> allBeers = await _rawBeers();
    return _rawStyles().then((l) => l
        .where((s) => allBeers.any((b) => b.styleId == s.id))
        .toList(growable: false));
  }

  Future<List<Style>> styles() {
    return _relevantStyles()
        .then((l) => l..sort((s1, s2) => s1.name.compareTo(s2.name)));
  }

  Future<List<Brewer>> brewers() {
    return _rawBrewers()
        .then((l) => l..sort((b1, b2) => b1.sortName.compareTo(b2.sortName)));
  }

  Future<List<Beer>> beers() async {
    final List<Brewer> allBrewers = await _rawBrewers();
    final List<Style> allStyles = await _relevantStyles();
    return _rawBeers().then((l) => l
      ..forEach((b) {
        b.brewer = allBrewers.firstWhere((br) => br.id == b.brewerId);
        b.style = allStyles.firstWhere((st) => st.id == b.styleId);
        return b;
      }));
  }

  Stream<List<Beer>> beersAndStars(Stream<Set<int>> starred) {
    return Observable.combineLatest2(beers().asStream(), starred,
        (List<Beer> beers, Set<int> stars) {
      beers.forEach((b) => b.isStarred = stars.contains(b.id));
      return beers;
    });
  }

  Stream<DataLoaded> beersStyleAndBrewers(Stream<Set<int>> starred) {
    return Observable.combineLatest3(
        styles().asStream(),
        brewers().asStream(),
        beersAndStars(starred),
        (List<Style> styles, List<Brewer> brewers, List<Beer> beers) =>
            DataLoaded(styles, brewers, beers));
  }
}
