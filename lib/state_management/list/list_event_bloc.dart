import 'package:bloc_practice/note_model.dart';

abstract class ListEventBloc {}

class AddNote extends ListEventBloc {
  NoteModel newNote;
  AddNote({required this.newNote});
}

class UpdateNote extends ListEventBloc {
  NoteModel updateNote;
  int index;
  UpdateNote({required this.index, required this.updateNote});
}

class DeleteNote extends ListEventBloc {
  int index;
  DeleteNote({required this.index});
}