import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../custom_widget/textfield.dart';
import '../data_base/models.dart';
import '../notes_cubit/notes_cubits.dart';

class AddNotesScreen extends StatefulWidget {
  const AddNotesScreen({super.key});

  @override
  State<AddNotesScreen> createState() => _AddNotesScreenState();
}

class _AddNotesScreenState extends State<AddNotesScreen> {
  var titleController= TextEditingController();
  var descController= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Text("Add Notes"),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CustomTextField(hint: " Enter a name", controller: titleController),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(hint: " Enter desc", controller: descController),
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
                  var title= titleController.text.toString();
                  var desc= descController.text.toString();
                  context.read<NotesCubit>().addNotes(NotesModel(title: title, desc: desc));
                  Navigator.pop(context);
                },
                child: const Text("Save"))
          ],
        ),
      ),
    );
  }
}