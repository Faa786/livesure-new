class BottleModel {
  final String id;
  final String bottleCode;
  final String qrCode;
  final String? productId;
  final String? customerId;
  final String currentLocation;
  final String status;
  final String? lastScanLocation;
  final DateTime? lastScannedAt;
  final DateTime? manufactureDate;
  final DateTime? expiryDate;
  final String? lastCustomerId;
  final int totalTrips;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  BottleModel({
    required this.id,
    required this.bottleCode,
    required this.qrCode,
    this.productId,
    this.customerId,
    required this.currentLocation,
    required this.status,
    this.lastScanLocation,
    this.lastScannedAt,
    this.manufactureDate,
    this.expiryDate,
    this.lastCustomerId,
    this.totalTrips = 0,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BottleModel.fromJson(Map<String, dynamic> json) {
    return BottleModel(
      id: json['id'] ?? '',
      bottleCode: json['bottle_code'] ?? '',
      qrCode: json['qr_code'] ?? '',
      productId: json['product_id'],
      customerId: json['customer_id'],
      currentLocation: json['current_location'] ?? 'plant',
      status: json['status'] ?? 'full',
      lastScanLocation: json['last_scan_location'],
      lastScannedAt: json['last_scanned_at'] != null 
          ? DateTime.parse(json['last_scanned_at']) 
          : null,
      manufactureDate: json['manufacture_date'] != null 
          ? DateTime.parse(json['manufacture_date']) 
          : null,
      expiryDate: json['expiry_date'] != null 
          ? DateTime.parse(json['expiry_date']) 
          : null,
      lastCustomerId: json['last_customer_id'],
      totalTrips: json['total_trips'] ?? 0,
      notes: json['notes'],
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updated_at'] ?? DateTime.now().toIso8601String()),
    );
  }
}
