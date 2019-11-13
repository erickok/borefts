import 'api.dart';
import 'models/beers.dart';
import 'models/brewers.dart';
import 'models/styles.dart';

class Repository {
  Api _api;
  Set<int> _starredBeers = Set();

  Repository(this._api);

  Future<List<Style>> styles() async {
    return _api.styles().then((list) {
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
    List<Style> rawStyles = await _api.styles();
    List<Beer> rawBeers = await _api.rawBeers();
    rawBeers.retainWhere((beer) => beer.brewerId == brewer.id);
    rawBeers.forEach((beer) => beer.brewer = brewer);
    rawBeers.forEach((beer) =>
    beer.style = rawStyles.firstWhere((style) => style.id == beer.styleId));
    rawBeers.forEach((beer) =>
    beer.isStarred = _starredBeers.contains(beer.id));
    return rawBeers;
  }

  Future<List<Beer>> styleBeers(Style style) async {
    List<Brewer> rawBrewers = await _api.brewers();
    List<Beer> rawBeers = await _api.rawBeers();
    rawBeers.retainWhere((beer) => beer.styleId == style.id);
    rawBeers.forEach((beer) => beer.style = style);
    rawBeers.forEach((beer) =>
    beer.brewer =
        rawBrewers.firstWhere((brewer) => brewer.id == beer.brewerId));
    rawBeers.forEach((beer) =>
    beer.isStarred = _starredBeers.contains(beer.id));
    return rawBeers;
  }

  void starBeer(Beer beer, bool starred) {
    if (starred) {
      _starredBeers.add(beer.id);
    } else {
      _starredBeers.remove(beer.id);
    }
  }
}