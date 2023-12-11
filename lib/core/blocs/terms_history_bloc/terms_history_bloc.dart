import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urban_dict_slang/core/blocs/terms_history_bloc/bloc.dart';
import 'package:urban_dict_slang/core/services/db/database.dart';
import 'package:urban_dict_slang/core/services/repository/terms_repository.dart';

class TermsHistoryBloc extends Bloc<TermsHistoryEvent, TermsHistoryState> {
  final TermsRepository termsRepository;

  TermsHistoryBloc(this.termsRepository) : super(InitialTermsHistoryState()) {
    on<LoadTermsHistory>(mapEventToState);
  }

  Future<void> mapEventToState(
    TermsHistoryEvent event,
    Emitter<TermsHistoryState> emit,
  ) async {
    emit(TermsHistoryLoading());
    final List<Term> terms = await termsRepository.getAllTerms();
    if (terms.isEmpty) {
      emit(
        const TermsHistoryEmpty(
          "You haven't searched for slangs yet, your search history will appear here",
        ),
      );
    } else {
      final termsHistory = termsRepository.getTermsHistory(terms);
      emit(TermsHistoryLoaded(termsHistory));
    }
  }
}
