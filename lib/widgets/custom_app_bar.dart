import 'package:flutter/material.dart';
import 'package:academy_front/pages/perfil.dart';

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

            IconButton(
              onPressed: () {Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PerfilPage())
              );},
              icon: const CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white24,
              child: Icon(Icons.person, color: Colors.white),
              ),
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
              icon: const Icon(Icons.notifications_none, color: Colors.white),
              onPressed:(){
                showDialog(
                context: context,
                builder: (context) => const NotificacoesDialog(), 
                );
              }
            ),
            IconButton(
              icon: const Icon(Icons.settings, color: Colors.white),
              onPressed: onSettings,
            )
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class NotificacoesDialog extends StatelessWidget {
  const NotificacoesDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        width: 600,
        height: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Notificações',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: const [
                  ListTile(
                    title: Text("Você recebeu uma nova atividade."),
                    subtitle: Text("Hoje às 14:20"),
                  ),
                  ListTile(
                    title: Text("Nota atualizada em Matemática."),
                    subtitle: Text("Ontem"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

