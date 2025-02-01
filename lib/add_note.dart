import 'package:bloc_practice/Database/data_model.dart';
import 'package:bloc_practice/custom_button.dart';
import 'package:bloc_practice/custom_textfield.dart';
import 'package:bloc_practice/state_management/db/db_bloc.dart';
import 'package:bloc_practice/state_management/db/db_event_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNote extends StatelessWidget {
  const AddNote({super.key});

  @override
  Widget build(BuildContext context) {

    TextEditingController tController = TextEditingController();
    TextEditingController dController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Note'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10,),
            CustomTextfield(
              controller: tController,
              hint: 'Enter note title',
              labelText: 'Title',
              inputType: TextInputType.text,
            ),
            const SizedBox(
              height: 16,
            ),
            CustomTextfield(
              controller: dController,
              hint: 'Enter note details',
              labelText: 'Description',
              inputType: TextInputType.text,
            ),
            const SizedBox(
              height: 40,
            ),
            CustomButton(
              onClick: () {
                // add note throgh list Cubit
                // BlocProvider.of<ListBloc>(context).add(AddNoteEvent(newNote: NoteModel(title: tController.text, description: dController.text)));

                // Add note through db cubit
                BlocProvider.of<DbBloc>(context).add(AddNoteEvent(newNote: DataModel(title: tController.text, description: dController.text)));
                // context.read<DbBloc>().add(AddNoteEvent(newNote: DataModel(title: tController.text, description: dController.text)));
                Navigator.pop(context);
              },
              title: 'Add',
            ),
          ],
        ),
      ),
    );
  }
}