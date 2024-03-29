import 'package:equatable/equatable.dart';
import 'package:urban_dict_slang/core/services/db/database.dart';

abstract class TermEvent extends Equatable {
  const TermEvent();
}

class DeleteTerm extends TermEvent {
  final Term term;

  const DeleteTerm(this.term);
  @override
  List<Object> get props => [term];
}

class ToggleFavorite extends TermEvent {
  final Term term;

  const ToggleFavorite(this.term);
  @override
  List<Object> get props => [term];
}

class ChangeTerm extends TermEvent {
  final String newTerm;

  const ChangeTerm({required this.newTerm});

  @override
  List<Object> get props => [newTerm];
}
