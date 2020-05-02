import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:urban_dict_slang/core/services/db/database.dart';
import 'package:urban_dict_slang/core/services/repository/term_definitions_repository.dart';
import './bloc.dart';

class TermBloc extends Bloc<TermEvent, TermState> {
  final TermDefinitionsRepository termDefinitionsRepository;

  TermBloc(this.termDefinitionsRepository);
  @override
  TermState get initialState => InitialTermState();

  @override
  Stream<TermState> mapEventToState(
    TermEvent event,
  ) async* {
    if (event is ChangeTerm) {
      yield* _mapChangeTermToState(event);
    } else if (event is DeleteTerm) {
      yield* _mapDeleteTermToState(event);
    } else if (event is ToggleFavorite) {
      yield* _mapToggleFavoriteToState(event);
    }
  }

  Stream<TermState> _mapChangeTermToState(ChangeTerm event) async* {
    yield TermChangeStarted(event.newTerm);
    Term term = await termDefinitionsRepository.getTerm(event.newTerm);
    yield TermChanged(term);
  }

  Stream<TermState> _mapDeleteTermToState(DeleteTerm event) async* {
    await termDefinitionsRepository.deleteTerm(event.term.term);
    yield InitialTermState();
  }

  Stream<TermState> _mapToggleFavoriteToState(ToggleFavorite event) async* {
    Term term = await termDefinitionsRepository.toggleFavorite(event.term);
    yield TermChanged(term);
  }
}
