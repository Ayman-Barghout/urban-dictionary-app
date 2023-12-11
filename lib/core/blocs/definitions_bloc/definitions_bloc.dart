import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urban_dict_slang/core/blocs/definitions_bloc/bloc.dart';
import 'package:urban_dict_slang/core/services/repository/term_definitions_repository.dart';

class DefinitionsBloc extends Bloc<DefinitionsEvent, DefinitionsState> {
  TermDefinitionsRepository termDefinitionsRepository;

  DefinitionsBloc(this.termDefinitionsRepository)
      : super(InitialDefinitionsState()) {
    on<FetchDefinitions>(_handleFetchDefinitionsEvent);
    on<ResetDefinitions>((event, emit) => emit(InitialDefinitionsState()));
  }

  Future<void> _handleFetchDefinitionsEvent(
    FetchDefinitions event,
    Emitter<DefinitionsState> emit,
  ) async {
    if (event.term != '') {
      emit(DefinitionsLoading());
      final definitions =
          await termDefinitionsRepository.fetchDefinitions(event.term);
      if (definitions == null) {
        emit(
          const DefinitionsError(
            'No internet connection, please connect to internet to view definitions',
          ),
        );
      } else if (definitions.isEmpty) {
        emit(
          const DefinitionsError(
            'No definitions found for this slang, try another word',
          ),
        );
      } else {
        emit(DefinitionsLoaded(definitions));
      }
    } else {
      emit(
        const DefinitionsError(
          "Please enter a word to search for its definitions",
        ),
      );
    }
  }
}
