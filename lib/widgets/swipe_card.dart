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
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420, minWidth: 280),
          child: AspectRatio(
            aspectRatio: 3 / 4,
            child: Card(
              elevation: 10,
              clipBehavior: Clip.hardEdge,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              child: InkWell(
                onTap: () {},
                child: Column(
                  children: [
                    // Optional small banner when the user already has the part
                    if (partIHave != null)
                      Container(
                        width: double.infinity,
                        color: AppConstants.primaryColor.withAlpha((0.08 * 255).round()),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        child: Text(
                          "I have: $partIHave",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppConstants.primaryColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                    // Main content area
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                        decoration: BoxDecoration(
                          // subtle gradient using the color derived from the part name
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [part.colorFromName.withAlpha((0.95 * 255).round()), Colors.white],
                            stops: const [0.0, 0.95],
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Avatar with subtle border and shadow
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))],
                                border: Border.all(color: Colors.white, width: 2),
                              ),
                              child: _buildAvatar(part),
                            ),

                            const SizedBox(height: 14),

                            // "Name has:" caption
                            Text(
                              "${part.name} has:",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[700],
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),

                            const SizedBox(height: 8),

                            // Product title (primary focal text)
                            Text(
                              part.has,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: AppConstants.primaryColor,
                                height: 1.05,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),

                            const SizedBox(height: 8),

                            // Wants line (secondary)
                            Text(
                              "Wants: ${part.wants}",
                              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),

                            const Spacer(),

                            // Divider for a neat footer separation
                            Divider(color: Colors.grey[300], thickness: 1),

                            // Footer row with distance centered
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.location_on, size: 16, color: Colors.grey[700]),
                                  const SizedBox(width: 6),
                                  Text(
                                    part.distance,
                                    style: TextStyle(fontSize: 13, color: AppConstants.secondaryColor),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
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

Widget _buildAvatar(PartMatch part) {
  // Show image when available, otherwise show initials
  final avatar = part.avatar.trim();
  if (avatar.isNotEmpty) {
    try {
      final provider = avatar.startsWith('assets/') ? AssetImage(avatar) as ImageProvider : NetworkImage(avatar);
      return CircleAvatar(backgroundColor: Colors.white, radius: 42, backgroundImage: provider);
    } catch (_) {
      // fall through to initials fallback
    }
  }

  // initials fallback
  final initials = part.name.trim().isNotEmpty ? part.name.trim().split(' ').map((s) => s.isNotEmpty ? s[0] : '').take(2).join() : '?';
  return CircleAvatar(
    radius: 42,
    backgroundColor: Colors.grey[200],
    child: Text(initials.toUpperCase(), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black87)),
  );
}
