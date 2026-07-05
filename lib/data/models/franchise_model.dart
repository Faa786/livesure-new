class FranchiseModel {
  final String id;
  final String franchiseCode;
  final String name;
  final String? ownerName;
  final String? email;
  final String phone;
  final String address;
  final String? city;
  final String? state;
  final String? pincode;
  final String? gstNumber;
  final double commissionRate;
  final DateTime openingDate;
  final String status;
  final double? latitude;
  final double? longitude;
  final DateTime createdAt;
  final DateTime updatedAt;

  FranchiseModel({
    required this.id,
    required this.franchiseCode,
    required this.name,
    this.ownerName,
    this.email,
    required this.phone,
    required this.address,
    this.city,
    this.state,
    this.pincode,
    this.gstNumber,
    this.commissionRate = 0,
    required this.openingDate,
    this.status = 'active',
    this.latitude,
    this.longitude,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FranchiseModel.fromJson(Map<String, dynamic> json) {
    return FranchiseModel(
      id: json['id'] ?? '',
      franchiseCode: json['franchise_code'] ?? '',
      name: json['name'] ?? '',
      ownerName: json['owner_name'],
      email: json['email'],
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
      city: json['city'],
      state: json['state'],
      pincode: json['pincode'],
      gstNumber: json['gst_number'],
      commissionRate: (json['commission_rate'] ?? 0).toDouble(),
      openingDate: DateTime.parse(json['opening_date'] ?? DateTime.now().toIso8601String()),
      status: json['status'] ?? 'active',
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updated_at'] ?? DateTime.now().toIso8601String()),
    );
  }
}
