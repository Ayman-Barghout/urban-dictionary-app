import 'package:equatable/equatable.dart';

abstract class DefinitionsEvent extends Equatable {
  const DefinitionsEvent();
}

class FetchDefinitions extends DefinitionsEvent {
  final String term;

  const FetchDefinitions(this.term);

  @override
  List<Object> get props => [term];
}

class ResetDefinitions extends DefinitionsEvent {
  @override
  List<Object> get props => [];
}
