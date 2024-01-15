import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../Bloc/notes_bloc.dart';
import '../custom_widget/textfield.dart';
import '../data_base/models.dart';

class UpdateBloc extends StatefulWidget {
  final String title;
  final String desc;
  final int id;

  const UpdateBloc({super.key, required this.title, required this.desc, required this.id,});

  @override
  State<UpdateBloc> createState() => _UpdateBlocState();
}

class _UpdateBlocState extends State<UpdateBloc> {
  var titleController = TextEditingController();
  var descController = TextEditingController();
  @override
  void initState() {
    BlocProvider.of<NotesBloc>(context).add(FetchNoteEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    titleController.text= widget.title;
    descController.text=widget.desc;


    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Notes"),),
      body: BlocBuilder<NotesBloc, NotesState>(
        builder: (context, state) {
          if(state is NotesLoading){
            return  const Center(child: CircularProgressIndicator());
          }
          else if(state is NotesLoaded){
            return Column(
              children: [
                CustomTextField(hint:"Enter a name", controller: titleController),
                const SizedBox(height: 10,),
                CustomTextField(hint:"Enter desc", controller: descController),
                const SizedBox(height: 30,),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        maximumSize: const Size(300, 50),
                        minimumSize: const Size(300, 50),
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),)),
                    onPressed: () {
                      var title= titleController.text.toString();
                      var desc= descController.text.toString();
                      BlocProvider.of<NotesBloc>(context).add(UpdateNoteEvent(
                          notesModel: NotesModel(title: title, desc: desc,
                              id: widget.id)));
                      Navigator.pop(context);
                    },
                    child: const Text("Save"))
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}