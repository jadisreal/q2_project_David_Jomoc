import 'package:flutter/material.dart';
import '../../core/constants.dart';
import '../../models/part_match.dart';
import '../../services/mock_data_service.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final matches = MockDataService.getInboxMatches();

    return Scaffold(
      appBar: AppBar(title: const Text("📬 Inbox")),
      body: matches.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.mail_outline, size: 80, color: Colors.grey),
            const SizedBox(height: 20),
            const Text("No matches yet", style: TextStyle(fontSize: 18, color: Colors.grey)),
            const SizedBox(height: 10),
            const Text("Start swiping to find trades!", style: TextStyle(color: Colors.grey)),
          ],
        ),
      )
          : ListView.builder(
        itemCount: matches.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final match = matches[index];
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: Stack(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(match.avatar),
                    radius: 24,
                  ),
                  if (match.unread)
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                ],
              ),
              title: Text(match.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(match.lastMessage ?? "", maxLines: 1, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 4),
                  Text(
                    "You: ${match.partIHave} ↔ Them: ${match.has}",
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(match.time ?? "", style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  const SizedBox(height: 8),
                  const Icon(Icons.chevron_right, color: Colors.grey),
                ],
              ),
              onTap: () {
                Navigator.pushNamed(context, AppConstants.routeChat, arguments: match);
              },
            ),
          );
        },
      ),
    );
  }
}