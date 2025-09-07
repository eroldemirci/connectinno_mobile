import 'dart:convert';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/models/user_model.dart';
import '../../managers/cache_manager.dart';

typedef AuthListener = void Function(UserModel? user);

class AuthManager {
  UserModel? _user;
  UserModel? get user => _user;
  final CacheManager _cacheManager = CacheManager();
  final SupabaseClient _supabase = Supabase.instance.client;
  static final AuthManager instance = AuthManager._internal();
  factory AuthManager() => instance;
  AuthManager._internal();

  final List<AuthListener> _listeners = [];

  void addListener(AuthListener listener) {
    _listeners.add(listener);
  }

  void removeListener(AuthListener listener) {
    _listeners.remove(listener);
  }

  void _notify() {
    for (final listener in _listeners) {
      listener(_user);
    }
  }

  Future<bool> register({required String email, required String password}) async {
    final response = await _supabase.auth.signUp(email: email, password: password);
    if (response.user != null) {
      _user = UserModel(id: response.user!.id, email: response.user!.email ?? '', accessToken: response.session?.accessToken);
      await _cacheManager.save('user', jsonEncode(_user!.toJson()));
      _notify();
      return true;
    }
    return false;
  }

  Future<bool> login({required String email, required String password}) async {
    final response = await _supabase.auth.signInWithPassword(email: email, password: password);
    if (response.user != null) {
      _user = UserModel(id: response.user!.id, email: response.user!.email ?? '', accessToken: response.session?.accessToken);
      await _cacheManager.save('user', jsonEncode(_user!.toJson()));
      _notify();
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    await _supabase.auth.signOut();
    _user = null;
    await _cacheManager.delete('user');
    _notify();
  }

  Future<UserModel?> loadUserFromCache() async {
    final userJson = await _cacheManager.read('user');
    if (userJson != null) {
      _user = UserModel.fromJson(jsonDecode(userJson));
      _notify();
    }
    return _user;
  }
}
