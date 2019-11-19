import 'package:bloc/bloc.dart';
import 'package:borefts2020/data/data_bloc.dart';
import 'package:borefts2020/data/models/beers.dart';
import 'package:borefts2020/data/models/brewers.dart';

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

class BrewerBloc extends Bloc<DataRepoEvent, BrewerState> {
  final Brewer _brewer;
  final DataBloc _dataBloc;

  BrewerBloc(this._brewer, this._dataBloc) {
    _dataBloc.listen((data) {
      if (data is DataLoaded) {
        add(DataUpdatedEvent(data));
      }
    });
  }

  @override
  BrewerState get initialState => BrewerBeersLoading();

  @override
  Stream<BrewerState> mapEventToState(DataRepoEvent event) async* {
    if (event is DataUpdatedEvent) {
      List<Beer> beers = event.dataLoaded.beers.where((b) =>
      b.brewerId == _brewer.id).toList(growable: false);
      yield BrewerBeersLoaded(_brewer, beers);
    } else if (event is UpdateStarEvent) {
      _dataBloc.add(event);
//      }
    }
  }
}
