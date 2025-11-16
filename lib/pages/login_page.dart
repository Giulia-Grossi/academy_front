//lib\pages\login_page.dart
import 'package:academy_front/pages/cadastro_page.dart';
import 'package:academy_front/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService authService = AuthService();

  bool isLoading = false;

  Future<void> _login() async {
    final user = userController.text.trim();
    final pass = passwordController.text;

    if (user.isEmpty || pass.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Preencha todos os campos")),
      );
      return;
    }

    final success = await AuthService.login(user, pass);

    if (!success) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Credenciais inválidas")),
      );
      return;
    }

    setState(() => isLoading = false);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => HomePage(
          nome: "Aluno",
          matricula: user,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final maxWidth = 520.0;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: Column(
              children: [
                const Icon(Icons.school, size: 96, color: Colors.teal),
                const SizedBox(height: 20),
                const Text(
                  "SISTEMA INFORMACIONAL ACADÊMICO",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.teal,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                TextField(
                  controller: userController,
                  decoration:
                      _input("RA / Matrícula / CPF / Email", Icons.person),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: _input("Senha", Icons.lock),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Entrar",
                            style: TextStyle(color: Colors.white)),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Recuperação de senha ainda não implementada'),
                          ),
                        );
                      },
                      child: const Text('Esqueci a senha',
                          style: TextStyle(color: Colors.teal)),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const CadastroPage()),
                        );
                      },
                      child: const Text('Criar conta',
                          style: TextStyle(color: Colors.teal)),
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

  InputDecoration _input(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
