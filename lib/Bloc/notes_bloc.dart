

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';


import '../data_base/db_helper.dart';
import '../data_base/models.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {

  DbHelper dbHelper;
  NotesBloc({required this.dbHelper}) : super(NotesInitial()) {
    List<NotesModel> notesModel=[];

    on<NotesEvent>((event, emit) async {
      if(event is AddNoteEvent){
        emit(NotesLoading());
        var data = await dbHelper.insertData(event.notesModel);
        if(data){
          var notes = await dbHelper.getData();
          emit(NotesLoaded(noteList: notes));
        }
      }
    });
    on<UpdateNoteEvent>((event, emit)async{
      var data= await dbHelper.updateNotes(event.notesModel);
      if(data==1){
        notesModel = await dbHelper.getData();
        emit(NotesLoaded(noteList: notesModel));
      }
    });
    on<FetchNoteEvent>((event, emit)async{
      notesModel= await dbHelper.getData();
      emit(NotesLoaded(noteList: notesModel));
    });


    on<DeleteNoteEvent>((event, emit,) async{
      var data = await dbHelper.deleteNotes(event.id);
      if(data){
        notesModel = await dbHelper.getData();
        emit(NotesLoaded(noteList: notesModel));
      }
    });

  }
}