import '../../core/services/supabase_service.dart';
import '../models/order_model.dart';
import '../models/customer_model.dart';
import '../models/rider_model.dart';

class OrderRepository {
  final SupabaseService _supabase = SupabaseService();

  Future<List<OrderModel>> getOrders({Map<String, dynamic>? filters}) async {
    var query = _supabase.client
        .from('orders')
        .select('*, customer:customers(*), rider:riders(*), items:order_items(*)');
    
    if (filters != null) {
      filters.forEach((key, value) {
        query = query.eq(key, value);
      });
    }
    
    final response = await query.order('created_at', ascending: false);
    return (response as List).map((e) => OrderModel.fromJson(e)).toList();
  }

  Future<OrderModel> getOrderById(String id) async {
    final response = await _supabase.client
        .from('orders')
        .select('*, customer:customers(*), rider:riders(*), items:order_items(*)')
        .eq('id', id)
        .single();
    return OrderModel.fromJson(response);
  }

  Future<OrderModel> createOrder(Map<String, dynamic> data) async {
    final response = await _supabase.client
        .from('orders')
        .insert(data)
        .select()
        .single();
    return OrderModel.fromJson(response);
  }

  Future<OrderModel> updateOrder(String id, Map<String, dynamic> data) async {
    final response = await _supabase.client
        .from('orders')
        .update(data)
        .eq('id', id)
        .select()
        .single();
    return OrderModel.fromJson(response);
  }

  Future<void> deleteOrder(String id) async {
    await _supabase.client.from('orders').delete().eq('id', id);
  }

  Future<List<OrderModel>> getOrdersByCustomer(String customerId) async {
    final response = await _supabase.client
        .from('orders')
        .select('*, items:order_items(*)')
        .eq('customer_id', customerId)
        .order('created_at', ascending: false);
    return (response as List).map((e) => OrderModel.fromJson(e)).toList();
  }

  Future<List<OrderModel>> getOrdersByRider(String riderId) async {
    final response = await _supabase.client
        .from('orders')
        .select('*, customer:customers(*)')
        .eq('rider_id', riderId)
        .eq('status', 'dispatched')
        .order('delivery_date', ascending: true);
    return (response as List).map((e) => OrderModel.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>> getOrderStats() async {
    final response = await _supabase.client
        .from('orders')
        .select('status, count');
    
    Map<String, int> stats = {};
    for (var item in response) {
      stats[item['status']] = (stats[item['status']] ?? 0) + 1;
    }
    
    return stats;
  }
}
