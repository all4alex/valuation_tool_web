import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:valuation_tool_web/models/firestore/note_item_model.dart';
import 'package:valuation_tool_web/services/firestore/firestore_notes_service.dart';

import 'notes_state.dart';

class NotesBloc extends Cubit<NotesState> {
  NotesBloc() : super(NotesInitialState());

  FirestoreNotesService _firestoreFolderService = FirestoreNotesService();

  void getAllNotes({required String vin}) async {
    emit(GetNotesLoadingState());
    try {
      List<NoteItemModel> list =
          await _firestoreFolderService.getNotesPerUserAndVehicle(
              email: 'alex.ayso@valuation.com', vin: vin);
      emit(GetNotesSuccessState(list: list));
    } catch (e) {
      emit(GetNotesFailedState(error: e.toString()));
    }
  }

  void addNotes({required NoteItemModel noteItemModel}) async {
    emit(AddNotesLoadingState());
    try {
      bool success =
          await _firestoreFolderService.addNote(noteItemModel: noteItemModel);
      if (success) {
        this.getAllNotes(vin: noteItemModel.vin!);
      }
    } catch (e) {
      emit(AddNotesFailedState(error: e.toString()));
    }
  }
}
