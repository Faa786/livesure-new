import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();
  factory SupabaseService() => _instance;
  SupabaseService._internal();

  late SupabaseClient _client;
  
  Future<void> init() async {
    await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL']!,
      anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
    );
    _client = Supabase.instance.client;
  }

  SupabaseClient get client => _client;
  
  Future<AuthResponse> signIn(String email, String password) async {
    return await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  Future<User?> getCurrentUser() async {
    return _client.auth.currentUser;
  }

  Future<void> resetPassword(String email) async {
    await _client.auth.resetPasswordForEmail(email);
  }

  Future<List<Map<String, dynamic>>> query(
    String table, {
    Map<String, dynamic>? filters,
    List<String>? orderBy,
    int? limit,
  }) async {
    var query = _client.from(table).select();
    
    if (filters != null) {
      filters.forEach((key, value) {
        query = query.eq(key, value);
      });
    }
    
    if (orderBy != null && orderBy.length == 2) {
      query = query.order(orderBy[0], ascending: orderBy[1] == 'asc');
    }
    
    if (limit != null) {
      query = query.limit(limit);
    }
    
    return await query;
  }

  Future<Map<String, dynamic>?> findById(String table, String id) async {
    final response = await _client.from(table).select().eq('id', id).maybeSingle();
    return response;
  }

  Future<Map<String, dynamic>> insert(String table, Map<String, dynamic> data) async {
    final response = await _client.from(table).insert(data).select().single();
    return response;
  }

  Future<Map<String, dynamic>> update(
    String table,
    String id,
    Map<String, dynamic> data,
  ) async {
    final response = await _client
        .from(table)
        .update(data)
        .eq('id', id)
        .select()
        .single();
    return response;
  }

  Future<void> delete(String table, String id) async {
    await _client.from(table).delete().eq('id', id);
  }

  Future<dynamic> callRpc(String function, Map<String, dynamic> params) async {
    return await _client.rpc(function, params: params);
  }
}
