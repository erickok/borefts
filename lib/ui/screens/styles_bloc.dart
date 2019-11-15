import 'package:bloc/bloc.dart';
import 'package:borefts2020/data/models/styles.dart';
import 'package:borefts2020/data/repository.dart';

import 'events.dart';

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

class StylesBloc extends Bloc<DataScreenEvent, StylesState> {
  final Repository _repository;

  StylesBloc(this._repository);

  @override
  StylesState get initialState => StylesLoading();

  @override
  Stream<StylesState> mapEventToState(DataScreenEvent event) async* {
    List<Style> styles = await _repository.styles();
    yield StylesLoaded(styles);
  }
}
