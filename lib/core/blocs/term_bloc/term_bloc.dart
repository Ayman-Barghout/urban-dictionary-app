import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urban_dict_slang/core/blocs/term_bloc/bloc.dart';
import 'package:urban_dict_slang/core/services/db/database.dart';
import 'package:urban_dict_slang/core/services/repository/term_definitions_repository.dart';

class TermBloc extends Bloc<TermEvent, TermState> {
  final TermDefinitionsRepository termDefinitionsRepository;

  TermBloc(this.termDefinitionsRepository) : super(InitialTermState()) {
    on<ChangeTerm>(_mapChangeTermToState);
    on<DeleteTerm>(_mapDeleteTermToState);
    on<ToggleFavorite>(_mapToggleFavoriteToState);
  }

  Future<void> _mapChangeTermToState(
    ChangeTerm event,
    Emitter<TermState> emit,
  ) async {
    emit(TermChangeStarted(event.newTerm.toLowerCase()));
    final Term term = await termDefinitionsRepository.getTerm(event.newTerm);
    emit(TermChanged(term));
  }

  Future<void> _mapDeleteTermToState(
    DeleteTerm event,
    Emitter<TermState> emit,
  ) async {
    await termDefinitionsRepository.deleteTerm(event.term.term);
    emit(InitialTermState());
  }

  Future<void> _mapToggleFavoriteToState(
    ToggleFavorite event,
    Emitter<TermState> emit,
  ) async {
    final term = await termDefinitionsRepository.toggleFavorite(event.term);
    if (term == null) return;
    emit(TermChanged(term));
  }
}
