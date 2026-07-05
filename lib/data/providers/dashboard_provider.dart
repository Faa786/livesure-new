import 'package:flutter/material.dart';
import '../repositories/order_repository.dart';
import '../repositories/customer_repository.dart';
import '../repositories/rider_repository.dart';

class DashboardProvider extends ChangeNotifier {
  final OrderRepository _orderRepository = OrderRepository();
  final CustomerRepository _customerRepository = CustomerRepository();
  final RiderRepository _riderRepository = RiderRepository();
  
  bool _isLoading = false;
  String? _error;
  Map<String, dynamic> _stats = {};
  List<Map<String, dynamic>> _recentActivities = [];
  String _chartPeriod = 'week';
  List<Map<String, double>> _revenueData = [];

  bool get isLoading => _isLoading;
  String? get error => _error;
  Map<String, dynamic> get stats => _stats;
  List<Map<String, dynamic>> get recentActivities => _recentActivities;
  String get chartPeriod => _chartPeriod;
  List<Map<String, double>> get revenueData => _revenueData;

  Future<void> loadOwnerDashboard() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final orderStats = await _orderRepository.getOrderStats();
      final customerStats = await _customerRepository.getCustomerStats();
      final riderStats = await _riderRepository.getRiderStats();
      
      _stats = {
        'totalOrders': orderStats.values.fold(0, (sum, count) => sum + count),
        'pendingDeliveries': orderStats['pending'] ?? 0,
        'activeCustomers': customerStats['active'] ?? 0,
        'todayRevenue': 27500.0, // Placeholder
        'activeRiders': riderStats['active'] ?? 0,
      };
      
      // Generate sample revenue data
      _generateRevenueData();
      
      // Generate sample activities
      _generateRecentActivities();
      
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  void _generateRevenueData() {
    _revenueData = [];
    final now = DateTime.now();
    for (int i = 6; i >= 0; i--) {
      final date = now.subtract(Duration(days: i));
      _revenueData.add({
        'x': date.millisecondsSinceEpoch.toDouble(),
        'y': (1000 + (i * 500) + (i * i * 100)).toDouble(),
      });
    }
  }

  void _generateRecentActivities() {
    _recentActivities = [
      {'title': 'New order #ORD-2024-001', 'time': '2 min ago', 'type': 'order'},
      {'title': 'Payment received from Rajesh', 'time': '15 min ago', 'type': 'payment'},
      {'title': 'Rider Raj joined', 'time': '1 hour ago', 'type': 'rider'},
      {'title': 'Delivery completed #ORD-2024-002', 'time': '2 hours ago', 'type': 'delivery'},
    ];
  }

  void changeChartPeriod(String period) {
    _chartPeriod = period;
    _generateRevenueData();
    notifyListeners();
  }
}
