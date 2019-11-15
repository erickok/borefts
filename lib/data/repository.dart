import 'package:borefts2020/data/starred.dart';

import 'api.dart';
import 'models/beers.dart';
import 'models/brewers.dart';
import 'models/styles.dart';

class Repository {
  Api _api;
  Starred _starred;

  Repository(this._api, this._starred);

  Future<List<Beer>> _cachedBeers() async {
    // TODO Cache
    //    return _cachedRawBeers.fetch(() => _api.rawBeers());
    return _api.rawBeers();
  }

  Future<List<Beer>> _enrichedBeers() async {
    // TODO Cache
    List<Style> rawStyles = await _api.styles();
    List<Brewer> rawBrewers = await _api.brewers();
    List<Beer> rawBeers = await _cachedBeers();
    Set<int> stars = await _starred.stars();

    rawBeers.forEach((beer) =>
    beer.brewer =
        rawBrewers.firstWhere((brewer) => brewer.id == beer.brewerId));
    rawBeers.forEach((beer) =>
    beer.style = rawStyles.firstWhere((style) => style.id == beer.styleId));
    rawBeers.forEach((beer) =>
    beer.isStarred = stars.contains(beer.id));
    rawBeers.sort((b1, b2) => b1.fullName().compareTo(b2.fullName()));
    return rawBeers;
  }

  Future<List<Style>> styles() async {
    List<Beer> rawBeers = await _cachedBeers();
    return _api.styles()
        .then((list) =>
    // Filter styles with beers
    list.where((style) => rawBeers.any((beer) => beer.styleId == style.id))
        .toList())
        .then((list) {
      // Sort styles by name
      list.sort((s1, s2) => s1.name.compareTo(s2.name));
      return list;
    });
  }

  Future<List<Brewer>> brewers() async {
    return _api.brewers().then((list) {
      list.sort((b1, b2) => b1.sortName.compareTo(b2.sortName));
      return list;
    });
  }

  Future<List<Beer>> brewerBeers(Brewer brewer) async {
    List<Beer> beers = await _enrichedBeers();
    beers.retainWhere((beer) => beer.brewerId == brewer.id);
    return beers;
  }

  Future<List<Beer>> styleBeers(Style style) async {
    List<Beer> beers = await _enrichedBeers();
    beers.retainWhere((beer) => beer.styleId == style.id);
    return beers;
  }

  Future<List<Beer>> starredBeers() async {
    List<Beer> beers = await _enrichedBeers();
    Set<int> stars = await _starred.stars();
    beers.retainWhere((beer) => stars.contains(beer.id));
    return beers;
  }

  Future starBeer(Beer beer, bool starred) async {
    await _starred.updateStar(beer, starred);
  }
}