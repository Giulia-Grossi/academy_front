import 'package:flutter/material.dart';
import 'package:academy_front/widgets/custom_app_bar.dart';

class PresencaPage extends StatefulWidget {
  const PresencaPage({Key? key}) : super(key: key);

  @override
  State<PresencaPage> createState() => _PresencaPageState();
}

class _PresencaPageState extends State<PresencaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          CustomAppBar(nome: "Nome do Aluno", matricula: "Matrícula 123456"),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                _buildPresencaCard(
                  materia: 'Matemática',
                aulasAssistidas: 34,
                totalAulas: 40,
              ),
              _buildPresencaCard(
                materia: 'Português',
                aulasAssistidas: 37,
                totalAulas: 40,
              ),
              _buildPresencaCard(
                materia: 'Inglês',
                aulasAssistidas: 30,
                totalAulas: 40,
              ),
            ],
          ),
          )
        ],
      ),
    );
  }

  Widget _buildPresencaCard({
    required String materia,
    required int aulasAssistidas,
    required int totalAulas,
  }) {
    final double percentual = totalAulas > 0 ? (aulasAssistidas / totalAulas) * 100 : 0.0;
    return Card(
      margin: const EdgeInsets.only(bottom: 12.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.teal,
                  child: Icon(Icons.book, size: 30, color: Colors.white)),
                const SizedBox(width: 12),
                Text(
                  materia,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: percentual / 100,
              minHeight: 8,
            ),
            const SizedBox(height: 8),
            Text(
              '${percentual.toStringAsFixed(1)}%',
              style: const TextStyle(fontSize: 20, 
              fontWeight: FontWeight.bold),
            ),
            Text('$aulasAssistidas/$totalAulas aulas', 
            style: const TextStyle(fontSize: 14)
            ),
          ],
        ),
      ),
    );
  }
}