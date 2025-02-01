import 'package:bloc_practice/Database/data_model.dart';

abstract class DbEventBloc {}

class FetchInitialData extends DbEventBloc{}

class AddNoteEvent extends DbEventBloc {
  DataModel newNote;
  AddNoteEvent({required this.newNote});
}

class UpdateNoteEvent extends DbEventBloc {
  DataModel updateNote;
  UpdateNoteEvent({required this.updateNote});
}

class DeleteNoteEvent extends DbEventBloc {
  int id;
  DeleteNoteEvent({required this.id});
}