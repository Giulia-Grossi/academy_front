import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBack;
  final bool showLogout;
  final VoidCallback? onLogout;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showBack = false,
    this.showLogout = false,
    this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.teal,
      elevation: 0,
      title: Text(title),
      leading: showBack
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            )
          : null,
      actions: [
        if (showLogout)
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: onLogout,
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
