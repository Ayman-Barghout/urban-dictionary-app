import 'package:equatable/equatable.dart';

abstract class TermsHistoryEvent extends Equatable {
  const TermsHistoryEvent();
}

class LoadTermsHistory extends TermsHistoryEvent {
  @override
  List<Object> get props => [];
}
