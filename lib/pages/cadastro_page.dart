import 'package:flutter/material.dart';

enum CadastroSubPage { select, aluno, professor }

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  CadastroSubPage page = CadastroSubPage.select;

  // controllers (reutilizados para as duas formas)
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

  void _go(CadastroSubPage p) => setState(() => page = p);

  void _limparCampos() {
    nomeCtrl.clear();
    emailCtrl.clear();
    cpfCtrl.clear();
    senhaCtrl.clear();
  }

  Future<void> _cadastrarAluno() async {
    if (nomeCtrl.text.trim().isEmpty || senhaCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Preencha nome e senha')));
      return;
    }

    setState(() => isLoading = true);
    await Future.delayed(const Duration(milliseconds: 700)); // mock
    setState(() => isLoading = false);

    // TODO: enviar dados para API; aqui só printamos
    debugPrint(
        'CADASTRO ALUNO: nome=${nomeCtrl.text}, email=${emailCtrl.text}, cpf=${cpfCtrl.text}');
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cadastro de aluno realizado (mock)')));
    Navigator.pop(context); // volta para login
  }

  Future<void> _cadastrarProfessor() async {
    if (nomeCtrl.text.trim().isEmpty || senhaCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Preencha nome e senha')));
      return;
    }

    setState(() => isLoading = true);
    await Future.delayed(const Duration(milliseconds: 700)); // mock
    setState(() => isLoading = false);

    debugPrint(
        'CADASTRO PROFESSOR: nome=${nomeCtrl.text}, email=${emailCtrl.text}, cpf=${cpfCtrl.text}');
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Cadastro de professor realizado (mock)')));
    Navigator.pop(context); // volta para login
  }

  Widget _backButton() {
    return Align(
      alignment: Alignment.centerLeft,
      child: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.teal),
        onPressed: () {
          if (page == CadastroSubPage.select) {
            Navigator.pop(context);
          } else {
            _go(CadastroSubPage.select);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final maxWidth = 600.0;
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
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 240),
              child: _buildBody(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    switch (page) {
      case CadastroSubPage.select:
        return _selectView();
      case CadastroSubPage.aluno:
        return _alunoView();
      case CadastroSubPage.professor:
        return _professorView();
    }
  }

  Widget _selectView() {
    return Column(
      key: const ValueKey('select'),
      children: [
        const SizedBox(height: 8),
        const Text('Selecione o tipo de cadastro',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 24),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              minimumSize: const Size.fromHeight(50)),
          onPressed: () {
            _limparCampos();
            _go(CadastroSubPage.aluno);
          },
          child: const Text('Sou Aluno'),
        ),
        const SizedBox(height: 12),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              minimumSize: const Size.fromHeight(50)),
          onPressed: () {
            _limparCampos();
            _go(CadastroSubPage.professor);
          },
          child: const Text('Sou Professor'),
        ),
        const SizedBox(height: 18),
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Voltar')),
      ],
    );
  }

  Widget _alunoView() {
    return Column(
      key: const ValueKey('aluno'),
      children: [
        _backButton(),
        const SizedBox(height: 6),
        const Text('Cadastro de Aluno',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        TextField(
            controller: nomeCtrl,
            decoration: const InputDecoration(labelText: 'Nome completo')),
        const SizedBox(height: 8),
        TextField(
            controller: emailCtrl,
            decoration: const InputDecoration(labelText: 'Email')),
        const SizedBox(height: 8),
        TextField(
            controller: cpfCtrl,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'CPF')),
        const SizedBox(height: 8),
        TextField(
            controller: senhaCtrl,
            obscureText: true,
            decoration: const InputDecoration(labelText: 'Senha')),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: isLoading ? null : _cadastrarAluno,
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: const EdgeInsets.symmetric(vertical: 14)),
            child: isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text('Cadastrar'),
          ),
        ),
      ],
    );
  }

  Widget _professorView() {
    return Column(
      key: const ValueKey('prof'),
      children: [
        _backButton(),
        const SizedBox(height: 6),
        const Text('Cadastro de Professor',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        TextField(
            controller: nomeCtrl,
            decoration: const InputDecoration(labelText: 'Nome completo')),
        const SizedBox(height: 8),
        TextField(
            controller: emailCtrl,
            keyboardType: TextInputType.emailAddress,
            decoration:
                const InputDecoration(labelText: 'Email institucional')),
        const SizedBox(height: 8),
        TextField(
            controller: cpfCtrl,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'CPF')),
        const SizedBox(height: 8),
        TextField(
            controller: senhaCtrl,
            obscureText: true,
            decoration: const InputDecoration(labelText: 'Senha')),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: isLoading ? null : _cadastrarProfessor,
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: const EdgeInsets.symmetric(vertical: 14)),
            child: isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text('Cadastrar'),
          ),
        ),
      ],
    );
  }
}
