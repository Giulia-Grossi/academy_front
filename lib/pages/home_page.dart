import 'package:flutter/material.dart';

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
              _header(),
              _banner(),
              _activitiesSection(),
              _scheduleSection(),
              _infoSection(),
            ],
          ),
        ),
      ),
    );
  }

  // =====================================================
  // HEADER
  // =====================================================
  Widget _header() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 25,
            //backgroundImage: AssetImage("assets/images/profile.jpg"),
          ),
          const SizedBox(width: 12),

          // Nome + matrícula
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nome,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  matricula,
                  style: const TextStyle(fontSize: 14, color: Colors.white70),
                ),
              ],
            ),
          ),

          // Icons
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none, color: Colors.white),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings, color: Colors.white),
          ),
        ],
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
  Widget _activitiesSection() {
    final List<Map<String, dynamic>> items = [
      {"icon": Icons.event_note, "label": "Jadwal"},
      {"icon": Icons.check_circle, "label": "Presensi"},
      {"icon": Icons.folder_copy, "label": "KHS"},
      {"icon": Icons.library_books, "label": "KRS"},
      {"icon": Icons.computer, "label": "E-learning"},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // título
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text("Atividades",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              Text("Ver tudo", style: TextStyle(color: Colors.teal)),
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
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.teal.withOpacity(.15),
                    child: Icon(items[i]["icon"], color: Colors.teal, size: 30),
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
                  color: Colors.black.withOpacity(.05),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Informações para você",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            elevation: 3,
            shadowColor: Colors.black12,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: const [
                  Text(
                    "Alunos UTY criam startup de sucesso!",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Mesmo em pandemia muitos alunos desenvolveram soluções de impacto...",
                    style: TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                ],
              ),
            ),
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
              color: Colors.black.withOpacity(.05),
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
