import 'package:bloc/bloc.dart';
import 'package:borefts2020/data/models/brewers.dart';
import 'package:borefts2020/data/repository.dart';

import 'events.dart';

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

class BrewersBloc extends Bloc<DataScreenEvent, BrewersState> {
  final Repository _repository;

  BrewersBloc(this._repository);

  @override
  BrewersState get initialState => BrewersLoading();

  @override
  Stream<BrewersState> mapEventToState(DataScreenEvent event) async* {
    List<Brewer> brewers = await _repository.brewers();
    yield BrewersLoaded(brewers);
  }
}
