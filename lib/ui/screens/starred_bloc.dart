import 'package:bloc/bloc.dart';
import 'package:borefts2020/data/data_bloc.dart';
import 'package:borefts2020/data/models/beers.dart';

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

class StarredBloc extends Bloc<DataRepoEvent, StarredState> {
  final DataBloc _dataBloc;

  StarredBloc(this._dataBloc) {
    _dataBloc.listen((data) {
      if (data is DataLoaded) {
        add(DataUpdatedEvent(data));
      }
    });
  }

  @override
  StarredState get initialState => StarredLoading();

  @override
  Stream<StarredState> mapEventToState( event) async* {
    if (event is DataUpdatedEvent) {
      List<Beer> starredBeers = event.dataLoaded.beers.where((b) =>
      b.isStarred).toList(growable: false);
      yield StarredLoaded(starredBeers);
    } else if (event is UpdateStarEvent) {
      if (state is StarredLoaded) {
//        final loadedState = state as StarredLoaded;
//        // Update and yield local list
//        for (final Beer beer in loadedState.beers) {
//          if (beer == event.beer) {
//            beer.isStarred = event.starred;
//          }
//        }
//        yield StarredLoaded(loadedState.beers);
        // Persist star status
        _dataBloc.add(event);
      }
    }
  }
}
