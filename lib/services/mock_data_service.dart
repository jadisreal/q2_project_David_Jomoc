import 'package:flutter/material.dart';
import '../models/part_match.dart';

class MockDataService {
  static List<PartMatch> getAvailableParts() {
    return [
      PartMatch(
        id: "1",
        name: "Ali",
        distance: "200m",
        has: "iPhone 11 Charging Port",
        wants: "Samsung S20 Screen",
        avatar: "assets/images/avatars/ali.jpeg",
        unread: true,
      ),
      PartMatch(
        id: "2",
        name: "Maya",
        distance: "500m",
        has: "Pixel 4a Camera Module",
        wants: "iPhone 11 Battery",
        avatar: "https://via.placeholder.com/50/F4B400/FFFFFF?text=M",
        unread: false,
      ),
      PartMatch(
        id: "3",
        name: "Raj",
        distance: "1.2km",
        has: "USB-C Cable (working)",
        wants: "Power Bank Battery",
        avatar: "https://via.placeholder.com/50/DB4437/FFFFFF?text=R",
        unread: true,
      ),
      PartMatch(
        id: "4",
        name: "Zoe",
        distance: "300m",
        has: "OnePlus Vibration Motor",
        wants: "iPad Pro Charging Port",
        avatar: "https://via.placeholder.com/50/0F9D58/FFFFFF?text=Z",
        unread: false,
      ),
      PartMatch(
        id: "5",
        name: "Leo",
        distance: "800m",
        has: "MacBook Air Keyboard",
        wants: "AirPods Charging Case",
        avatar: "https://via.placeholder.com/50/AB47BC/FFFFFF?text=L",
        unread: true,
      ),
      PartMatch(
        id: "6",
        name: "Nina",
        distance: "1.5km",
        has: "GoPro Battery",
        wants: "Xiaomi Power Button",
        avatar: "https://via.placeholder.com/50/FF7043/FFFFFF?text=N",
        unread: false,
      ),
    ];
  }

  static List<PartMatch> getInboxMatches() {
    return [
      PartMatch(
        id: "1",
        name: "Ali",
        avatar: "assets/images/avatars/ali.jpeg",
        lastMessage: "Hey! I’m free this weekend.",
        time: "2m ago",
        unread: true,
        partIHave: "Samsung S20 Screen",
        has: "iPhone 11 Charging Port",
        wants: "",
        distance: "",
      ),
      PartMatch(
        id: "3",
        name: "Raj",
        avatar: "assets/images/avatars/raj.jpeg",
        lastMessage: "Where’s good for you?",
        time: "1h ago",
        unread: true,
        partIHave: "Power Bank Battery",
        has: "USB-C Cable",
        wants: "",
        distance: "",
      ),
      PartMatch(
        id: "5",
        name: "Leo",
        avatar: "assets/images/avatars/leo.jpeg",
        lastMessage: "Do you have time today?",
        time: "3d ago",
        unread: false,
        partIHave: "AirPods Charging Case",
        has: "MacBook Air Keyboard",
        wants: "",
        distance: "",
      ),
    ];
  }

  static List<Map<String, dynamic>> getChatMessages(String matchId) {
    return [
      {
        "text": "Hi! I saw you have the part I need. Still available?",
        "isUser": false,
        "time": "10:30 AM",
      },
      {
        "text": "Yes! Free after 3 PM today or tomorrow morning.",
        "isUser": true,
        "time": "10:32 AM",
      },
      {
        "text": "Perfect! Meet at coffee shop on Main St?",
        "isUser": false,
        "time": "10:35 AM",
      },
      {
        "text": "Sounds good. I’ll bring my part. See you there!",
        "isUser": true,
        "time": "10:37 AM",
      },
    ];
  }
}