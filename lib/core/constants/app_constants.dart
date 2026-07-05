class AppConstants {
  static const String appName = 'LiveSure OP';
  static const String appVersion = '1.0.0';
  static const String companyName = 'LiveSure Water Solutions';
  static const int maxRetries = 3;
  static const Duration apiTimeout = Duration(seconds: 30);
  static const Duration cacheDuration = Duration(hours: 24);
  
  static const List<String> roles = [
    'owner',
    'office_staff',
    'rider',
    'customer',
  ];
  
  static const List<String> orderStatuses = [
    'pending',
    'confirmed',
    'processing',
    'ready',
    'dispatched',
    'delivered',
    'cancelled',
    'returned',
  ];
  
  static const List<String> paymentMethods = [
    'cash',
    'credit',
    'bank_transfer',
    'mobile_payment',
    'wallet',
  ];
  
  static const List<String> bottleStatuses = [
    'full',
    'empty',
    'damaged',
    'lost',
    'returned',
  ];
}
