import 'package:equatable/equatable.dart';
import 'customer_model.dart';
import 'rider_model.dart';

class OrderModel extends Equatable {
  final String id;
  final String orderNumber;
  final String customerId;
  final String? riderId;
  final String orderType;
  final String status;
  final DateTime orderDate;
  final DateTime? deliveryDate;
  final String? deliveryTimeSlot;
  final String? deliveryAddress;
  final double? deliveryLatitude;
  final double? deliveryLongitude;
  final double subtotal;
  final double discount;
  final double tax;
  final double deliveryCharge;
  final double totalAmount;
  final double paidAmount;
  final String paymentMethod;
  final String paymentStatus;
  final String? notes;
  final String? signatureUrl;
  final DateTime? deliveredAt;
  final String? cancelledBy;
  final String? cancellationReason;
  final String? createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<OrderItemModel>? items;
  final CustomerModel? customer;
  final RiderModel? rider;

  const OrderModel({
    required this.id,
    required this.orderNumber,
    required this.customerId,
    this.riderId,
    required this.orderType,
    required this.status,
    required this.orderDate,
    this.deliveryDate,
    this.deliveryTimeSlot,
    this.deliveryAddress,
    this.deliveryLatitude,
    this.deliveryLongitude,
    required this.subtotal,
    required this.discount,
    required this.tax,
    required this.deliveryCharge,
    required this.totalAmount,
    required this.paidAmount,
    required this.paymentMethod,
    required this.paymentStatus,
    this.notes,
    this.signatureUrl,
    this.deliveredAt,
    this.cancelledBy,
    this.cancellationReason,
    this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.items,
    this.customer,
    this.rider,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] ?? '',
      orderNumber: json['order_number'] ?? '',
      customerId: json['customer_id'] ?? '',
      riderId: json['rider_id'],
      orderType: json['order_type'] ?? 'regular',
      status: json['status'] ?? 'pending',
      orderDate: DateTime.parse(json['order_date'] ?? DateTime.now().toIso8601String()),
      deliveryDate: json['delivery_date'] != null ? DateTime.parse(json['delivery_date']) : null,
      deliveryTimeSlot: json['delivery_time_slot'],
      deliveryAddress: json['delivery_address'],
      deliveryLatitude: json['delivery_latitude']?.toDouble(),
      deliveryLongitude: json['delivery_longitude']?.toDouble(),
      subtotal: (json['subtotal'] ?? 0).toDouble(),
      discount: (json['discount'] ?? 0).toDouble(),
      tax: (json['tax'] ?? 0).toDouble(),
      deliveryCharge: (json['delivery_charge'] ?? 0).toDouble(),
      totalAmount: (json['total_amount'] ?? 0).toDouble(),
      paidAmount: (json['paid_amount'] ?? 0).toDouble(),
      paymentMethod: json['payment_method'] ?? 'cash',
      paymentStatus: json['payment_status'] ?? 'pending',
      notes: json['notes'],
      signatureUrl: json['signature_url'],
      deliveredAt: json['delivered_at'] != null ? DateTime.parse(json['delivered_at']) : null,
      cancelledBy: json['cancelled_by'],
      cancellationReason: json['cancellation_reason'],
      createdBy: json['created_by'],
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updated_at'] ?? DateTime.now().toIso8601String()),
      items: json['items'] != null 
          ? (json['items'] as List).map((i) => OrderItemModel.fromJson(i)).toList()
          : null,
      customer: json['customer'] != null ? CustomerModel.fromJson(json['customer']) : null,
      rider: json['rider'] != null ? RiderModel.fromJson(json['rider']) : null,
    );
  }

  @override
  List<Object?> get props => [id, status, totalAmount];
}

class OrderItemModel {
  final String id;
  final String orderId;
  final String? productId;
  final String? bottleId;
  final int quantity;
  final double unitPrice;
  final double totalPrice;
  final double discountPercent;
  final int returnQuantity;
  final String status;
  final DateTime createdAt;

  OrderItemModel({
    required this.id,
    required this.orderId,
    this.productId,
    this.bottleId,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
    required this.discountPercent,
    required this.returnQuantity,
    required this.status,
    required this.createdAt,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      id: json['id'] ?? '',
      orderId: json['order_id'] ?? '',
      productId: json['product_id'],
      bottleId: json['bottle_id'],
      quantity: json['quantity'] ?? 0,
      unitPrice: (json['unit_price'] ?? 0).toDouble(),
      totalPrice: (json['total_price'] ?? 0).toDouble(),
      discountPercent: (json['discount_percent'] ?? 0).toDouble(),
      returnQuantity: json['return_quantity'] ?? 0,
      status: json['status'] ?? 'active',
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
    );
  }
}
