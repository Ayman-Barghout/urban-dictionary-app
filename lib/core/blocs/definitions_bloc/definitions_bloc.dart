import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:urban_dict_slang/core/services/db/database.dart';
import 'package:urban_dict_slang/core/services/repository/term_definitions_repository.dart';
import './bloc.dart';

class DefinitionsBloc extends Bloc<DefinitionsEvent, DefinitionsState> {
  TermDefinitionsRepository termDefinitionsRepository;

  DefinitionsBloc(this.termDefinitionsRepository);

  @override
  DefinitionsState get initialState => InitialDefinitionsState();

  @override
  Stream<DefinitionsState> mapEventToState(
    DefinitionsEvent event,
  ) async* {
    if (event is FetchDefinitions) {
      if (event.term != '') {
        yield DefinitionsLoading();
        List<Definition> definitions =
            await termDefinitionsRepository.fetchDefinitions(event.term);
        if (definitions == null) {
          yield DefinitionsError(
              'No internet connection, please connect to internet to view definitions');
        } else if (definitions.length == 0) {
          yield DefinitionsError(
              'No definitions found for this slang, try another word');
        } else {
          yield DefinitionsLoaded(definitions);
        }
      } else {
        yield DefinitionsError(
            "Please enter a word to search for its definitions");
      }
    } else if (event is ResetDefinitions) {
      yield InitialDefinitionsState();
    }
  }
}
