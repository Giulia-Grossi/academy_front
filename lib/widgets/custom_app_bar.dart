import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String nome;
  final String matricula;
  final bool showBack;
  final bool showLogout;
  final VoidCallback? onLogout;
  final VoidCallback? onBack;
  final VoidCallback? onNotifications;
  final VoidCallback? onSettings;
  final Color backgroundColor;
  final double height;

  const CustomAppBar({
    super.key,
    required this.nome,
    required this.matricula,
    this.showBack = true,
    this.onBack,
    this.onNotifications,
    this.onSettings,
    this.backgroundColor = Colors.teal,
    this.height = 90.0,
    this.showLogout = false,
    this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(25)),
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            if (showBack)
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: onBack ?? () => Navigator.of(context).pop(),
              ),
            if (!showBack)
              const SizedBox(width: 8), // keep spacing consistent

            const CircleAvatar(
              radius: 20,
              // backgroundImage: AssetImage("assets/images/profile.jpg"),
              backgroundColor: Colors.white24,
              child: Icon(Icons.person, color: Colors.white),
            ),
            const SizedBox(width: 12),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nome,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    matricula,
                    style: const TextStyle(fontSize: 13, color: Colors.white70),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            IconButton(
              onPressed: onNotifications,
              icon: const Icon(Icons.notifications_none, color: Colors.white),
            ),
            IconButton(
              onPressed: onSettings,
              icon: const Icon(Icons.settings, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
