import 'package:flutter/material.dart';
import '../../core/constants.dart';
import '../../models/part_match.dart';
import '../../services/mock_data_service.dart';
import '../../widgets/swipe_card.dart';
import '../../utils/gesture_detector_swipe.dart';

class SwipeScreen extends StatefulWidget {
  const SwipeScreen({Key? key}) : super(key: key);

  @override
  _SwipeScreenState createState() => _SwipeScreenState();
}

class _SwipeScreenState extends State<SwipeScreen> {
  int currentIndex = 0;
  String partIHave = "Unknown Part";
  late List<PartMatch> mockTrades;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
      partIHave = args?['partIHave'] ?? "Unknown Part";
      mockTrades = MockDataService.getAvailableParts();
    });
  }

  void _swipeLeft() {
    setState(() {
      currentIndex = (currentIndex + 1) % mockTrades.length;
    });
  }

  void _swipeRight() {
    if (currentIndex >= mockTrades.length) return;
    final match = mockTrades[currentIndex];
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("🎉 MATCH!", style: TextStyle(color: AppConstants.primaryColor)),
        content: Text(
          "${match.name} wants your $partIHave and has ${match.has}!\n\n📍 ${match.distance} away\n\n Tap below to chat and arrange meetup!",
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
  }

  @override
  Widget build(BuildContext context) {
    if (mockTrades.isEmpty || currentIndex >= mockTrades.length) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, size: 100, color: Colors.green),
              const SizedBox(height: 20),
              const Text("No more swaps nearby!", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              const Text("Snap another part or come back later.", style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: () => Navigator.pushReplacementNamed(context, AppConstants.routeCamera),
                icon: const Icon(Icons.refresh),
                label: const Text("SNAP AGAIN"),
              ),
            ],
          ),
        ),
      );
    }

    final trade = mockTrades[currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Swipe to Trade"),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushReplacementNamed(context, AppConstants.routeCamera),
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: Column(
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
                  part: trade,
                  partIHave: partIHave,
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