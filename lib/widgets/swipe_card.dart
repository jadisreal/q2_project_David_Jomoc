import 'package:flutter/material.dart';
import '../models/part_match.dart';
import '../core/constants.dart';

class SwipeCard extends StatelessWidget {
  final PartMatch part;
  final String? partIHave;
  final VoidCallback? onSwipeLeft;
  final VoidCallback? onSwipeRight;

  const SwipeCard({
    Key? key,
    required this.part,
    this.partIHave,
    this.onSwipeLeft,
    this.onSwipeRight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: partIHave != null ? Colors.white : part.colorFromName,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      child: Column(
        children: [
          if (partIHave != null)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                "I have: $partIHave",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppConstants.primaryColor,
                ),
              ),
            ),
          Container(
            height: 280,
            decoration: BoxDecoration(
              color: part.colorFromName,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: part.avatar.startsWith('assets/')
                      ? AssetImage(part.avatar) as ImageProvider
                      : NetworkImage(part.avatar),
                  radius: 40,
                ),
                const SizedBox(height: 16),
                Text(
                  "${part.name} has:",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  part.has,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppConstants.secondaryColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Wants: ${part.wants}",
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                Text(
                  "📍 ${part.distance}",
                  style: TextStyle(fontSize: 14, color: AppConstants.primaryColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

extension PartMatchColor on PartMatch {
  Color get colorFromName {
    final hash = name.hashCode % 6;
    final colors = [
      Colors.blue[50]!,
      Colors.orange[50]!,
      Colors.purple[50]!,
      Colors.red[50]!,
      Colors.teal[50]!,
      Colors.pink[50]!,
    ];
    return colors[hash];
  }
}