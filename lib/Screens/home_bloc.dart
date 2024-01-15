import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app_bloc/Screens/update_bloc.dart';


import '../Bloc/notes_bloc.dart';
import 'bloc_addnotes.dart';

class HomeBloc extends StatefulWidget {
  const HomeBloc({super.key});

  @override
  State<HomeBloc> createState() => _HomeBlocState();
}

class _HomeBlocState extends State<HomeBloc> {
  @override
  void initState() {
    BlocProvider.of<NotesBloc>(context).add(FetchNoteEvent());
    super.initState();
  }
  List<Color> titleColor = [
    const Color(0xffFBE4D8),
    const Color(0xffDFB6B2),
    const Color(0xff845F6C),
  ];
  getRandomColor() {
    Random random = Random();
    return titleColor[random.nextInt(titleColor.length)];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bloc Notes"),
        centerTitle: true,
      ),
      body: BlocBuilder<NotesBloc, NotesState>(
        builder: (context, state) {
          if(state is NotesLoading){
            return  const Center(child: CircularProgressIndicator());
          }
          else if(state is NotesLoaded){
            return ListView.builder(
                itemCount: state.noteList.length,
                itemBuilder: (context,index){
                  return InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>
                          UpdateBloc(
                            // id: "${state.noteList[index].id.toString()}",
                              id:state.noteList[index].id??-1,
                              title: state.noteList[index].title.toString(),
                              desc: state.noteList[index].desc.toString())));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Card(
                        elevation: 2,
                        color: getRandomColor(),
                        child: ListTile(
                          leading: Text(state.noteList[index].id.toString()),
                          title: Text(state.noteList[index].title.toString()),
                          subtitle: Text(state.noteList[index].desc.toString()),
                          trailing: IconButton(onPressed: () {
                            var id = state.noteList[index].id;
                            BlocProvider.of<NotesBloc>(context).add(DeleteNoteEvent(id: id??-1));
                            BlocProvider.of<NotesBloc>(context).add(FetchNoteEvent());
                          }, icon: const  Icon(Icons.delete),),
                        ),
                      ),
                    ),
                  );
                });
          }
          else {
            return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:(){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> const AddNotesBloc()));
        } ,
        child: Icon(Icons.add),
      ),
    );
  }
}