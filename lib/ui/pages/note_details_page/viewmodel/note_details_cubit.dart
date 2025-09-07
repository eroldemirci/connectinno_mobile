import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectinno_case/core/models/note_model.dart';
import 'package:connectinno_case/core/services/note_services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get_it/get_it.dart';
import 'dart:convert';
import 'package:connectinno_case/core/managers/cache_manager.dart';
import '../../../pages/main_page/pages/home_page/viewmodel/home_cubit.dart';

part 'note_details_state.dart';

class NoteDetailsCubit extends Cubit<NoteDetailsState> {
  final NoteServices _noteServices = GetIt.I<NoteServices>();
  NoteDetailsCubit() : super(NoteDetailsInitial());

  HomeCubit get homeCubit => GetIt.I<HomeCubit>();

  Future<void> saveOrUpdateNote(NoteModel note, {bool isUpdate = false}) async {
    emit(NoteDetailsLoading());
    final cacheManager = CacheManager();
    try {
      final userId = Supabase.instance.client.auth.currentUser?.id;
      if (userId == null) {
        emit(NoteDetailsError('User not found.'));
        return;
      }
      NoteModel? response;
      try {
        // Try to save or update the note via the service (online)
        if (isUpdate) {
          response = await _noteServices.updateNote(note, userId);
        } else {
          response = await _noteServices.createNote(note, userId);
        }
        // If successful, refresh the notes from the service
        await homeCubit.fetchNotes();
      } catch (e) {
        // If there is a network connection error, save the note to cache and update HomeCubit's state so the user sees the note immediately
        if (e.toString().contains('SocketException') ||
            e.toString().contains('Failed host lookup') ||
            e.toString().contains('Network is unreachable')) {
          final cached = await cacheManager.read('notes');
          List<NoteModel> notes = [];
          if (cached != null) {
            notes = (jsonDecode(cached) as List).map((e) => NoteModel.fromJson(e as Map<String, dynamic>)).toList();
          }
          // Always set userId before saving offline
          final noteWithUser = note.userId == userId ? note : note.copyWith(userId: userId);
          if (isUpdate) {
            final idx = notes.indexWhere((n) => n.id == note.id);
            if (idx != -1) {
              notes[idx] = noteWithUser;
            }
          } else {
            notes.insert(0, noteWithUser);
          }
          await cacheManager.save('notes', jsonEncode(notes.map((e) => e.toJson(includeDates: true)).toList()));
          // Update HomeCubit's state so the new note appears in the list immediately
          homeCubit.emit(HomeLoaded(List<NoteModel>.from(notes)));
          emit(NoteDetailsSuccess());
          return;
        } else {
          // For all other errors, show the error message
          emit(NoteDetailsError(e.toString()));
          return;
        }
      }
      // If the response is null, show an error
      if (response == null) {
        emit(NoteDetailsError('Note could not be saved.'));
        return;
      }

      emit(NoteDetailsSuccess());
    } catch (e) {
      emit(NoteDetailsError(e.toString()));
    }
  }
}
