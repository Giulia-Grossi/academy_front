import 'package:academy_front/pages/login_page.dart';
import 'package:flutter/material.dart';

//
// ======================================================================
//                           CUSTOM APP BAR
// ======================================================================
//

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

            if (!showBack) const SizedBox(width: 8),

            // Ícone do perfil
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AccountPage()),
                );
              },
              icon: const CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white24,
                child: Icon(Icons.person, color: Colors.white),
              ),
            ),

            const SizedBox(width: 12),

            // Nome + matrícula
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

            // Notificações
            IconButton(
              icon: const Icon(Icons.notifications_none, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const NotificationsPage()),
                );
              },
            ),

            // Configurações
            IconButton(
              icon: const Icon(Icons.settings, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SettingsPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

//
// ======================================================================
//                           NOTIFICAÇÕES
// ======================================================================
//

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  bool atividades = true;
  bool notas = true;
  bool eventos = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notificações")),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text("Atividades e Tarefas"),
            value: atividades,
            onChanged: (v) => setState(() => atividades = v),
          ),
          SwitchListTile(
            title: const Text("Atualizações de Notas"),
            value: notas,
            onChanged: (v) => setState(() => notas = v),
          ),
          SwitchListTile(
            title: const Text("Eventos Acadêmicos"),
            value: eventos,
            onChanged: (v) => setState(() => eventos = v),
          ),
        ],
      ),
    );
  }
}

//
// ======================================================================
//                           APARÊNCIA
// ======================================================================
//

class AppearancePage extends StatefulWidget {
  const AppearancePage({super.key});

  @override
  State<AppearancePage> createState() => _AppearancePageState();
}

class _AppearancePageState extends State<AppearancePage> {
  String tema = "Claro";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Aparência")),
      body: ListView(
        children: [
          RadioListTile(
            title: const Text("Tema Claro"),
            value: "Claro",
            groupValue: tema,
            onChanged: (v) => setState(() => tema = v!),
          ),
          RadioListTile(
            title: const Text("Tema Escuro"),
            value: "Escuro",
            groupValue: tema,
            onChanged: (v) => setState(() => tema = v!),
          ),
        ],
      ),
    );
  }
}

//
// ======================================================================
//                       PRIVACIDADE E SEGURANÇA
// ======================================================================
//

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Privacidade e Segurança")),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text("Alterar Senha"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 18),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Não implementado no protótipo.")),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete_outline),
            title: const Text("Excluir Conta"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 18),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Não implementado no protótipo.")),
              );
            },
          ),
        ],
      ),
    );
  }
}

//
// ======================================================================
//                         AJUDA E SUPORTE
// ======================================================================
//

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ajuda e Suporte")),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            "O suporte do Academy estará disponível futuramente.\n\n"
            "Por enquanto, utilize o FAQ ou procure seu professor.",
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

//
// ======================================================================
//                                SOBRE
// ======================================================================
//

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sobre o Academy")),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Text(
          "Academy — Plataforma Acadêmica\n"
          "Versão 1.0 (Protótipo)\n\n"
          "Criado como projeto acadêmico.\n"
          "Os dados são inseridos pelo próprio usuário.\n\n"
          "Versões futuras incluirão coleta automática de dados e integração "
          "com instituições de ensino.",
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

//
// ======================================================================
//                             MINHA CONTA
// ======================================================================
//

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final TextEditingController nomeCtrl =
      TextEditingController(text: "Aluno Exemplo");
  final TextEditingController emailCtrl =
      TextEditingController(text: "aluno@email.com");
  final TextEditingController cpfCtrl =
      TextEditingController(text: "000.000.000-00");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Minha Conta")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _field("Nome", nomeCtrl),
          _field("Email", emailCtrl),
          _field("CPF", cpfCtrl),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Alterações salvas (protótipo)")),
              );
            },
            child: const Text("Salvar"),
          ),
          const SizedBox(height: 40),
          const Divider(),
          TextButton.icon(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
              );
            },
            icon: const Icon(Icons.logout, color: Colors.red),
            label: const Text("Sair da Conta",
                style: TextStyle(color: Colors.red)),
          )
        ],
      ),
    );
  }

  Widget _field(String label, TextEditingController ctrl) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: ctrl,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}

//
// ======================================================================
//                           CONFIGURAÇÕES
// ======================================================================
//

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
          _settingsTile(
            icon: Icons.person_outline,
            text: "Conta",
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AccountPage()),
            ),
          ),
          _settingsTile(
            icon: Icons.notifications_none,
            text: "Notificações",
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const NotificationsPage()),
            ),
          ),
          _settingsTile(
            icon: Icons.remove_red_eye_outlined,
            text: "Aparência",
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AppearancePage()),
            ),
          ),
          _settingsTile(
            icon: Icons.lock_outline,
            text: "Privacidade e Segurança",
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const PrivacyPage()),
            ),
          ),
          _settingsTile(
            icon: Icons.help_outline,
            text: "Ajuda e Suporte",
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const HelpPage()),
            ),
          ),
          _settingsTile(
            icon: Icons.info_outline,
            text: "Sobre",
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AboutPage()),
            ),
          ),
        ],
      ),
    );
  }

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

  Widget _settingsTile({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, size: 26, color: Colors.black87),
          title: Text(text, style: const TextStyle(fontSize: 16)),
          trailing: const Icon(Icons.arrow_forward_ios, size: 18),
          tileColor: Colors.white,
          onTap: onTap,
        ),
        const Divider(height: 1),
      ],
    );
  }
}
