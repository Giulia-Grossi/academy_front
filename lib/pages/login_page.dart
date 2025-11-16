import 'package:flutter/material.dart';
import 'home_page.dart';
import 'cadastro_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isProfessor = false;

  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    userController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final user = userController.text.trim();
    final pass = passwordController.text;

    if (user.isEmpty || pass.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Preencha todos os campos")),
      );
      return;
    }

    setState(() => isLoading = true);

    // TODO: substituir por chamada HTTP real -> autenticação no backend
    await Future.delayed(const Duration(milliseconds: 700));

    setState(() => isLoading = false);

    // Ao navegar, sempre passe os parâmetros necessários para HomePage.
    // Para professor, nome recebe 'Professor Exemplo' e matrícula fica com id do professor.
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => HomePage(
          nome: isProfessor ? 'Professor Exemplo' : 'Aluno Exemplo',
          matricula: isProfessor ? 'PROF-000' : user, // para aluno usamos o RA/matrícula digitado
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Limitar largura em telas largas (desktop)
    final maxWidth = 520.0;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.school, size: 96, color: Colors.teal),
                const SizedBox(height: 12),
                const Text(
                  'SISTEMA INFORMACIONAL ACADÊMICO',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.teal, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 26),

                // switch aluno / professor
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ChoiceChip(
                      label: const Text('Aluno'),
                      selected: !isProfessor,
                      onSelected: (_) => setState(() => isProfessor = false),
                    ),
                    const SizedBox(width: 12),
                    ChoiceChip(
                      label: const Text('Professor'),
                      selected: isProfessor,
                      onSelected: (_) => setState(() => isProfessor = true),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // campo usuário (numérico para aluno; email para professor)
                TextField(
                  controller: userController,
                  keyboardType: isProfessor ? TextInputType.emailAddress : TextInputType.text,
                  decoration: InputDecoration(
                    hintText: isProfessor ? 'Email institucional' : 'RA / Matrícula / CPF / Email',
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),

                const SizedBox(height: 12),

                // senha
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Senha',
                    prefixIcon: const Icon(Icons.lock),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),

                const SizedBox(height: 18),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: isLoading
                        ? const SizedBox(height: 18, width: 18, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                        : const Text('Entrar', style: TextStyle(fontSize: 16,
                        color: Colors.white)),
                  ),
                ),

                const SizedBox(height: 8),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        // TODO: implementar recuperação de senha
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Recuperação de senha (não implementada)')));
                      },
                      child: const Text('Esqueci a senha', style: TextStyle(color: Colors.teal)),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const CadastroPage()),
                        );
                      },
                      child: const Text('Criar conta', style: TextStyle(color: Colors.teal)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
