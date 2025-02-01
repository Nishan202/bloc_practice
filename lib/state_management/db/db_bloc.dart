import 'package:bloc_practice/Database/data_model.dart';
import 'package:bloc_practice/Database/db_helper.dart';
import 'package:bloc_practice/state_management/db/db_event_bloc.dart';
import 'package:bloc_practice/state_management/db/db_sate_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DbBloc extends Bloc<DbEventBloc, DbSateBloc>{
  DBHelper dbHelper;

  DbBloc({required this.dbHelper}) : super(DbSateBloc(dataModel: [])){

    on<FetchInitialData>((event, emit) async {
      List<DataModel> currentStateValue = state.dataModel;
      currentStateValue = await dbHelper.fetchAllData();
      emit(DbSateBloc(dataModel: currentStateValue));
    });

    on<AddNoteEvent>((event, emit) async {
      bool check = await dbHelper.addNote(newNote: event.newNote);
      if(check){
        List<DataModel> currentStateValue = await dbHelper.fetchAllData();
        emit(DbSateBloc(dataModel: currentStateValue));
      }
    });

    on<UpdateNoteEvent>((event, emit) async {
      bool check = await dbHelper.updateNote(updateNote: event.updateNote);
      if(check){
        List<DataModel> currentStateValue = await dbHelper.fetchAllData();
        emit(DbSateBloc(dataModel: currentStateValue));
      }
    });

    on<DeleteNoteEvent>((event, emit) async {
      bool check = await dbHelper.deleteNote(id: event.id);
      if(check){
        List<DataModel> currentStateValue = await dbHelper.fetchAllData();
        emit(DbSateBloc(dataModel: currentStateValue));
      }
    });
  }
}