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
              onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsPage()),
              );
            },

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


class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sobre")),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Text(
          "Academy — plataforma acadêmica\nVersão: 1.0 (Protótipo)\n\n"
          "Desenvolvido para o projeto da disciplina.\n"
          "Dados são auto-inseridos pelo usuário.",
        ),
      ),
    );
  }
}


class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ajuda e Suporte")),
      body: const Center(
        child: Text("Suporte do Academy ainda indisponível."),
      ),
    );
  }
}

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Privacidade e Segurança")),
      body: const Center(
        child: Text("Privacidade ainda não implementada."),
      ),
    );
  }
}


class AppearancePage extends StatelessWidget {
  const AppearancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Aparência")),
      body: const Center(child: Text("Opções de tema, cores, etc.")),
    );
  }
}


class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Conta"),
      ),
      body: const Center(
        child: Text("Configurações de conta (Protótipo)"),
      ),
    );
  }
}


class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Configurações"),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),

      body: ListView(
        children: [
          _searchField(),

          const SizedBox(height: 10),

          _settingsTile(
            icon: Icons.person_outline,
            text: "Conta",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AccountPage()),
              );
            },
          ),

          _settingsTile(
            icon: Icons.notifications_none,
            text: "Notificações",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsPage()),
              );
            },
          ),

          _settingsTile(
            icon: Icons.remove_red_eye_outlined,
            text: "Aparência",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AppearancePage()),
              );
            },
          ),

          _settingsTile(
            icon: Icons.lock_outline,
            text: "Privacidade e Segurança",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PrivacyPage()),
              );
            },
          ),

          _settingsTile(
            icon: Icons.help_outline,
            text: "Ajuda e Suporte",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HelpPage()),
              );
            },
          ),

          _settingsTile(
            icon: Icons.info_outline,
            text: "Sobre",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AboutPage()),
              );
            },
          ),
        ],
      ),
    );
  }

  // Barra de busca
  Widget _searchField() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Procurar uma configuração...",
          prefixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  // Item da lista
  Widget _settingsTile({required IconData icon, required String text, required VoidCallback onTap}) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, size: 26, color: Colors.black87),
          title: Text(text, style: const TextStyle(fontSize: 16)),
          trailing: const Icon(Icons.arrow_forward_ios, size: 18),
          onTap: onTap,
          tileColor: Colors.white,
        ),
        const Divider(height: 1),
      ],
    );
  }
}