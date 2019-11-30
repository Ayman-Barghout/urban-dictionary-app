import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:urban_dict_slang/core/services/db/database.dart';

abstract class TermEvent extends Equatable {
  const TermEvent();
}

class DeleteTerm extends TermEvent {
  final Term term;

  DeleteTerm(this.term);
  @override
  List<Object> get props => [term];
}

class ToggleFavorite extends TermEvent {
  final Term term;

  ToggleFavorite(this.term);
  @override
  List<Object> get props => [term];
}

class ChangeTerm extends TermEvent {
  final String newTerm;

  ChangeTerm({@required this.newTerm});

  @override
  List<Object> get props => [newTerm];
}
