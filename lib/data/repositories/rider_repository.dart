import '../../core/services/supabase_service.dart';
import '../models/rider_model.dart';

class RiderRepository {
  final SupabaseService _supabase = SupabaseService();

  Future<List<RiderModel>> getRiders({Map<String, dynamic>? filters}) async {
    var query = _supabase.client.from('riders').select();
    
    if (filters != null) {
      filters.forEach((key, value) {
        query = query.eq(key, value);
      });
    }
    
    final response = await query.order('created_at', ascending: false);
    return (response as List).map((e) => RiderModel.fromJson(e)).toList();
  }

  Future<RiderModel> getRiderById(String id) async {
    final response = await _supabase.client
        .from('riders')
        .select()
        .eq('id', id)
        .single();
    return RiderModel.fromJson(response);
  }

  Future<RiderModel> createRider(Map<String, dynamic> data) async {
    final response = await _supabase.client
        .from('riders')
        .insert(data)
        .select()
        .single();
    return RiderModel.fromJson(response);
  }

  Future<RiderModel> updateRider(String id, Map<String, dynamic> data) async {
    final response = await _supabase.client
        .from('riders')
        .update(data)
        .eq('id', id)
        .select()
        .single();
    return RiderModel.fromJson(response);
  }

  Future<void> deleteRider(String id) async {
    await _supabase.client.from('riders').delete().eq('id', id);
  }

  Future<void> updateRiderLocation(String riderId, double lat, double lng) async {
    await _supabase.client
        .from('riders')
        .update({
          'current_latitude': lat,
          'current_longitude': lng,
          'last_location_update': DateTime.now().toIso8601String(),
        })
        .eq('id', riderId);
  }

  Future<Map<String, dynamic>> getRiderStats() async {
    final response = await _supabase.client
        .from('riders')
        .select('status, count');
    
    Map<String, int> stats = {};
    for (var item in response) {
      stats[item['status']] = (stats[item['status']] ?? 0) + 1;
    }
    
    return stats;
  }
}
