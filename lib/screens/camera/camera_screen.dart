import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../core/constants.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  XFile? _image;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() => _image = image);
      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushNamed(
        context,
        AppConstants.routeTag,
        arguments: {'image': _image},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("📸 Snap Your Part")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey[300]!, width: 2),
              ),
              child: _image != null
                  ? Image.file(File(_image!.path), fit: BoxFit.cover)
                  : const Icon(Icons.camera_alt_outlined, size: 80, color: Colors.grey),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: _pickImage,
              icon: const Icon(Icons.camera, size: 24),
              label: const Text("Take Photo of Your Part"),
            ),
            if (_image != null)
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  "AI is identifying your part...",
                  style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
                ),
              ),
          ],
        ),
      ),
    );
  }
}