import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/beers.dart';

class StarRepository {
  final BehaviorSubject<Set<int>> _stars = BehaviorSubject();

  Stream<Set<int>> stars() {
    return _stars.doOnListen(() async {
      // Initially emit the stored stars
      _stars.add(await StarPersistence.persistedStars());
    });
  }

  void star(Beer beer, bool starred) async {
    Set<int> newStars = Set.from(_stars.value);
    if (starred) {
      newStars.add(beer.id);
    } else {
      newStars.remove(beer.id);
    }
    _stars.add(newStars);
    await StarPersistence.persist(newStars);
  }
}

class StarPersistence {
  static Future<Set<int>> persistedStars() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> prefList = prefs.getStringList("stars");
    final Set<int> idsSet = Set();
    if (prefList != null) {
      prefList.forEach((starredBeerId) => idsSet.add(int.parse(starredBeerId)));
    }
    return idsSet;
  }

  static Future<void> persist(Set<int> starredBeerIds) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> starredAsStrings = starredBeerIds
        .map((beerId) => beerId.toString())
        .toList(growable: false);
    prefs.setStringList("stars", starredAsStrings);
  }
}
