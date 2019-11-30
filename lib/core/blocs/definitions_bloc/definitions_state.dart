import 'package:equatable/equatable.dart';
import 'package:urban_dict_slang/core/services/db/database.dart';

abstract class DefinitionsState extends Equatable {
  const DefinitionsState();
}

class InitialDefinitionsState extends DefinitionsState {
  @override
  List<Object> get props => [];
}

class DefinitionsLoading extends DefinitionsState {
  @override
  List<Object> get props => [];
}

class DefinitionsLoaded extends DefinitionsState {
  final List<Definition> definitions;

  DefinitionsLoaded(this.definitions);

  @override
  List<Object> get props => [definitions];
}

class DefinitionsError extends DefinitionsState {
  final String message;

  DefinitionsError(this.message);

  @override
  List<Object> get props => [message];
}
