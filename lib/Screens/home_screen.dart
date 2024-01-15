import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app_bloc/Screens/update_notes_screen.dart';


import '../Bloc/notes_bloc.dart';
import '../notes_cubit/notes_cubits.dart';
import 'add_notes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Color> titleColor = [
    const Color(0xffFBE4D8),
    const Color(0xffDFB6B2),
    const Color(0xff845F6C),
  ];
  getRandomColor() {
    Random random = Random();
    return titleColor[random.nextInt(titleColor.length)];
  }
  deleteNote(int id)async{
    context.read<NotesCubit>().deleteNote(id);
    await context.read<NotesCubit>().getAllData();
  }

  @override
  void initState() {
    super.initState();
    context.read<NotesCubit>().getAllData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes App Cubit ", style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddNotesScreen()));
        },
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<NotesCubit, NotesState>(
        bloc: context.read<NotesCubit>(),
        builder: (context, state) {
          print("current state is ${state}");
          if (state is NotesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NotesLoaded) {
            return ListView.builder(
                itemCount: state.list.length,
                itemBuilder: (_, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateNoteScreen(index: index)));
                    },
                    child:  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      child: Card(
                        elevation: 2,
                        color: getRandomColor(),
                        child: ListTile(
                          leading: Text("${state.list[index].id}"),
                          title: Text("${state.list[index].title}"),
                          subtitle: Text("${state.list[index].desc}"),
                          trailing: InkWell(
                              onTap: (){
                                var id = context.read<NotesCubit>().noteList[index].id;
                                deleteNote(id!);
                                var snackbar = SnackBar(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    duration: const Duration(seconds: 2),
                                    backgroundColor: Colors.black,
                                    behavior: SnackBarBehavior.floating,
                                    content: const Text(
                                      "You delete this item Successfully ",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.white),
                                    ));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackbar);

                              },
                              child: Icon(Icons.delete)),
                        ) ,
                      ),
                    ),
                  );

                });
          } else {
            return Center(child: Text("Data not found"));
          }
        },
      ),
    );
  }
}