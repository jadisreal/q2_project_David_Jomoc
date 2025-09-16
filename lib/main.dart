import 'package:flutter/material.dart';
import 'core/theme.dart';
import 'screens/home/home_screen.dart';
import 'screens/camera/camera_screen.dart';
import 'screens/tag/tag_screen.dart';
import 'screens/swipe/swipe_screen.dart';
import 'screens/inbox/inbox_screen.dart';
import 'screens/chat/chat_screen.dart';
import 'screens/success/success_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Swipe & Shop',
      theme: AppTheme.lightTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/camera': (context) => CameraScreen(),
        '/tag': (context) => TagScreen(),
        '/swipe': (context) => SwipeScreen(),
        '/inbox': (context) => InboxScreen(),
        '/chat': (context) => ChatScreen(),
        '/success': (context) => SuccessScreen(),
      },
    );
  }
}