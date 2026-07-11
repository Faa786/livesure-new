import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_model.dart';
import '../../core/services/supabase_service.dart';

class AuthRepository {
  final SupabaseService _supabase = SupabaseService();

  Future<UserModel> signUp(String email, String password, String name, String phone) async {
    try {
      final response = await _supabase.signUp(email, password);
      final userData = await _supabase.client
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
      final response = await _supabase.signIn(email, password);
      final userData = await _supabase.client
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
    await _supabase.signOut();
  }

  Future<UserModel?> getCurrentUser() async {
    final user = await _supabase.getCurrentUser();
    if (user == null) return null;
    
    final userData = await _supabase.client
        .from('users')
        .select()
        .eq('id', user.id)
        .single();
    
    return UserModel.fromJson(userData);
  }

  Future<void> resetPassword(String email) async {
    await _supabase.resetPassword(email);
  }

  Future<void> updatePassword(String newPassword) async {
    await _supabase.client.auth.updateUser(
      UserAttributes(password: newPassword),
    );
  }
}
