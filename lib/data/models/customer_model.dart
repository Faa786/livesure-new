class CustomerModel {
  final String id;
  final String? userId;
  final String customerCode;
  final String? businessName;
  final String? contactPerson;
  final String? email;
  final String phone;
  final String? alternatePhone;
  final String address;
  final String? area;
  final String? city;
  final String? state;
  final String? pincode;
  final String? gstNumber;
  final double openingBalance;
  final double creditLimit;
  final int creditDays;
  final double discountPercent;
  final String paymentTerms;
  final String status;
  final double? latitude;
  final double? longitude;
  final DateTime createdAt;
  final DateTime updatedAt;

  CustomerModel({
    required this.id,
    this.userId,
    required this.customerCode,
    this.businessName,
    this.contactPerson,
    this.email,
    required this.phone,
    this.alternatePhone,
    required this.address,
    this.area,
    this.city,
    this.state,
    this.pincode,
    this.gstNumber,
    this.openingBalance = 0,
    this.creditLimit = 0,
    this.creditDays = 0,
    this.discountPercent = 0,
    this.paymentTerms = 'cash',
    this.status = 'active',
    this.latitude,
    this.longitude,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json['id'] ?? '',
      userId: json['user_id'],
      customerCode: json['customer_code'] ?? '',
      businessName: json['business_name'],
      contactPerson: json['contact_person'],
      email: json['email'],
      phone: json['phone'] ?? '',
      alternatePhone: json['alternate_phone'],
      address: json['address'] ?? '',
      area: json['area'],
      city: json['city'],
      state: json['state'],
      pincode: json['pincode'],
      gstNumber: json['gst_number'],
      openingBalance: (json['opening_balance'] ?? 0).toDouble(),
      creditLimit: (json['credit_limit'] ?? 0).toDouble(),
      creditDays: json['credit_days'] ?? 0,
      discountPercent: (json['discount_percent'] ?? 0).toDouble(),
      paymentTerms: json['payment_terms'] ?? 'cash',
      status: json['status'] ?? 'active',
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updated_at'] ?? DateTime.now().toIso8601String()),
    );
  }
}
