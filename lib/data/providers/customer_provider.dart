import 'package:flutter/material.dart';
import '../repositories/customer_repository.dart';
import '../models/customer_model.dart';

class CustomerProvider extends ChangeNotifier {
  final CustomerRepository _repository = CustomerRepository();
  
  List<CustomerModel> _customers = [];
  List<CustomerModel> _filteredCustomers = [];
  bool _isLoading = false;
  String? _error;

  List<CustomerModel> get customers => _customers;
  List<CustomerModel> get filteredCustomers => _filteredCustomers;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadCustomers() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _customers = await _repository.getCustomers();
      _filteredCustomers = _customers;
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> createCustomer(Map<String, dynamic> data) async {
    try {
      final customer = await _repository.createCustomer(data);
      _customers.insert(0, customer);
      _filteredCustomers = _customers;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      rethrow;
    }
  }

  Future<void> updateCustomer(String id, Map<String, dynamic> data) async {
    try {
      final customer = await _repository.updateCustomer(id, data);
      final index = _customers.indexWhere((c) => c.id == id);
      if (index != -1) {
        _customers[index] = customer;
        _filteredCustomers = _customers;
        notifyListeners();
      }
    } catch (e) {
      _error = e.toString();
      rethrow;
    }
  }

  Future<void> deleteCustomer(String id) async {
    try {
      await _repository.deleteCustomer(id);
      _customers.removeWhere((c) => c.id == id);
      _filteredCustomers = _customers;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      rethrow;
    }
  }

  void searchCustomers(String query) {
    if (query.isEmpty) {
      _filteredCustomers = _customers;
    } else {
      _filteredCustomers = _customers.where((customer) =>
        customer.businessName?.toLowerCase().contains(query.toLowerCase()) == true ||
        customer.contactPerson?.toLowerCase().contains(query.toLowerCase()) == true ||
        customer.phone.contains(query)
      ).toList();
    }
    notifyListeners();
  }

  Future<double> getCustomerBalance(String customerId) async {
    return await _repository.getCustomerBalance(customerId);
  }
}
