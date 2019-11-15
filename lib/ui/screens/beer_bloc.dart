import 'package:bloc/bloc.dart';
import 'package:borefts2020/data/models/beers.dart';
import 'package:borefts2020/data/repository.dart';
import 'package:borefts2020/ui/screens/events.dart';

class BeerLoadedState {
  final Beer beer;

  BeerLoadedState(this.beer);
}

class BeerBloc extends Bloc<BeersScreenEvent, BeerLoadedState> {
  final Repository _repository;
  final Beer _beer;

  BeerBloc(this._repository, this._beer);

  @override
  BeerLoadedState get initialState => BeerLoadedState(_beer);

  @override
  Stream<BeerLoadedState> mapEventToState(BeersScreenEvent event) async* {
    if (event is BeerStarEvent) {
      // Update and yield local list
      state.beer.isStarred = event.starred;
      yield BeerLoadedState(state.beer);
      // Persist star status
      await _repository.starBeer(event.beer, event.starred);
    }
  }
}
