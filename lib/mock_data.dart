import 'package:flutter/material.dart'; // 👈 CRITICAL IMPORT

class MockData {
  static List<Map<String, dynamic>> getAvailableParts() {
    return [
      {
        "id": "1",
        "name": "Ali",
        "distance": "200m",
        "has": "iPhone 11 Charging Port",
        "wants": "Samsung S20 Screen",
        "color": Colors.blue[50]!,
        "avatar": "https://via.placeholder.com/50/4285F4/FFFFFF?text=A",
        "lastMessage": "Hey! I’m free this weekend.",
        "unread": true,
      },
      {
        "id": "2",
        "name": "Maya",
        "distance": "500m",
        "has": "Pixel 4a Camera Module",
        "wants": "iPhone 11 Battery",
        "color": Colors.orange[50]!,
        "avatar": "https://via.placeholder.com/50/F4B400/FFFFFF?text=M",
        "lastMessage": "Can we meet at the cafe?",
        "unread": false,
      },
      {
        "id": "3",
        "name": "Raj",
        "distance": "1.2km",
        "has": "USB-C Cable (working)",
        "wants": "Power Bank Battery",
        "color": Colors.purple[50]!,
        "avatar": "https://via.placeholder.com/50/DB4437/FFFFFF?text=R",
        "lastMessage": "Where’s good for you?",
        "unread": true,
      },
      {
        "id": "4",
        "name": "Zoe",
        "distance": "300m",
        "has": "OnePlus Vibration Motor",
        "wants": "iPad Pro Charging Port",
        "color": Colors.red[50]!,
        "avatar": "https://via.placeholder.com/50/0F9D58/FFFFFF?text=Z",
        "lastMessage": "I’m downtown tomorrow.",
        "unread": false,
      },
      {
        "id": "5",
        "name": "Leo",
        "distance": "800m",
        "has": "MacBook Air Keyboard",
        "wants": "AirPods Charging Case",
        "color": Colors.teal[50]!,
        "avatar": "https://via.placeholder.com/50/AB47BC/FFFFFF?text=L",
        "lastMessage": "Do you have time today?",
        "unread": true,
      },
      {
        "id": "6",
        "name": "Nina",
        "distance": "1.5km",
        "has": "GoPro Battery",
        "wants": "Xiaomi Power Button",
        "color": Colors.pink[50]!,
        "avatar": "https://via.placeholder.com/50/FF7043/FFFFFF?text=N",
        "lastMessage": "Let me know when you’re free!",
        "unread": false,
      },
    ];
  }

  static List<Map<String, dynamic>> getInboxMatches() {
    return [
      {
        "id": "1",
        "name": "Ali",
        "avatar": "https://via.placeholder.com/50/4285F4/FFFFFF?text=A",
        "lastMessage": "Hey! I’m free this weekend.",
        "time": "2m ago",
        "unread": true,
        "partIHave": "Samsung S20 Screen",
        "partTheyHave": "iPhone 11 Charging Port",
      },
      {
        "id": "3",
        "name": "Raj",
        "avatar": "https://via.placeholder.com/50/DB4437/FFFFFF?text=R",
        "lastMessage": "Where’s good for you?",
        "time": "1h ago",
        "unread": true,
        "partIHave": "Power Bank Battery",
        "partTheyHave": "USB-C Cable",
      },
      {
        "id": "5",
        "name": "Leo",
        "avatar": "https://via.placeholder.com/50/AB47BC/FFFFFF?text=L",
        "lastMessage": "Do you have time today?",
        "time": "3d ago",
        "unread": false,
        "partIHave": "AirPods Charging Case",
        "partTheyHave": "MacBook Air Keyboard",
      },
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