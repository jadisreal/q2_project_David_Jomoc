class PartMatch {
  final String id;
  final String name;
  final String distance;
  final String has;
  final String wants;
  final String avatar;
  final bool unread;
  final String? partIHave; // optional: only in chat/inbox context
  final String? lastMessage;
  final String? time;

  PartMatch({
    required this.id,
    required this.name,
    required this.distance,
    required this.has,
    required this.wants,
    required this.avatar,
    this.unread = false,
    this.partIHave,
    this.lastMessage,
    this.time,
  });

  factory PartMatch.fromMap(Map<String, dynamic> map) {
    return PartMatch(
      id: map['id'] as String,
      name: map['name'] as String,
      distance: map['distance'] as String,
      has: map['has'] as String,
      wants: map['wants'] as String,
      avatar: map['avatar'] as String,
      unread: map['unread'] ?? false,
      partIHave: map['partIHave'] as String?,
      lastMessage: map['lastMessage'] as String?,
      time: map['time'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'distance': distance,
    'has': has,
    'wants': wants,
    'avatar': avatar,
    'unread': unread,
    'partIHave': partIHave,
    'lastMessage': lastMessage,
    'time': time,
  };
}