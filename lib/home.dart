import 'package:bloc_practice/state_management/counter_bloc.dart';
import 'package:bloc_practice/state_management/counter_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Your count is ${context.watch<CounterBloc>().state}'),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        context.read<CounterBloc>().add(IncrementEvent());
      }, child: Icon(Icons.add),),
    );
  }
}