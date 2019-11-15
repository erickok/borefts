import 'package:shared_preferences/shared_preferences.dart';

import 'models/beers.dart';

class Starred {
  Set<int> _starredBeers;

  Future<SharedPreferences> _prefs() async {
    return await SharedPreferences.getInstance();
  }

  Future _ensureStarsLoaded() async {
    if (_starredBeers == null) {
      final prefs = await _prefs();
      final List<String> stars = prefs.getStringList("stars");
      _starredBeers = Set();
      if (stars != null) {
        stars.forEach(
            (starredBeerId) => _starredBeers.add(int.parse(starredBeerId)));
      }
    }
  }

  void _persistStars() async {
    final prefs = await _prefs();
    final List<String> starredAsStrings = _starredBeers
        .map((beerId) => beerId.toString())
        .toList(growable: false);
    prefs.setStringList("stars", starredAsStrings);
  }

  Future<Set<int>> stars() async {
    await _ensureStarsLoaded();
    return _starredBeers;
  }

  Future<bool> contains(Beer beer) async {
    await _ensureStarsLoaded();
    return _starredBeers.contains(beer.id);
  }

  Future updateStar(Beer beer, bool starred) async {
    await _ensureStarsLoaded();
    if (starred) {
      _starredBeers.add(beer.id);
    } else {
      _starredBeers.remove(beer.id);
    }
    _persistStars();
  }
}
