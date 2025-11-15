import 'package:academy_front/pages/login_page.dart';
import 'package:academy_front/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Academy App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          primary: Colors.teal,
          secondary: Colors.teal[300],
        ),
        scaffoldBackgroundColor: Colors.grey[100],
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.black87),
        ),
      ),
      home: const MyHomePage(title: 'Bem-vindo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool temInternet = true;

  // Função para verificar internet
  Future<void> verificarInternet() async {
    var resultado = await Connectivity().checkConnectivity();

    setState(() {
      temInternet = resultado != ConnectivityResult.none;
    });
  }

  @override
  void initState() {
    super.initState();
    verificarInternet(); // Verifica assim que a tela abre
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            temInternet
                ? const Text(
                    'Internet disponível!',
                    style: TextStyle(color: Colors.green, fontSize: 18),
                  )
                : const Text(
                    'Sem conexão à internet',
                    style: TextStyle(color: Colors.red, fontSize: 18),
                  ),
            const SizedBox(height: 20),

            // Botão que leva para outra página
            ElevatedButton(
              onPressed: () {
                // Navegar para a próxima página futuramente
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                );
              },
              child: const Text('Ir para próxima página'),
            ),
          ],
        ),
      ),
    );
  }
}

// Página futura em branco (temporária)
class PaginaFutura extends StatelessWidget {
  const PaginaFutura({super.key});

  @override
  Widget build(BuildContext context) {
return Scaffold(
  appBar: CustomAppBar(
    nome: "Nome do Usuário",
    matricula: "Matrícula 123456",
    showLogout: true,
    onLogout: () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => LoginPage()),
        (route) => false,
      );
    },
  )
);
  }
}
