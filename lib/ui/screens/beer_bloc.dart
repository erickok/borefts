import 'package:bloc/bloc.dart';
import 'package:borefts2020/data/data_bloc.dart';
import 'package:borefts2020/data/models/beers.dart';

class BeerLoadedState {
  final Beer beer;

  BeerLoadedState(this.beer);
}

class BeerBloc extends Bloc<DataRepoEvent, BeerLoadedState> {
  final Beer _beer;
  final DataBloc _dataBloc;

  BeerBloc(this._beer, this._dataBloc) {
    _dataBloc.listen((data) {
      if (data is DataLoaded) {
        add(DataUpdatedEvent(data));
      }
    });
  }

  @override
  BeerLoadedState get initialState => BeerLoadedState(_beer);

  @override
  Stream<BeerLoadedState> mapEventToState(DataRepoEvent event) async* {
    if (event is DataUpdatedEvent) {
      yield BeerLoadedState(
          event.dataLoaded.beers.firstWhere((b) => b.id == _beer.id));
    } else if (event is UpdateStarEvent) {
      _dataBloc.add(event);
    }
  }
}
