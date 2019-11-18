import 'package:bloc/bloc.dart';
import 'package:borefts2020/data/data_bloc.dart';
import 'package:borefts2020/data/models/styles.dart';

abstract class StylesState {}

class StylesLoading extends StylesState {}

class StylesError extends StylesState {
  final String error;

  StylesError(this.error);
}

class StylesLoaded extends StylesState {
  final List<Style> styles;

  StylesLoaded(this.styles);
}

class StylesBloc extends Bloc<DataRepoEvent, StylesState> {
  final DataBloc _dataBloc;

  StylesBloc(this._dataBloc) {
    _dataBloc.listen((data) {
      if (data is DataLoaded) {
        add(DataUpdatedEvent(data));
      }
    });
  }

  @override
  StylesState get initialState => StylesLoading();

  @override
  Stream<StylesState> mapEventToState(DataRepoEvent event) async* {
    if (event is DataUpdatedEvent) {
      yield StylesLoaded(event.dataLoaded.styles);
    }
  }
}
