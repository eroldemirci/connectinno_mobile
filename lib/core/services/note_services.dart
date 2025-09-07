 import 'package:connectinno_case/core/enums/endpoint_enums.dart';
import 'package:connectinno_case/core/managers/network_manager.dart';
import 'package:connectinno_case/core/models/note_model.dart';
 
  


class NoteServices {
  final NetworkManager _networkManager = NetworkManager();

  Future<List<NoteModel>> fetchNotes(String userId) async {
    try {
      final response = await _networkManager.get(EndPoints.notes.getString(), queryParameters: {'user_id': userId});
      if (response.data != null) {
        final data = response.data as List<dynamic>;
        return data.map((e) => NoteModel.fromJson(e as Map<String, dynamic>)).toList();
      } else {
        return [];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<NoteModel?> createNote(NoteModel note, String userId) async {
    try {
      final response = await _networkManager.post(EndPoints.notes.getString(), data: note.toJson(), queryParameters: {'user_id': userId});
      if (response.data != null) {
        return NoteModel.fromJson(response.data as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<NoteModel?> updateNote(NoteModel note, String userId) async {
    try {
      final response = await _networkManager.put(
        EndPoints.notes.getString(additionalData: note.id.toString()),
        data: note.toJson(),
        queryParameters: {'user_id': userId},
      );
      if (response.data != null) {
        return NoteModel.fromJson(response.data as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> deleteNote(String id, String userId) async {
    try {
      final response = await _networkManager.delete(
        EndPoints.notes.getString(additionalData: id),
        queryParameters: {'user_id': userId},
      );
      return response.statusCode == 200;
    } catch (e) {
      rethrow;
    }
  }
}
