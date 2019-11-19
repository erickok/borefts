import 'package:bloc/bloc.dart';
import 'package:borefts2020/data/beers_repository.dart';
import 'package:borefts2020/data/models/beers.dart';
import 'package:borefts2020/data/models/brewers.dart';
import 'package:borefts2020/data/models/styles.dart';
import 'package:borefts2020/data/star_repository.dart';

abstract class DataRepoEvent {}

class LoadDataEvent extends DataRepoEvent {}

class DataErrorEvent extends DataRepoEvent {
  final String error;

  DataErrorEvent(this.error);
}

class DataUpdatedEvent extends DataRepoEvent {
  final DataLoaded dataLoaded;

  DataUpdatedEvent(this.dataLoaded);
}

class UpdateStarEvent extends DataRepoEvent {
  final Beer beer;
  final bool starred;

  UpdateStarEvent(this.beer, this.starred);
}

abstract class DataState {}

class DataLoading extends DataState {}

class DataLoaded extends DataState {
  final List<Style> styles;
  final List<Brewer> brewers;
  final List<Beer> beers;

  DataLoaded(this.styles, this.brewers, this.beers);
}

class DataError extends DataState {
  final String error;

  DataError(this.error);
}

class DataBloc extends Bloc<DataRepoEvent, DataState> {
  final BeersRepository _beersRepository;
  final StarRepository _starRepository;

  DataBloc(this._beersRepository, this._starRepository) {
    add(LoadDataEvent());
  }

  @override
  DataState get initialState => DataLoading();

  @override
  Stream<DataState> mapEventToState(DataRepoEvent event) async* {
    if (event is LoadDataEvent) {
//      await _starRepository.init();
      _beersRepository
          .beersStyleAndBrewers(_starRepository.stars())
          .listen((d) => add(DataUpdatedEvent(d)),
          onError: (e) => add(DataErrorEvent(e)));
    }
    if (event is DataUpdatedEvent) {
      yield event.dataLoaded;
    }
    if (event is DataErrorEvent) {
      yield DataError(event.error);
    }
    if (event is UpdateStarEvent) {
      _starRepository.star(event.beer, event.starred);
    }
  }
}
