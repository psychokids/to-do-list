import 'package:flutter/material.dart';
import 'package:to_do_list/bloc/note_bloc.dart';
import 'package:to_do_list/bloc/note_state.dart';
import 'package:to_do_list/widgets/alert_dialog_refactor.dart';
import 'package:to_do_list/widgets/note_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'edit_note.dart';

class NotesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return EditNoteScreen(
                newNote: true,
              );
            }));
          },
          child: Icon(Icons.add),
        ),
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.black,
          title: Text(
            'To Do List w/ Hive',
            style: TextStyle(
              color: Colors.white,
              letterSpacing: 1,
            ),
          ),
          toolbarHeight: 65, // default is 56
          actions: [
            IconButton(
                onPressed: () async {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return EditNoteScreen(
                      newNote: true,
                    );
                  }));
                },
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                )),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // define all state and rebuild ui
              BlocBuilder<NoteBloc, NoteState>(
                builder: (context, state) {
                  if (state is NoteInitial) {
                    return Container();
                  }
                  if (state is YourNotesState) {
                    return NoteGrid(state: state);
                  }
                  if (state is NotesLoading) {
                    return Container();
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NoteGrid extends StatelessWidget {
  final YourNotesState state;
  NoteGrid({this.state});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemCount: state.notes.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.90,
          ),
          itemBuilder: (context, index) {
            final note = state.notes[index];
            return InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return EditNoteScreen(
                    note: note,
                    index: index,
                    newNote: false,
                  );
                }));
              },
              onLongPress: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        AlertDialogRefactor(index: index));
              },
              child: NoteCard(
                title: note.title,
                content: note.content,
              ),
            );
          }),
    );
  }
}
