import 'package:bloc_practice/note_model.dart';
import 'package:bloc_practice/state_management/list/list_event_bloc.dart';
import 'package:bloc_practice/state_management/list/list_state_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListBloc extends Bloc<ListEventBloc, ListStateBloc>{
  ListBloc() : super(ListStateBloc(mNote: [])){
    on<AddNoteEvent>((event , emit){
      List<NoteModel> currentStateValue = state.mNote;

      currentStateValue.add(event.newNote);
      emit(ListStateBloc(mNote: currentStateValue));
    });

    on<UpdateNoteEvent>((event , emit){
      List<NoteModel> currentStateValue = state.mNote;

      currentStateValue[event.index] = event.updateNote;
      emit(ListStateBloc(mNote: currentStateValue));
    });

    on<DeleteNoteEvent>((event , emit){
      List<NoteModel> currentStateValue = state.mNote;

      currentStateValue.removeAt(event.index);
      emit(ListStateBloc(mNote: currentStateValue));
    });
  }
}