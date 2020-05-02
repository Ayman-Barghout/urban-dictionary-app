import 'package:equatable/equatable.dart';
import 'package:urban_dict_slang/core/services/db/database.dart';

abstract class TermState extends Equatable {
  const TermState();
}

class InitialTermState extends TermState {
  @override
  List<Object> get props => [];
}

class TermChangeStarted extends TermState {
  final String term;

  TermChangeStarted(this.term);
  @override
  List<Object> get props => [term];
}

class TermChanged extends TermState {
  final Term term;

  TermChanged(this.term);
  @override
  List<Object> get props => [term];
}
