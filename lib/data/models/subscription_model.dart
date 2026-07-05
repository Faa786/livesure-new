class SubscriptionModel {
  final String id;
  final String customerId;
  final String? productId;
  final String frequency;
  final int quantityPerDelivery;
  final List<String> deliveryDays;
  final DateTime startDate;
  final DateTime? endDate;
  final String status;
  final bool autoRenew;
  final String? deliveryInstructions;
  final String? specialNotes;
  final DateTime createdAt;
  final DateTime updatedAt;

  SubscriptionModel({
    required this.id,
    required this.customerId,
    this.productId,
    required this.frequency,
    required this.quantityPerDelivery,
    required this.deliveryDays,
    required this.startDate,
    this.endDate,
    required this.status,
    required this.autoRenew,
    this.deliveryInstructions,
    this.specialNotes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionModel(
      id: json['id'] ?? '',
      customerId: json['customer_id'] ?? '',
      productId: json['product_id'],
      frequency: json['frequency'] ?? 'weekly',
      quantityPerDelivery: json['quantity_per_delivery'] ?? 1,
      deliveryDays: json['delivery_days'] != null 
          ? List<String>.from(json['delivery_days']) 
          : ['monday'],
      startDate: DateTime.parse(json['start_date'] ?? DateTime.now().toIso8601String()),
      endDate: json['end_date'] != null ? DateTime.parse(json['end_date']) : null,
      status: json['status'] ?? 'active',
      autoRenew: json['auto_renew'] ?? true,
      deliveryInstructions: json['delivery_instructions'],
      specialNotes: json['special_notes'],
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updated_at'] ?? DateTime.now().toIso8601String()),
    );
  }
}
