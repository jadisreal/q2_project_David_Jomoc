import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../core/constants.dart';

class TagScreen extends StatefulWidget {
  const TagScreen({Key? key}) : super(key: key);

  @override
  _TagScreenState createState() => _TagScreenState();
}

class _TagScreenState extends State<TagScreen> {
  String partName = "Detecting...";
  XFile? _image;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
      _image = args?['image'] as XFile?;
      partName = _mockAIDetect(_image?.path ?? '');
      _controller = TextEditingController(text: partName);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _mockAIDetect(String path) {
    List<String> parts = [
      "iPhone 11 Battery",
      "Samsung S20 Screen",
      "USB-C Charging Port",
      "Xiaomi Power Button",
      "Pixel 4a Camera Module",
      "OnePlus Vibration Motor",
      "iPad Pro Charging Port",
      "MacBook Air Keyboard",
      "AirPods Charging Case",
      "GoPro Battery"
    ];
    return parts[DateTime.now().second % parts.length];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("🏷️ Tag Your Part")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: _image != null
                    ? Image.file(File(_image!.path), fit: BoxFit.cover)
                    : Container(),
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: "Edit part name (optional)",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Colors.grey[50],
              ),
              onChanged: (value) => partName = value,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("✅ Part posted! It’s now in the swipe pool.")),
                );
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppConstants.routeSwipe,
                      (route) => false,
                  arguments: {'partIHave': partName},
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.cloud_upload, size: 20),
                  SizedBox(width: 8),
                  Text("POST & START SWAPPING"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}