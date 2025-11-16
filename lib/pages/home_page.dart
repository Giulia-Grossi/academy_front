import 'package:academy_front/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'disciplinas_page.dart';
import 'calendario_page.dart';
import 'presenca_page.dart';
import 'notas_page.dart';
import 'historico_page.dart';

class HomePage extends StatelessWidget {
  final String nome;
  final String matricula;

  const HomePage({
    super.key,
    required this.nome,
    required this.matricula,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      bottomNavigationBar: _bottomNavBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomAppBar(nome: nome, matricula: matricula),
              _banner(),
              _activitiesSection(context),
              _scheduleSection(),
              _infoSection(),
            ],
          ),
        ),
      ),
    );
  }

  // =====================================================
  // BANNER
  // =====================================================
  Widget _banner() {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        //child: Image.asset(
        //"assets/images/campus.jpg",
        //height: 160,
        //width: double.infinity,
        //fit: BoxFit.cover,
        //),
      ),
    );
  }

  // =====================================================
  // ATIVIDADES (KHS, KRS, E-learning etc…)
  // =====================================================
  Widget _activitiesSection(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {
        "icon": Icons.event_note,
        "label": "Calendário",
        "onPressed": () {
          Navigator.push(// Navegação para a página de disciplinas
            context,
            MaterialPageRoute(builder: (context) => CalendarioPage ())
            );
        },
      },
      {
        "icon": Icons.check_circle,
        "label": "Presença",
        "onPressed": () {
          Navigator.push(// Navegação para a página de disciplinas
            context,
            MaterialPageRoute(builder: (context) => PresencaPage()),
          );
        },
      },
      {
        "icon": Icons.star,
        "label": "Notas",
        "onPressed": () {
          Navigator.push(// Navegação para a página de disciplinas
            context,
            MaterialPageRoute(builder: (context) => NotasPage()),
          );
        },
      },
      {
        "icon": Icons.book,
        "label": "Disciplinas",
        "onPressed": () {
          Navigator.push(// Navegação para a página de disciplinas
            context,
            MaterialPageRoute(builder: (context) => DisciplinasPage()),
          );
        },
      },
      {
        "icon": Icons.computer,
        "label": "Histórico",
        "onPressed": () {
          Navigator.push(// Navegação para a página de disciplinas
            context,
            MaterialPageRoute(builder: (context) => HistoricoPage()),
          );
        },
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // título
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Atividades",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // Ícones
        SizedBox(
          height: 95,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(width: 15),
            itemBuilder: (_, i) {
              return Column(
                children: [
                  IconButton.filled(
                    //radius: 28,
                    color: Colors.teal.withValues(alpha: 0.5),
                    hoverColor: Colors.teal.withValues(alpha: 0.9),
                    icon: Icon(items[i]["icon"], color: Colors.grey[100], size: 30),
                    onPressed: items[i]["onPressed"],
                  ),
                  const SizedBox(height: 6),
                  Text(items[i]["label"], style: const TextStyle(fontSize: 13)),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  // =====================================================
  // AGENDA DO DIA
  // =====================================================
  Widget _scheduleSection() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Agenda de hoje",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),

          // Card da aula
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                )
                ],
              ),
              child: Row(
                children: [
                // Horários
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("09:40",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    Text("12:10",
                        style: TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
                const SizedBox(width: 20),

                // Linha vertical
                Container(width: 2, height: 45, color: Colors.teal),

                const SizedBox(width: 20),

                // Conteúdo
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Rekayasa Web Praktik",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      SizedBox(height: 4),
                      Text("Lab komputer 3A",
                          style: TextStyle(fontSize: 13, color: Colors.grey)),
                    ],
                  ),
                ),

                const Icon(Icons.arrow_forward_ios,
                    size: 16, color: Colors.grey),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =====================================================
  // INFORMAÇÕES IMPORTANTES
  // =====================================================
  Widget _infoSection() {
    final List<Map<String, String>> news = [
      {
        "title": "Alunos UTY criam startup de sucesso!",
        "body": "Mesmo em pandemia muitos alunos desenvolveram soluções de impacto..."
      },
      // Adicione mais itens aqui conforme necessário
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("Informações para você",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),

          // Lista de cards (shrinkWrap + NeverScrollable para permitir o scroll da página pai)
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: news.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (_, i) {
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                elevation: 3,
                shadowColor: Colors.black12,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        news[i]["title"]!,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        news[i]["body"]!,
                        style:
                            const TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 100),
        ],
      ),
    );
  }

  // =====================================================
  // BOTTOM NAVIGATION
  // =====================================================
  Widget _bottomNavBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -3)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          Icon(Icons.home, size: 30, color: Colors.teal),
          Icon(Icons.qr_code_scanner, size: 30, color: Colors.grey),
          Icon(Icons.list_alt, size: 30, color: Colors.grey),
        ],
      ),
    );
  }
}

