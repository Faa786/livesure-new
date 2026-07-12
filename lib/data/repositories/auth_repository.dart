import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_model.dart';

class AuthRepository {
  final SupabaseClient _client = Supabase.instance.client;

  Future<UserModel> signUp(String email, String password, String name, String phone) async {
    try {
      final response = await _client.auth.signUp(
        email: email,
        password: password,
      );
      
      if (response.user == null) {
        throw Exception('Signup failed');
      }

      final userData = await _client
          .from('users')
          .insert({
            'id': response.user!.id,
            'email': email,
            'full_name': name,
            'phone': phone,
            'role': 'rider',
          }).select().single();

      return UserModel.fromJson({
        ...userData,
        'access_token': response.session?.accessToken,
        'refresh_token': response.session?.refreshToken,
      });
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  Future<UserModel> signIn(String email, String password) async {
    try {
      final response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      final userData = await _client
          .from('users')
          .select()
          .eq('id', response.user!.id)
          .single();

      return UserModel.fromJson({
        ...userData,
        'access_token': response.session?.accessToken,
        'refresh_token': response.session?.refreshToken,
      });
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  Future<UserModel?> getCurrentUser() async {
    final user = _client.auth.currentUser;
    if (user == null) return null;

    final userData = await _client
        .from('users')
        .select()
        .eq('id', user.id)
        .single();

    return UserModel.fromJson(userData);
  }

  Future<void> resetPassword(String email) async {
    await _client.auth.resetPasswordForEmail(email);
  }

  Future<void> updatePassword(String newPassword) async {
    await _client.auth.updateUser(
      UserAttributes(password: newPassword),
    );
  }
}
