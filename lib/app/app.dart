import '../screens/rider/rider_home_screen.dart';
import '../screens/vendor/vendor_products_screen.dart';
import '../screens/vendor/vendor_orders_screen.dart';
import '../screens/auth/account_type_screen.dart';
import 'package:flutter/material.dart';
import '../screens/vendor/vendor_home_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/otp_verification_screen.dart';
import '../screens/auth/profile_setup_screen.dart';
import '../screens/auth/signup_screen.dart';
import '../screens/auth/welcome_screen.dart';
import '../screens/customer/customer_home_screen.dart';
import '../screens/customer/search_screen.dart';
import '../screens/customer/vendor_listing_screen.dart';
import '../screens/customer/vendor_store_placeholder_screen.dart';
import '../services/auth_service_scope.dart';
import '../services/mock_auth_service.dart';
import '../theme/renon_theme.dart';
import 'app_routes.dart';
import '../screens/rider/rider_deliveries_screen.dart';
class RenonApp extends StatefulWidget {
  const RenonApp({super.key});

  @override
  State<RenonApp> createState() => _RenonAppState();
}

class _RenonAppState extends State<RenonApp> {
  final _authService = MockAuthService();

  @override
  Widget build(BuildContext context) {
    return AuthServiceScope(
      authService: _authService,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Renon',
        theme: RenonTheme.light,
        initialRoute: AppRoutes.welcome,
     routes: {
  AppRoutes.welcome: (_) => const WelcomeScreen(),
  AppRoutes.accountType: (_) => const AccountTypeScreen(),
  AppRoutes.login: (_) => const LoginScreen(),
  AppRoutes.signup: (_) => const SignupScreen(),
  AppRoutes.otpVerification: (_) => const OtpVerificationScreen(),
  AppRoutes.profileSetup: (_) => const ProfileSetupScreen(),
  AppRoutes.customerHome: (_) => const CustomerHomeScreen(),
  AppRoutes.search: (_) => const SearchScreen(),
  AppRoutes.vendorListing: (_) => const VendorListingScreen(),
  AppRoutes.vendorStore: (_) => const VendorStorePlaceholderScreen(),
  AppRoutes.vendorHome: (_) => const VendorHomeScreen(),
  AppRoutes.vendorProducts: (_) => const VendorProductsScreen(),
  AppRoutes.vendorOrders: (_) => const VendorOrdersScreen(),
  AppRoutes.riderHome: (_) => const RiderHomeScreen(),
  AppRoutes.riderDeliveries: (_) => const RiderDeliveriesScreen(),
},
      ),
    );
  }
}
