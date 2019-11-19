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
      } else if (data is DataError) {
        add(DataErrorEvent(data.error));
      }
    });
  }

  @override
  StarredState get initialState => StarredLoading();

  @override
  Stream<StarredState> mapEventToState(DataRepoEvent event) async* {
    if (event is DataUpdatedEvent) {
      List<Beer> starredBeers = event.dataLoaded.beers.where((b) =>
      b.isStarred).toList(growable: false);
      yield StarredLoaded(starredBeers);
    } else if (event is DataErrorEvent) {
      yield StarredError(event.error);
    } else if (event is UpdateStarEvent) {
      if (state is StarredLoaded) {
        _dataBloc.add(event);
      }
    }
  }
}
