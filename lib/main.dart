import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'mock_data.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Swipe & Shop',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.grey[50],
        fontFamily: 'Roboto',
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.green[800],
          elevation: 0,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.green[800],
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green[700],
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/camera': (context) => CameraScreen(),
        '/tag': (context) => TagScreen(),
        '/swipe': (context) => SwipeScreen(),
        '/inbox': (context) => InboxScreen(),
        '/chat': (context) => ChatScreen(),
        '/success': (context) => SuccessScreen(),
      },
    );
  }
}

// ========= HOME SCREEN =========
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<Map<String, dynamic>> parts = [];

  @override
  void initState() {
    super.initState();
    parts = MockData.getAvailableParts();
  }

  void _swipeLeft() {
    setState(() {
      currentIndex = (currentIndex + 1) % parts.length;
    });
  }

  void _swipeRight() {
    if (currentIndex >= parts.length) return;
    final match = parts[currentIndex];
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("🎉 MATCH!", style: TextStyle(color: Colors.green[800])),
        content: Text(
          "${match['name']} wants to swap!\n\nYou: ??? ↔ Them: ${match['has']}\n\n👉 Chat to arrange meetup!",
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: Text("CANCEL")),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pushNamed(context, '/chat', arguments: match);
            },
            child: Text("CHAT NOW"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("♻️ Swipe & Shop"),
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: Icon(Icons.menu),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/inbox'),
            icon: Icon(Icons.mail_outline),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.green[700]),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Snap Your Part'),
              onTap: () => Navigator.pushNamed(context, '/camera'),
            ),
            ListTile(
              leading: Icon(Icons.inbox),
              title: Text('Inbox'),
              onTap: () => Navigator.pushNamed(context, '/inbox'),
            ),
            ListTile(
              leading: Icon(Icons.label),
              title: Text('Sort by Tags'),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Sorting by tags... (mock)")),
                );
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: parts.isEmpty
          ? Center(child: Text("No parts available. Try snapping one!"))
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Container(
                  height: 320,
                  decoration: BoxDecoration(
                    color: parts[currentIndex]['color'],
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(parts[currentIndex]['avatar']),
                        radius: 40,
                      ),
                      SizedBox(height: 16),
                      Text(
                        "${parts[currentIndex]['name']} has:",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        parts[currentIndex]['has'],
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green[700]),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Wants: ${parts[currentIndex]['wants']}",
                        style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "📍 ${parts[currentIndex]['distance']}",
                        style: TextStyle(fontSize: 14, color: Colors.green[600]),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _swipeLeft,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        foregroundColor: Colors.grey[800],
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(24),
                      ),
                      icon: Icon(Icons.close, size: 30),
                      label: Text(""),
                    ),
                    ElevatedButton.icon(
                      onPressed: _swipeRight,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[500],
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(24),
                      ),
                      icon: Icon(Icons.favorite, size: 30, color: Colors.white),
                      label: Text(""),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ========= CAMERA SCREEN =========
class CameraScreen extends StatefulWidget {
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
      await Future.delayed(Duration(seconds: 1));
      Navigator.pushNamed(context, '/tag', arguments: {'image': _image});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("📸 Snap Your Part")),
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
                  : Icon(Icons.camera_alt_outlined, size: 80, color: Colors.grey[500]),
            ),
            SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: _pickImage,
              icon: Icon(Icons.camera, size: 24),
              label: Text("Take Photo of Your Part"),
            ),
            if (_image != null)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  "AI is identifying your part...",
                  style: TextStyle(color: Colors.grey[600], fontStyle: FontStyle.italic),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ========= TAG SCREEN =========
class TagScreen extends StatefulWidget {
  @override
  _TagScreenState createState() => _TagScreenState();
}

class _TagScreenState extends State<TagScreen> {
  String partName = "Detecting..."; // 👈 FIXED: NO LATE, SAFE DEFAULT
  XFile? _image;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
      _image = args?['image'] as XFile?;
      partName = _mockAIDetect(_image?.path ?? '');
    });
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
      appBar: AppBar(title: Text("🏷️ Tag Your Part")),
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
            SizedBox(height: 30),
            TextField(
              decoration: InputDecoration(
                labelText: "Edit part name (optional)",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Colors.grey[50],
              ),
              controller: TextEditingController(text: partName),
              onChanged: (value) => partName = value,
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("✅ Part posted! It’s now in the swipe pool.")),
                );
                Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
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

// ========= SWIPE SCREEN =========
class SwipeScreen extends StatefulWidget {
  @override
  _SwipeScreenState createState() => _SwipeScreenState();
}

