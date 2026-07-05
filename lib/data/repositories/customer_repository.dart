import '../../core/services/supabase_service.dart';
import '../models/customer_model.dart';

class CustomerRepository {
  final SupabaseService _supabase = SupabaseService();

  Future<List<CustomerModel>> getCustomers({Map<String, dynamic>? filters}) async {
    var query = _supabase.client.from('customers').select();
    
    if (filters != null) {
      filters.forEach((key, value) {
        query = query.eq(key, value);
      });
    }
    
    final response = await query.order('created_at', ascending: false);
    return (response as List).map((e) => CustomerModel.fromJson(e)).toList();
  }

  Future<CustomerModel> getCustomerById(String id) async {
    final response = await _supabase.client
        .from('customers')
        .select()
        .eq('id', id)
        .single();
    return CustomerModel.fromJson(response);
  }

  Future<CustomerModel> createCustomer(Map<String, dynamic> data) async {
    final response = await _supabase.client
        .from('customers')
        .insert(data)
        .select()
        .single();
    return CustomerModel.fromJson(response);
  }

  Future<CustomerModel> updateCustomer(String id, Map<String, dynamic> data) async {
    final response = await _supabase.client
        .from('customers')
        .update(data)
        .eq('id', id)
        .select()
        .single();
    return CustomerModel.fromJson(response);
  }

  Future<void> deleteCustomer(String id) async {
    await _supabase.client.from('customers').delete().eq('id', id);
  }

  Future<double> getCustomerBalance(String customerId) async {
    final response = await _supabase.client
        .rpc('get_customer_balance', params: {'p_customer_id': customerId});
    return (response as double?) ?? 0.0;
  }

  Future<Map<String, dynamic>> getCustomerStats() async {
    final response = await _supabase.client
        .from('customers')
        .select('status, count');
    
    Map<String, int> stats = {};
    for (var item in response) {
      stats[item['status']] = (stats[item['status']] ?? 0) + 1;
    }
    
    return stats;
  }
}
