part of 'notes_bloc.dart';

@immutable
abstract class NotesEvent {}

class AddNoteEvent extends NotesEvent {
  final NotesModel notesModel;

  AddNoteEvent({required this.notesModel});
}

class FetchNoteEvent extends NotesEvent {}

class DeleteNoteEvent extends NotesEvent {
  final  int id;

  DeleteNoteEvent({required this.id});
}

class UpdateNoteEvent extends NotesEvent {
  final NotesModel notesModel;

  UpdateNoteEvent({required this.notesModel});
}