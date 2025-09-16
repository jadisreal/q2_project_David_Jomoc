import 'package:flutter/material.dart';

class AppConstants {
  static const String appName = "Swipe & Shop";
  static const String tagline = "Fix more. Trash less. Trade like neighbors. ♻️📱";

  // Colors
  static const Color primaryColor = Color(0xFF2E7D32); // Green 800
  static const Color secondaryColor = Color(0xFF388E3C); // Green 700
  static const Color swipeAccept = Color(0xFFE53935); // Red 500
  static const Color swipeReject = Color(0xFF9E9E9E); // Grey 500

  // Route names
  static const String routeHome = '/';
  static const String routeCamera = '/camera';
  static const String routeTag = '/tag';
  static const String routeSwipe = '/swipe';
  static const String routeInbox = '/inbox';
  static const String routeChat = '/chat';
  static const String routeSuccess = '/success';

  // Keys
  static const String imageKey = 'image';
  static const String partIHaveKey = 'partIHave';
  static const String matchKey = 'match';
}