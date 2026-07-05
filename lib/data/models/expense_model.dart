class ExpenseModel {
  final String id;
  final String expenseCode;
  final String category;
  final String? subCategory;
  final double amount;
  final String? description;
  final DateTime expenseDate;
  final String? paymentMethod;
  final String? referenceNumber;
  final String? receiptUrl;
  final String? approvedBy;
  final String status;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  ExpenseModel({
    required this.id,
    required this.expenseCode,
    required this.category,
    this.subCategory,
    required this.amount,
    this.description,
    required this.expenseDate,
    this.paymentMethod,
    this.referenceNumber,
    this.receiptUrl,
    this.approvedBy,
    required this.status,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      id: json['id'] ?? '',
      expenseCode: json['expense_code'] ?? '',
      category: json['category'] ?? '',
      subCategory: json['sub_category'],
      amount: (json['amount'] ?? 0).toDouble(),
      description: json['description'],
      expenseDate: DateTime.parse(json['expense_date'] ?? DateTime.now().toIso8601String()),
      paymentMethod: json['payment_method'],
      referenceNumber: json['reference_number'],
      receiptUrl: json['receipt_url'],
      approvedBy: json['approved_by'],
      status: json['status'] ?? 'pending',
      notes: json['notes'],
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updated_at'] ?? DateTime.now().toIso8601String()),
    );
  }
}
