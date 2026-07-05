import 'package:flutter/material.dart';
import '../ui/screens/auth/login_screen.dart';
import '../ui/screens/auth/register_screen.dart';
import '../ui/screens/auth/forgot_password_screen.dart';
import '../ui/screens/owner/owner_dashboard.dart';
import '../ui/screens/office/office_dashboard.dart';
import '../ui/screens/office/order_management.dart';
import '../ui/screens/office/customer_management.dart';
import '../ui/screens/office/rider_management.dart';
import '../ui/screens/office/inventory_management.dart';
import '../ui/screens/rider/rider_dashboard.dart';
import '../ui/screens/customer/customer_dashboard.dart';
import '../ui/screens/shared/profile_screen.dart';
import '../ui/screens/shared/settings_screen.dart';
import '../ui/screens/shared/notifications_screen.dart';

class AppRoutes {
  static const String login = '/';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String ownerDashboard = '/owner/dashboard';
  static const String officeDashboard = '/office/dashboard';
  static const String riderDashboard = '/rider/dashboard';
  static const String customerDashboard = '/customer/dashboard';
  static const String orders = '/orders';
  static const String orderDetails = '/order-details';
  static const String createOrder = '/create-order';
  static const String customers = '/customers';
  static const String customerDetails = '/customer-details';
  static const String riders = '/riders';
  static const String riderDetails = '/rider-details';
  static const String routes = '/routes';
  static const String routeDetails = '/route-details';
  static const String inventory = '/inventory';
  static const String bottles = '/bottles';
  static const String subscriptions = '/subscriptions';
  static const String expenses = '/expenses';
  static const String analytics = '/analytics';
  static const String reports = '/reports';
  static const String attendance = '/attendance';
  static const String qrScanner = '/qr-scanner';
  static const String profile = '/profile';
  stastatic const String appSettings = '/settings';
  static const String notifications = '/notifications';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case ownerDashboard:
        return MaterialPageRoute(builder: (_) => const OwnerDashboard());
      case officeDashboard:
        return MaterialPageRoute(builder: (_) => const OfficeDashboard());
      case riderDashboard:
        return MaterialPageRoute(builder: (_) => const RiderDashboard());
      case customerDashboard:
        return MaterialPageRoute(builder: (_) => const CustomerDashboard());
      case orders:
        return MaterialPageRoute(builder: (_) => const OrderManagementScreen());
      case customers:
        return MaterialPageRoute(builder: (_) => const CustomerManagementScreen());
      case riders:
        return MaterialPageRoute(builder: (_) => const RiderManagementScreen());
      case inventory:
        return MaterialPageRoute(builder: (_) => const InventoryManagementScreen());
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case appSettings:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case notifications:
        return MaterialPageRoute(builder: (_) => const NotificationsScreen());
      default:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
    }
  }
}
