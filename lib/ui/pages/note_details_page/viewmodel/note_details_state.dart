part of 'note_details_cubit.dart';

abstract class NoteDetailsState {}

class NoteDetailsInitial extends NoteDetailsState {}

class NoteDetailsLoading extends NoteDetailsState {}

class NoteDetailsSuccess extends NoteDetailsState {}

class NoteDetailsError extends NoteDetailsState {
  final String message;
  NoteDetailsError(this.message);
}
