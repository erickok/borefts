import 'package:bloc/bloc.dart';
import 'package:borefts2020/data/data_bloc.dart';
import 'package:borefts2020/data/models/brewers.dart';

abstract class BrewersState {}

class BrewersLoading extends BrewersState {}

class BrewersError extends BrewersState {
  final String error;

  BrewersError(this.error);
}

class BrewersLoaded extends BrewersState {
  final List<Brewer> brewers;

  BrewersLoaded(this.brewers);
}

class BrewersBloc extends Bloc<DataRepoEvent, BrewersState> {
  final DataBloc _dataBloc;

  BrewersBloc(this._dataBloc) {
    _dataBloc.listen((data) {
      if (data is DataLoaded) {
        add(DataUpdatedEvent(data));
      }
    });
  }

  @override
  BrewersState get initialState => BrewersLoading();

  @override
  Stream<BrewersState> mapEventToState(DataRepoEvent event) async* {
    if (event is DataUpdatedEvent) {
      yield BrewersLoaded(event.dataLoaded.brewers);
    }
  }
}
