import 'package:bloc/bloc.dart';
import 'package:borefts2020/data/models/beers.dart';
import 'package:borefts2020/data/models/brewers.dart';
import 'package:borefts2020/data/repository.dart';
import 'package:borefts2020/ui/screens/events.dart';

abstract class BrewerState {}

class BrewerBeersLoading extends BrewerState {}

class BrewerBeersError extends BrewerState {
  final String error;

  BrewerBeersError(this.error);
}

class BrewerBeersLoaded extends BrewerState {
  final Brewer brewer;
  final List<Beer> beers;

  BrewerBeersLoaded(this.brewer, this.beers);
}

class BrewerBloc extends Bloc<BeersScreenEvent, BrewerState> {
  final Repository _repository;
  final Brewer _brewer;

  BrewerBloc(this._repository, this._brewer);

  @override
  BrewerState get initialState => BrewerBeersLoading();

  @override
  Stream<BrewerState> mapEventToState(BeersScreenEvent event) async* {
    if (event is BeersLoadEvent) {
      List<Beer> beers = await _repository.brewerBeers(_brewer);
      yield BrewerBeersLoaded(_brewer, beers);
    } else if (event is BeerStarEvent) {
      if (state is BrewerBeersLoaded) {
        final loadedState = state as BrewerBeersLoaded;
        // Update and yield local list
        for (final Beer beer in loadedState.beers) {
          if (beer == event.beer) {
            beer.isStarred = event.starred;
          }
        }
        yield BrewerBeersLoaded(_brewer, loadedState.beers);
        // Persist star status
        await _repository.starBeer(event.beer, event.starred);
      }
    }
  }
}
