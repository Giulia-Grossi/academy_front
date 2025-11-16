import 'package:flutter/material.dart';
import 'package:academy_front/widgets/custom_app_bar.dart';

class CalendarioPage extends StatefulWidget {
  @override
  State<CalendarioPage> createState() => _CalendarioPageState();
}

class _CalendarioPageState extends State<CalendarioPage> {
  late DateTime _selectedDate;
  final int _daysCount = 30;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(nome: "Nome do Aluno", matricula: "Matrícula 123456"),
          _buildMonthHeader(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: _daysCount,
              itemBuilder: (context, idx) {
                final date = _selectedDate.add(Duration(days: idx));
                final events = _eventsForDay(date);
                return _buildDaySection(date, events);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthHeader() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () {
              setState(() {
                _selectedDate = DateTime(
                  _selectedDate.year,
                  _selectedDate.month - 1,
                  _selectedDate.day,
                );
              });
            },
          ),
          Text(
            '${_selectedDate.month}/${_selectedDate.year}',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: () {
              setState(() {
                _selectedDate = DateTime(
                  _selectedDate.year,
                  _selectedDate.month + 1,
                  _selectedDate.day,
                );
              });
            },
          ),
        ],
      ),
    );
  }

  // Gera "eventos" de exemplo para o dia. Substitua por sua fonte real.
  List<int> _eventsForDay(DateTime date) {
    final d = date.day;
    final List<int> ev = [];
    if (d % 3 == 0) ev.add(0);
    if (d % 5 == 0) ev.add(1);
    // Para demonstrar mais eventos em alguns dias:
    if (d % 7 == 0) ev.add(2);
    return ev;
  }

  String _weekdayName(DateTime date) {
    const names = [
      'Domingo',
      'Segunda-feira',
      'Terça-feira',
      'Quarta-feira',
      'Quinta-feira',
      'Sexta-feira',
      'Sábado'
    ];
    return names[date.weekday % 7];
  }

  Widget _buildDaySection(DateTime date, List<int> events) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cabeçalho da seção: ícone circular com dia e título com dia da semana
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.teal,
                child: Text(
                  '${date.day}',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _weekdayName(date),
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${date.day}/${date.month}/${date.year}',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Lista de cards para este dia
          if (events.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                'Sem eventos',
                style: TextStyle(color: Colors.grey.shade500),
              ),
            )
          else
            Column(
              children: events.asMap().entries.map((entry) {
                final pos = entry.key;
                final idx = entry.value;
                final featured = pos == 0; // primeiro card do dia é levemente maior
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: _buildClassCard(idx, featured: featured),
                );
              }).toList(),
            ),

          const SizedBox(height: 4),
          Divider(color: Colors.grey.shade300),
        ],
      ),
    );
  }

  Widget _buildClassCard(int index, {bool featured = false}) {
    // Ajustes de dimensão/estilo para o card em destaque
    final cardHeight = featured ? 120.0 : 92.0;
    final titleSize = featured ? 18.0 : 16.0;
    final timeSize = featured ? 20.0 : 18.0;
    final subtitleSize = featured ? 14.0 : 13.0;
    final icon = featured ? Icons.event : null;
    final iconColor = featured ? Colors.teal : Colors.grey;

    return Card(
      elevation: featured ? 4 : 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        height: cardHeight,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            // Horários
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("09:40",
                    style: TextStyle(
                        fontSize: timeSize, fontWeight: FontWeight.bold)
                ),
                const SizedBox(height: 2),
                Icon(Icons.arrow_downward, size: 16, color: iconColor),
                const SizedBox(height: 2),
                Text("12:10",
                  style: TextStyle(fontSize: subtitleSize, 
                  color: Colors.grey)
                ),
              ],
            ),

            const SizedBox(width: 16),

            // Linha vertical
            Container(width: 2, height: 48, color: Colors.teal),

            const SizedBox(width: 16),

            // Conteúdo
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Rekayasa Web Praktik",
                    style: TextStyle(fontSize: titleSize, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 14, color: Colors.teal),
                      const SizedBox(width: 2),
                      Text(
                        "Lab komputer 3A",
                        style: TextStyle(fontSize: subtitleSize, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Icon(icon, size: 18, color: iconColor),
          ],
        ),
      ),
    );
  }
}
