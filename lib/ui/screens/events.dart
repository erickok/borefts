import 'package:borefts2020/data/models/beers.dart';

abstract class DataScreenEvent {}

class LoadEvent extends DataScreenEvent {}

abstract class BeersScreenEvent {}

class BeersLoadEvent extends BeersScreenEvent {}

class BeerStarEvent extends BeersScreenEvent {
  final Beer beer;
  final bool starred;

  BeerStarEvent(this.beer, this.starred);
}
