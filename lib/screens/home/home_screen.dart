import 'package:flutter/material.dart';
import '../../core/constants.dart';
import '../../models/part_match.dart';
import '../../services/mock_data_service.dart';
import '../../widgets/swipe_card.dart';
import '../../widgets/app_bar_menu.dart';
import '../../utils/gesture_detector_swipe.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  late List<PartMatch> parts;

  @override
  void initState() {
    super.initState();
    parts = MockDataService.getAvailableParts();
  }

  void _swipeLeft() {
    setState(() {
      currentIndex = (currentIndex + 1) % parts.length;
    });
  }

  void _swipeRight() {
    if (currentIndex >= parts.length) return;
    final match = parts[currentIndex];
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("🎉 MATCH!", style: TextStyle(color: AppConstants.primaryColor)),
        content: Text(
          "${match.name} wants to swap!\n\nYou: ??? ↔ Them: ${match.has}\n\n👉 Chat to arrange meetup!",
          style: const TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("CANCEL")),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pushNamed(context, AppConstants.routeChat, arguments: match);
            },
            child: const Text("CHAT NOW"),
          ),
        ],
      ),
    );

    setState(() {
      currentIndex = (currentIndex + 1) % parts.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithDrawer(
        title: "♻️ Swipe & Shop",
        context: context,
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, AppConstants.routeInbox),
            icon: const Icon(Icons.mail_outline),
          ),
        ],
      ),
      drawer: AppBarWithDrawer.buildDrawer(context),
      body: parts.isEmpty
          ? const Center(child: Text("No parts available. Try snapping one!"))
          : Column(
              children: [
                Expanded(
                  child: SwipeDetector(
                    onSwipe: (direction) {
                      if (direction == SwipeDirection.left) {
                        _swipeLeft();
                      } else {
                        _swipeRight();
                      }
                    },
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: SwipeCard(
                        key: ValueKey(currentIndex),
                        part: parts[currentIndex],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 32.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: _swipeLeft,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppConstants.swipeReject,
                          foregroundColor: Colors.grey[800],
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(24),
                        ),
                        icon: const Icon(Icons.close, size: 30),
                        label: const Text(""),
                      ),
                      ElevatedButton.icon(
                        onPressed: _swipeRight,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppConstants.swipeAccept,
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(24),
                        ),
                        icon: const Icon(Icons.favorite, size: 30, color: Colors.white),
                        label: const Text(""),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}