import 'package:bloc/bloc.dart';
import 'package:borefts2020/data/data_bloc.dart';
import 'package:borefts2020/data/models/beers.dart';
import 'package:borefts2020/data/models/styles.dart';

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

class StyleBloc extends Bloc<DataRepoEvent, StyleState> {
  final Style _style;
  final DataBloc _dataBloc;

  StyleBloc(this._style, this._dataBloc) {
    _dataBloc.listen((data) {
      if (data is DataLoaded) {
        add(DataUpdatedEvent(data));
      }
    });
  }

  @override
  StyleState get initialState => StyleBeersLoading();

  @override
  Stream<StyleState> mapEventToState(DataRepoEvent event) async* {
    if (event is DataUpdatedEvent) {
      List<Beer> beers = event.dataLoaded.beers.where((b) =>
      b.styleId == _style.id).toList(growable: false);
      yield StyleBeersLoaded(_style, beers);
    } else if (event is UpdateStarEvent) {
      _dataBloc.add(event);
//      if (state is StyleBeersLoaded) {
//        final loadedState = state as StyleBeersLoaded;
//        // Update and yield local list
//        for (final Beer beer in loadedState.beers) {
//          if (beer == event.beer) {
//            beer.isStarred = event.starred;
//          }
//        }
//        yield StyleBeersLoaded(_style, loadedState.beers);
//        // Persist star status
//        await _repository.starBeer(event.beer, event.starred);
//      }
    }
  }
}
