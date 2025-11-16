import 'package:flutter/material.dart';
import 'package:academy_front/widgets/custom_app_bar.dart';

class Avaliacao {
  final double nota;
  final double peso;
  final DateTime data;

  Avaliacao({
    required this.nota,
    required this.peso,
    required this.data,
  });
}

class Materia {
  final String nome;
  final List<Avaliacao> avaliacoes;

  Materia({
    required this.nome,
    required this.avaliacoes,
  });

  double get media {
    final totalPeso = avaliacoes.fold<double>(0, (s, a) => s + a.peso);
    if (totalPeso > 0) {
      final somaPonderada =
          avaliacoes.fold<double>(0, (s, a) => s + a.nota * a.peso);
      return somaPonderada / totalPeso;
    }
    // fallback: média simples
    if (avaliacoes.isEmpty) return 0;
    return avaliacoes.fold<double>(0, (s, a) => s + a.nota) /
        avaliacoes.length;
  }
}

class NotasPage extends StatelessWidget {
  NotasPage({super.key});

  final List<Materia> materias = _sampleMaterias();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(nome: "Nome do Aluno", matricula: "123456"),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(14),
              itemCount: materias.length,
              itemBuilder: (context, index) {
                final materia = materias[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ExpansionTile(
                  title: Text(materia.nome.toUpperCase(), 
                  style: const TextStyle(fontSize: 16, 
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,)
                    ),
                  subtitle: Text('Média: ${_formatDouble(materia.media)}',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                  children: materia.avaliacoes.map((a) {
                    return ListTile(
                      leading: CircleAvatar(
                        radius: 25,
                        child: Text(_formatDouble(a.nota)),
                      ),
                      title: Text('Nota: ${_formatDouble(a.nota)}'),
                      subtitle: Text('Data: ${_formatDate(a.data)}  •  Peso: ${_formatDouble(a.peso)}'),
                    );
                  }).toList(),
                ),
              );
            },
          ),
          )
        ],
      ),
    );
  }
}

/* Helpers e dados de exemplo */

String _formatDouble(double v) => v.toStringAsFixed(2);

String _formatDate(DateTime d) =>
    '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';

List<Materia> _sampleMaterias() => [
      Materia(nome: 'Matemática', avaliacoes: [
        Avaliacao(nota: 8.5, peso: 2, data: DateTime(2025, 3, 10)),
        Avaliacao(nota: 7.0, peso: 1, data: DateTime(2025, 4, 5)),
        Avaliacao(nota: 9.0, peso: 2, data: DateTime(2025, 5, 20)),
      ]),
      Materia(nome: 'História', avaliacoes: [
        Avaliacao(nota: 6.5, peso: 1, data: DateTime(2025, 2, 15)),
        Avaliacao(nota: 7.5, peso: 1.5, data: DateTime(2025, 4, 2)),
      ]),
      Materia(nome: 'Ciências', avaliacoes: [
        Avaliacao(nota: 9.0, peso: 3, data: DateTime(2025, 1, 30)),
      ]),
    ];