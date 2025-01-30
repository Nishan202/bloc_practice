import 'package:bloc_practice/home.dart';
import 'package:bloc_practice/note_home.dart';
import 'package:bloc_practice/state_management/counter_bloc.dart';
import 'package:bloc_practice/state_management/list/list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  // runApp(const MyApp());
  runApp(BlocProvider(create: (context) => ListBloc(), child: MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const NoteHome(),
    );
  }
}