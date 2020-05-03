import 'package:equatable/equatable.dart';
import 'package:urban_dict_slang/core/services/db/database.dart';

abstract class TermsHistoryState extends Equatable {
  const TermsHistoryState();
}

class InitialTermsHistoryState extends TermsHistoryState {
  @override
  List<Object> get props => [];
}

class TermsHistoryLoading extends TermsHistoryState {
  @override
  List<Object> get props => [];
}

class TermsHistoryLoaded extends TermsHistoryState {
  final Map<int, List<Term>> termsHistory;

  const TermsHistoryLoaded(this.termsHistory);

  @override
  List<Object> get props => [termsHistory];
}

class TermsHistoryEmpty extends TermsHistoryState {
  final String message;

  const TermsHistoryEmpty(this.message);
  @override
  List<Object> get props => [message];
}
