import 'package:bloc/bloc.dart';
import 'package:borefts2020/data/models/beers.dart';
import 'package:borefts2020/data/models/styles.dart';
import 'package:borefts2020/data/repository.dart';

import 'events.dart';

abstract class StyleState {}

class StyleBeersLoading extends StyleState {}

class StyleBeersError extends StyleState {
  final String error;

  StyleBeersError(this.error);
}

class StyleBeersLoaded extends StyleState {
  final Style style;
  final List<Beer> beers;

  StyleBeersLoaded(this.style, this.beers);
}

class StyleBloc extends Bloc<BeersScreenEvent, StyleState> {
  final Repository _repository;
  final Style _style;

  StyleBloc(this._repository, this._style);

  @override
  StyleState get initialState => StyleBeersLoading();

  @override
  Stream<StyleState> mapEventToState(BeersScreenEvent event) async* {
    if (event is BeersLoadEvent) {
      List<Beer> beers = await _repository.styleBeers(_style);
      yield StyleBeersLoaded(_style, beers);
    } else if (event is BeerStarEvent) {
      if (state is StyleBeersLoaded) {
        final loadedState = state as StyleBeersLoaded;
        // Update and yield local list
        for (final Beer beer in loadedState.beers) {
          if (beer == event.beer) {
            beer.isStarred = event.starred;
          }
        }
        yield StyleBeersLoaded(_style, loadedState.beers);
        // Persist star status
        await _repository.starBeer(event.beer, event.starred);
      }
    }
  }
}
