import 'package:bloc_practice/add_note.dart';
import 'package:bloc_practice/note_model.dart';
import 'package:bloc_practice/state_management/list/list_bloc.dart';
import 'package:bloc_practice/state_management/list/list_event_bloc.dart';
import 'package:bloc_practice/state_management/list/list_state_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoteHome extends StatelessWidget {
  const NoteHome({super.key});

  @override
  Widget build(BuildContext context) {
    // allData = context.read<ListBloc>().state.mNote; // if we use that then whole context will rebuild, instead of that we use BlocBuilder

    TextEditingController titleController = TextEditingController();
    TextEditingController descController  = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: BlocBuilder<ListBloc, ListStateBloc>(builder: (ctx, state) {
        return state.mNote.isNotEmpty
            ? ListView.builder(
                itemCount: state.mNote.length,
                itemBuilder: (_, index) {
                  return ListTile(
                    title: Text(
                      state.mNote[index].title,
                      style: TextStyle(fontSize: 25, color: Colors.black),
                    ),
                    subtitle: Text(
                      state.mNote[index].description,
                      style: TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              titleController.text = state.mNote[index].title;
                              descController.text = state.mNote[index].description;
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => UpdateNoteScreen(
                              //             dataModel: DataModel(
                              //                 title: titleController.text,
                              //                 description: desController.text,
                              //                 id: mData[index].id),
                              //           )),
                              // );

                              showModalBottomSheet(
                                context: context,
                                builder: (_) {
                                  return Container(
                                    padding: const EdgeInsets.all(11),
                                    width: double.infinity,
                                    child: Column(
                                      children: [
                                        const Text(
                                          'Add Note',
                                          style: TextStyle(fontSize: 25),
                                        ),
                                        const SizedBox(
                                          height: 11,
                                        ),
                                        TextField(
                                          controller: titleController,
                                          decoration: InputDecoration(
                                            hintText: "Enter title here..",
                                            label: const Text('Title'),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(11),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(11),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 11,
                                        ),
                                        TextField(
                                          controller: descController,
                                          minLines: 4,
                                          maxLines: 6,
                                          decoration: InputDecoration(
                                            hintText: "Enter desc here..",
                                            label: const Text('Desc'),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(11),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(11),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 11,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            OutlinedButton(
                                              onPressed: () {
                                                // using list cubit
                                                BlocProvider.of<ListBloc>(ctx).add(UpdateNoteEvent(index: index, updateNote: NoteModel(title: titleController.text, description: descController.text)));

                                                // using db cubit
                                                // BlocProvider.of<DbCubit>(ctx,
                                                //         listen: false)
                                                //     .updateData(
                                                //         uData: DataModel(
                                                //             title:
                                                //                 titleController
                                                //                     .text,
                                                //             description:
                                                //                 desController
                                                //                     .text,
                                                //             id: allData[index]
                                                //                 .id));
                                                Navigator.pop(context);
                                              },
                                              child: const Text('Save'),
                                            ),
                                            OutlinedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text('Cancel'),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            icon: const Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              // Delete note through list Bloc
                              BlocProvider.of<ListBloc>(ctx, listen: false).add(DeleteNoteEvent(index: index));
                              // context.read<ListBloc>().ad

                              // Delete note through db cubit
                              // BlocProvider.of<DbCubit>(ctx, listen: false)
                              //     .deleteData(noteId: allData[index].id);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                })
            : Center(
                child: Text('No notes yet!!, please add note'),
              );
      }),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddNote()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
