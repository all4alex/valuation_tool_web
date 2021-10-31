import 'package:equatable/equatable.dart';
import 'package:valuation_tool_web/models/firestore/note_item_model.dart';

abstract class NotesState extends Equatable {}

class NotesInitialState extends NotesState {
  @override
  List<Object> get props => <Object>[];
}

class GetNotesLoadingState extends NotesState {
  @override
  List<Object> get props => <Object>[];
}

class GetNotesSuccessState extends NotesState {
  GetNotesSuccessState({required this.list});
  final List<NoteItemModel> list;
  @override
  List<Object> get props => <Object>[];
}

class GetNotesFailedState extends NotesState {
  GetNotesFailedState({required this.error});
  final String error;
  @override
  List<Object> get props => <Object>[];
}

class AddNotesLoadingState extends NotesState {
  @override
  List<Object> get props => <Object>[];
}

class AddNotesSuccessState extends NotesState {
  @override
  List<Object> get props => <Object>[];
}

class AddNotesFailedState extends NotesState {
  AddNotesFailedState({required this.error});
  final String error;
  @override
  List<Object> get props => <Object>[];
}
