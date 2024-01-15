part of 'notes_bloc.dart';

@immutable
abstract class NotesState {}

class NotesInitial extends NotesState {}
class NotesLoading extends NotesState {}
class NotesLoaded extends NotesState {
  final List<NotesModel> noteList;
  NotesLoaded({required this.noteList});
}