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
    if (nomeCtrl.text.trim().isEmpty ||
        emailCtrl.text.trim().isEmpty ||
        senhaCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos obrigatórios')),
      );
      return;
    }

    setState(() => isLoading = true);
    await Future.delayed(const Duration(milliseconds: 700)); // mock
    setState(() => isLoading = false);

    // 🔧 MOCK (futuro: conectar à API /auth/register)
    debugPrint(
      'CADASTRO ALUNO: nome=${nomeCtrl.text}, email=${emailCtrl.text}, cpf=${cpfCtrl.text}',
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Cadastro realizado! (mock)')),
    );

    Navigator.pop(context); // volta ao login
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
