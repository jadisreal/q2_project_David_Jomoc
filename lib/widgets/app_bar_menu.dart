import 'package:flutter/material.dart';
import '../core/constants.dart';

class AppBarWithDrawer extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final BuildContext context;
  final List<Widget>? actions;

  const AppBarWithDrawer({
    Key? key,
    required this.title,
    required this.context,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      leading: Builder(
        builder: (context) => IconButton(
          onPressed: () => Scaffold.of(context).openDrawer(),
          icon: const Icon(Icons.menu),
        ),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  static Drawer buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: AppConstants.secondaryColor),
            child: Text(
              'Menu',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('Snap Your Part'),
            onTap: () => Navigator.pushNamed(context, AppConstants.routeCamera),
          ),
          ListTile(
            leading: const Icon(Icons.inbox),
            title: const Text('Inbox'),
            onTap: () => Navigator.pushNamed(context, AppConstants.routeInbox),
          ),
          ListTile(
            leading: const Icon(Icons.label),
            title: const Text('Sort by Tags'),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Sorting by tags... (mock)")),
              );
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}