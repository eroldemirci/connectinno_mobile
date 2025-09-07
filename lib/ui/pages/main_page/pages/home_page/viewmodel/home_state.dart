part of 'home_cubit.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<NoteModel> notes;
  HomeLoaded(this.notes);
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}