class _SwipeScreenState extends State<SwipeScreen> {
  int currentIndex = 0;
  String partIHave = "Unknown Part"; // 👈 FIXED: NO LATE, SAFE DEFAULT

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
      partIHave = args?['partIHave'] ?? "Unknown Part";
    });
  }

  final List<Map<String, dynamic>> mockTrades = MockData.getAvailableParts();

  void _swipeLeft() => setState(() => currentIndex = (currentIndex + 1) % mockTrades.length);

  void _swipeRight() {
    if (currentIndex >= mockTrades.length) return;
    final match = mockTrades[currentIndex];
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("🎉 MATCH!", style: TextStyle(color: Colors.green[800])),
        content: Text(
          "${match['name']} wants your $partIHave and has ${match['has']}!\n\n📍 ${match['distance']} away\n\n👉 Tap below to chat and arrange meetup!",
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: Text("CANCEL")),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pushNamed(context, '/chat', arguments: match);
            },
            child: Text("CHAT NOW"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (currentIndex >= mockTrades.length) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle, size: 100, color: Colors.green[700]),
              SizedBox(height: 20),
              Text("No more swaps nearby!", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text("Snap another part or come back later.", style: TextStyle(color: Colors.grey[600])),
              SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: () => Navigator.pushReplacementNamed(context, '/camera'),
                icon: Icon(Icons.refresh),
                label: Text("SNAP AGAIN"),
              ),
            ],
          ),
        ),
      );
    }

    final trade = mockTrades[currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text("↔️ Swipe to Trade"),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushReplacementNamed(context, '/camera'),
            icon: Icon(Icons.refresh),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "I have: $partIHave",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green[800]),
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: 280,
                        decoration: BoxDecoration(
                          color: trade['color'],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(trade['avatar']),
                              radius: 40,
                            ),
                            SizedBox(height: 16),
                            Text(
                              "${trade['name']} has:",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            Text(
                              trade['has'],
                              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green[700]),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Wants: ${trade['wants']}",
                              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "📍 ${trade['distance']}",
                              style: TextStyle(fontSize: 14, color: Colors.green[600]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _swipeLeft,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        foregroundColor: Colors.grey[800],
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(24),
                      ),
                      icon: Icon(Icons.close, size: 30),
                      label: Text(""),
                    ),
                    ElevatedButton.icon(
                      onPressed: _swipeRight,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[500],
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(24),
                      ),
                      icon: Icon(Icons.favorite, size: 30, color: Colors.white),
                      label: Text(""),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ========= INBOX SCREEN =========
class InboxScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final matches = MockData.getInboxMatches();

    return Scaffold(
      appBar: AppBar(title: Text("📬 Inbox")),
      body: matches.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.mail_outline, size: 80, color: Colors.grey[400]),
            SizedBox(height: 20),
            Text("No matches yet", style: TextStyle(fontSize: 18, color: Colors.grey[600])),
            SizedBox(height: 10),
            Text("Start swiping to find trades!", style: TextStyle(color: Colors.grey[500])),
          ],
        ),
      )
          : ListView.builder(
        itemCount: matches.length,
        padding: EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final match = matches[index];
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: Stack(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(match['avatar']),
                    radius: 24,
                  ),
                  if (match['unread'])
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
              title: Text(match['name'], style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(match['lastMessage'], maxLines: 1, overflow: TextOverflow.ellipsis),
                  SizedBox(height: 4),
                  Text(
                    "You: ${match['partIHave']} ↔ Them: ${match['partTheyHave']}",
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(match['time'], style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                  SizedBox(height: 8),
                  Icon(Icons.chevron_right, color: Colors.grey[400]),
                ],
              ),
              onTap: () {
                Navigator.pushNamed(context, '/chat', arguments: match);
              },
            ),
          );
        },
      ),
    );
  }
}

// ========= CHAT SCREEN =========
class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Map<String, dynamic> match = {
    "name": "Unknown",
    "avatar": "https://via.placeholder.com/50",
    "id": "0"
  }; // 👈 FIXED: NO LATE, SAFE DEFAULT
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> _messages = []; // 👈 FIXED: NO LATE, SAFE DEFAULT

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
      if (args != null) {
        setState(() {
          match = args;
          _messages = List.from(MockData.getChatMessages(match['id']));
        });
      }
    });
  }

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;
    setState(() {
      _messages.add({
        "text": _controller.text.trim(),
        "isUser": true,
        "time": _formatTime(DateTime.now()),
      });
      _controller.clear();
    });
  }

  String _formatTime(DateTime time) {
    return "${time.hour}:${time.minute.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(match['avatar']),
              radius: 16,
            ),
            SizedBox(width: 10),
            Text(match['name']),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Trade marked as complete!")),
              );
            },
            icon: Icon(Icons.check_circle_outline),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return Align(
                  alignment: message['isUser'] ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
                    margin: EdgeInsets.symmetric(vertical: 8),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: message['isUser'] ? Colors.green[100] : Colors.grey[200],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: message['isUser'] ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                      children: [
                        Text(
                          message['text'],
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 4),
                        Text(
                          message['time'],
                          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Divider(height: 1, color: Colors.grey[300]),
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    onSubmitted: (value) => _sendMessage(),
                  ),
                ),
                SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: _sendMessage,
                  child: Icon(Icons.send, size: 18),
                  backgroundColor: Colors.green[700],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ========= SUCCESS SCREEN =========
class SuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.green[100]!, Colors.white],
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
                  Icon(Icons.eco, size: 120, color: Colors.green[700]),
                  SizedBox(height: 30),
                  Text(
                    "SWAP SUCCESSFUL! 🎉",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.green[800]),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "You just saved a part from the landfill.\nMeet up safely. Trade. Repeat.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.grey[700], height: 1.5),
                  ),
                  SizedBox(height: 50),
                  ElevatedButton.icon(
                    onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false),
                    icon: Icon(Icons.refresh),
                    label: Text("SWAP AGAIN ♻️"),
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