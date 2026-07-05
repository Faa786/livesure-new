import 'package:flutter/material.dart';
import '../repositories/order_repository.dart';
import '../models/order_model.dart';

class OrderProvider extends ChangeNotifier {
  final OrderRepository _repository = OrderRepository();
  
  List<OrderModel> _orders = [];
  List<OrderModel> _filteredOrders = [];
  bool _isLoading = false;
  String? _error;

  List<OrderModel> get orders => _orders;
  List<OrderModel> get filteredOrders => _filteredOrders;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadOrders() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _orders = await _repository.getOrders();
      _filteredOrders = _orders;
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> createOrder(Map<String, dynamic> data) async {
    try {
      final order = await _repository.createOrder(data);
      _orders.insert(0, order);
      _filteredOrders = _orders;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      rethrow;
    }
  }

  Future<void> updateOrderStatus(String id, String status) async {
    try {
      final order = await _repository.updateOrder(id, {'status': status});
      final index = _orders.indexWhere((o) => o.id == id);
      if (index != -1) {
        _orders[index] = order;
        _filteredOrders = _orders;
        notifyListeners();
      }
    } catch (e) {
      _error = e.toString();
      rethrow;
    }
  }

  void filterOrders(String query) {
    if (query.isEmpty) {
      _filteredOrders = _orders;
    } else {
      _filteredOrders = _orders.where((order) =>
        order.orderNumber.toLowerCase().contains(query.toLowerCase()) ||
        order.customer?.businessName?.toLowerCase().contains(query.toLowerCase()) == true
      ).toList();
    }
    notifyListeners();
  }

  void filterByStatus(String status) {
    if (status == 'all') {
      _filteredOrders = _orders;
    } else {
      _filteredOrders = _orders.where((order) => order.status == status).toList();
    }
    notifyListeners();
  }

  void applyFilters(Map<String, dynamic> filters) {
    notifyListeners();
  }
}
