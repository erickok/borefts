import 'package:bloc/bloc.dart';
import 'package:borefts2020/data/models/beers.dart';
import 'package:borefts2020/data/repository.dart';

import 'events.dart';

abstract class StarredState {}

class StarredLoading extends StarredState {}

class StarredError extends StarredState {
  final String error;

  StarredError(this.error);
}

class StarredLoaded extends StarredState {
  final List<Beer> beers;

  StarredLoaded(this.beers);
}

class StarredBloc extends Bloc<BeersScreenEvent, StarredState> {
  final Repository _repository;

  StarredBloc(this._repository);

  @override
  StarredState get initialState => StarredLoading();

  @override
  Stream<StarredState> mapEventToState(BeersScreenEvent event) async* {
    if (event is BeersLoadEvent) {
      List<Beer> beers = await _repository.starredBeers();
      yield StarredLoaded(beers);
    } else if (event is BeerStarEvent) {
      if (state is StarredLoaded) {
        final loadedState = state as StarredLoaded;
        // Update and yield local list
        for (final Beer beer in loadedState.beers) {
          if (beer == event.beer) {
            beer.isStarred = event.starred;
          }
        }
        yield StarredLoaded(loadedState.beers);
        // Persist star status
        await _repository.starBeer(event.beer, event.starred);
      }
    }
  }
}
