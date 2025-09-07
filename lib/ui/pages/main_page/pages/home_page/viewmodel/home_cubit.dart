import 'package:connectinno_case/core/models/note_model.dart';
import 'package:connectinno_case/core/services/note_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import 'package:connectinno_case/core/managers/cache_manager.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final NoteServices _noteServices;
  HomeCubit(this._noteServices) : super(HomeInitial());

  Future<void> fetchNotes() async {
    emit(HomeLoading());
    final cacheManager = CacheManager();
    bool cacheShown = false;
    try {
      // Load notes from cache for instant feedback
      final cached = await cacheManager.read('notes');
      print("Cached notes: $cached");
      List<NoteModel> cachedList = [];
      if (cached != null) {
        cachedList =
            (jsonDecode(cached) as List).map((e) => NoteModel.fromJson(e as Map<String, dynamic>)).where((note) {
              final userId = Supabase.instance.client.auth.currentUser?.id;
              return note.userId == userId;
            }).toList();
        emit(HomeLoaded(cachedList));
        cacheShown = true;
      }

      final userId = Supabase.instance.client.auth.currentUser?.id;
      if (userId == null) {
        emit(HomeError('User not found.'));
        return;
      }

      // Fetch notes from the service (online)
      final notes = await _noteServices.fetchNotes(userId);
      // Only show notes that belong to the current user
      final filteredNotes = notes.where((note) => note.userId == userId).toList();
      filteredNotes.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

      // --- Sync: POST notes created while offline ---
      // For each note in cache that is not in the service, POST it to the service
      final serviceIds = filteredNotes.map((n) => n.id).toSet();
      final List<NoteModel> notesToAdd = [];
      final List<Future<NoteModel?>> postFutures = [];
      for (final cachedNote in cachedList) {
        // Only sync notes that belong to the current user
        if (cachedNote.userId != userId) continue;
        // If the note was created offline, its id will be null. Always POST these.
        if (cachedNote.id == null) {
          postFutures.add(_noteServices.createNote(cachedNote, userId));
        } else if (!serviceIds.contains(cachedNote.id)) {
          // If the note has an id but is not in the service, also POST it
          postFutures.add(_noteServices.createNote(cachedNote, userId));
        }
      }
      // Batch the POSTs for performance and collect created notes
      const int batchSize = 3;
      for (var i = 0; i < postFutures.length; i += batchSize) {
        final batch = postFutures.skip(i).take(batchSize);
        final results = await Future.wait(batch);
        notesToAdd.addAll(results.whereType<NoteModel>());
      }

      // Merge the new notes (from POST) with the service notes
      final allNotes = List<NoteModel>.from(filteredNotes)..addAll(notesToAdd);
      allNotes.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
      await cacheManager.save('notes', jsonEncode(allNotes.map((e) => e.toJson(includeDates: true)).toList()));
      emit(HomeLoaded(allNotes));
    } catch (e) {
      if (!cacheShown) {
        emit(HomeError(e.toString()));
      }
    }
  }

  Future<void> deleteNote(String noteId) async {
    try {
      final userId = Supabase.instance.client.auth.currentUser?.id;
      if (userId == null) return;
      final currentState = state;
      if (currentState is HomeLoaded) {
        emit(HomeLoading());
        final success = await _noteServices.deleteNote(noteId, userId);
        if (success) {
          final updatedNotes = List<NoteModel>.from(currentState.notes)..removeWhere((n) => n.id == noteId);
          final cacheManager = CacheManager();
          await cacheManager.save('notes', jsonEncode(updatedNotes.map((e) => e.toJson(includeDates: true)).toList()));
          emit(HomeLoaded(updatedNotes));
        } else {
          emit(HomeError('Not silinemedi.'));
        }
      }
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
