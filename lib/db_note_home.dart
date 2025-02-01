import 'package:bloc_practice/Database/data_model.dart';
import 'package:bloc_practice/add_note.dart';
import 'package:bloc_practice/state_management/db/db_bloc.dart';
import 'package:bloc_practice/state_management/db/db_event_bloc.dart';
import 'package:bloc_practice/state_management/db/db_sate_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DbNoteHome extends StatefulWidget {
  const DbNoteHome({super.key});

  @override
  State<DbNoteHome> createState() => _DbNoteHomeState();
}

class _DbNoteHomeState extends State<DbNoteHome> {

  @override
  void initState() {
    super.initState();
    context.read<DbBloc>().add(FetchInitialData());
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController descController  = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: BlocBuilder<DbBloc, DbSateBloc>(builder: (ctx, state) {
        var allData = state.dataModel;
        return allData.isNotEmpty
            ? ListView.builder(
                itemCount: allData.length,
                itemBuilder: (_, index) {
                  return ListTile(
                    title: Text(
                      allData[index].title,
                      style: TextStyle(fontSize: 25, color: Colors.black),
                    ),
                    subtitle: Text(
                      allData[index].description,
                      style: TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              titleController.text = allData[index].title;
                              descController.text = allData[index].description;
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
                                                BlocProvider.of<DbBloc>(context).add(UpdateNoteEvent(updateNote: DataModel(id: allData[index].id, title: titleController.text, description: descController.text)));
                                                
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
                              // BlocProvider.of<DbBloc>(ctx, listen: false).add(DeleteNoteEvent(index: index));
                              // context.read<ListBloc>().ad

                              // Delete note through db cubit
                              BlocProvider.of<DbBloc>(ctx).add(DeleteNoteEvent(id: allData[index].id));
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