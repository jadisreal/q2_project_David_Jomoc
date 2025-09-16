import 'package:flutter/material.dart';
import '../../core/constants.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.greenAccent, Colors.white],
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.eco, size: 120, color: AppConstants.secondaryColor),
                  const SizedBox(height: 30),
                  const Text(
                    "SWAP SUCCESSFUL! 🎉",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppConstants.primaryColor),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "You just saved a part from the landfill.\nMeet up safely. Trade. Repeat.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.grey, height: 1.5),
                  ),
                  const SizedBox(height: 50),
                  ElevatedButton.icon(
                    onPressed: () => Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppConstants.routeHome,
                          (route) => false,
                    ),
                    icon: const Icon(Icons.refresh),
                    label: const Text("SWAP AGAIN ♻️"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}