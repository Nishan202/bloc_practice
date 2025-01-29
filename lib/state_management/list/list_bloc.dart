import 'package:bloc_practice/state_management/list/list_event_bloc.dart';
import 'package:bloc_practice/state_management/list/list_state_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListBloc extends Bloc<ListEventBloc, ListStateBloc>{
  ListBloc() : super(ListStateBloc(mNote: [])){
    
  }
}