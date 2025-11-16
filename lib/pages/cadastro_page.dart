import 'package:academy_front/services/auth_service.dart';
import 'package:flutter/material.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  // Controllers
  final TextEditingController nomeCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController cpfCtrl = TextEditingController();
  final TextEditingController senhaCtrl = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    nomeCtrl.dispose();
    emailCtrl.dispose();
    cpfCtrl.dispose();
    senhaCtrl.dispose();
    super.dispose();
  }

  void _limparCampos() {
    nomeCtrl.clear();
    emailCtrl.clear();
    cpfCtrl.clear();
    senhaCtrl.clear();
  }

Future<void> _cadastrarAluno() async {
  final nome = nomeCtrl.text.trim();
  final email = emailCtrl.text.trim();
  final senha = senhaCtrl.text;

  if (nome.isEmpty || email.isEmpty || senha.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Preencha todos os campos obrigatórios')),
    );
    return;
  }

  setState(() => isLoading = true);

  final success = await AuthService.register(
    ra: DateTime.now().millisecondsSinceEpoch.toString(), // gerar RA temporário
    login: email,
    password: senha,
  );

  setState(() => isLoading = false);

  if (!success) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Falha ao cadastrar usuário')),
    );
    return;
  }

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Cadastro concluído! Faça login.')),
  );

  Navigator.pop(context);
}

  @override
  Widget build(BuildContext context) {
    const maxWidth = 600.0;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Cadastro'),
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: maxWidth),
            child: _cadastroAlunoView(),
          ),
        ),
      ),
    );
  }

  // ============================================
  // TELA ÚNICA — Cadastro de Aluno
  // ============================================
  Widget _cadastroAlunoView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Cadastro de Aluno',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 20),

        TextField(
          controller: nomeCtrl,
          decoration: const InputDecoration(labelText: 'Nome completo'),
        ),

        const SizedBox(height: 12),

        TextField(
          controller: emailCtrl,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(labelText: 'Email'),
        ),

        const SizedBox(height: 12),

        TextField(
          controller: cpfCtrl,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'CPF (opcional)'),
        ),

        const SizedBox(height: 12),

        TextField(
          controller: senhaCtrl,
          obscureText: true,
          decoration: const InputDecoration(labelText: 'Senha'),
        ),

        const SizedBox(height: 24),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: isLoading ? null : _cadastrarAluno,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            child: isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text('Cadastrar'),
          ),
        ),
      ],
    );
  }
}
