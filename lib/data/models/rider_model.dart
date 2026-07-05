class RiderModel {
  final String id;
  final String? userId;
  final String riderCode;
  final String vehicleNumber;
  final String vehicleType;
  final String? licenseNumber;
  final String? assignedArea;
  final String commissionType;
  final double commissionValue;
  final String salaryType;
  final double salaryAmount;
  final int dailyTarget;
  final DateTime joiningDate;
  final String status;
  final double? currentLatitude;
  final double? currentLongitude;
  final DateTime? lastLocationUpdate;

  RiderModel({
    required this.id,
    this.userId,
    required this.riderCode,
    required this.vehicleNumber,
    this.vehicleType = 'bike',
    this.licenseNumber,
    this.assignedArea,
    this.commissionType = 'percentage',
    this.commissionValue = 0,
    this.salaryType = 'fixed',
    this.salaryAmount = 0,
    this.dailyTarget = 0,
    required this.joiningDate,
    this.status = 'active',
    this.currentLatitude,
    this.currentLongitude,
    this.lastLocationUpdate,
  });

  factory RiderModel.fromJson(Map<String, dynamic> json) {
    return RiderModel(
      id: json['id'] ?? '',
      userId: json['user_id'],
      riderCode: json['rider_code'] ?? '',
      vehicleNumber: json['vehicle_number'] ?? '',
      vehicleType: json['vehicle_type'] ?? 'bike',
      licenseNumber: json['license_number'],
      assignedArea: json['assigned_area'],
      commissionType: json['commission_type'] ?? 'percentage',
      commissionValue: (json['commission_value'] ?? 0).toDouble(),
      salaryType: json['salary_type'] ?? 'fixed',
      salaryAmount: (json['salary_amount'] ?? 0).toDouble(),
      dailyTarget: json['daily_target'] ?? 0,
      joiningDate: DateTime.parse(json['joining_date'] ?? DateTime.now().toIso8601String()),
      status: json['status'] ?? 'active',
      currentLatitude: json['current_latitude']?.toDouble(),
      currentLongitude: json['current_longitude']?.toDouble(),
      lastLocationUpdate: json['last_location_update'] != null 
          ? DateTime.parse(json['last_location_update']) 
          : null,
    );
  }
}
