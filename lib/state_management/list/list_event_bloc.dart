import 'package:bloc_practice/note_model.dart';

abstract class ListEventBloc {}

class AddNoteEvent extends ListEventBloc {
  NoteModel newNote;
  AddNoteEvent({required this.newNote});
}

class UpdateNoteEvent extends ListEventBloc {
  NoteModel updateNote;
  int index;
  UpdateNoteEvent({required this.index, required this.updateNote});
}

class DeleteNoteEvent extends ListEventBloc {
  int index;
  DeleteNoteEvent({required this.index});
}