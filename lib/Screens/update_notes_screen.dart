import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Bloc/notes_bloc.dart';
import '../custom_widget/textfield.dart';
import '../data_base/models.dart';

import '../notes_cubit/notes_cubits.dart';

class UpdateNoteScreen extends StatefulWidget {
  final int index;

  const UpdateNoteScreen({super.key, required this.index});

  @override
  State<UpdateNoteScreen> createState() => _UpdateNoteScreenState();
}

class _UpdateNoteScreenState extends State<UpdateNoteScreen> {
  var titleController = TextEditingController();
  var descController = TextEditingController();

  void update(int id) {
    context.read<NotesCubit>().update(
        NotesModel(title: titleController.text, desc: descController.text, id: id));
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    var item= context.read<NotesCubit>().noteList[widget.index];
    titleController.text=item.title;
    descController.text=item.desc;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesCubit, NotesState>(
      builder: (context, state) {
        if(state is NotesLoading){Center(child: CircularProgressIndicator(),);}
        else if(state is NotesLoaded){
          return  Scaffold(
            appBar: AppBar(
              title: const Text("Update Notes"),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  CustomTextField(
                      hint: "Enter a name", controller: titleController),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(hint: "Enter desc", controller: descController),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          maximumSize: const Size(300, 50),
                          minimumSize: const Size(300, 50),
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          )),
                      onPressed: () {
                        var id = state.list[widget.index].id??-1;
                        update(id);
                      },
                      child: const Text("Update"))
                ],
              ),
            ),
          );
        }
        return Container();

      },
    );
  }
}