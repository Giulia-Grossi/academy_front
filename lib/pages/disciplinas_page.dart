import 'package:flutter/material.dart';
import 'package:academy_front/widgets/custom_app_bar.dart';

class DisciplinasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(nome: "Nome do Aluno", matricula: "Matrícula 123456"),
          Expanded(
            child: ListView(
              children: [
                _buildDisciplinaTile('Matemática', 'Prof. João', 'Sala 101', context),
                _buildDisciplinaTile('História', 'Prof. Maria', 'Sala 202', context),
                _buildDisciplinaTile('Biologia', 'Prof. Ana', 'Laboratório 1', context),
                // Adicione mais disciplinas conforme necessário
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDisciplinaTile(String nome, String professor, String local, BuildContext context) {
    return ListTile(
      title: Text(nome),
      subtitle: Text('Professor: $professor\n Local: $local'),
      onTap: () {
        // Navegação para a página específica da disciplina
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DisciplinaDetalhesPage(nome: nome)),
        );
      },
    );
  }
}

class DisciplinaDetalhesPage extends StatelessWidget {
  final String nome;

  DisciplinaDetalhesPage({required this.nome});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(nome),
      ),
      body: Center(
        child: Text('Detalhes da disciplina: $nome'),
      ),
    );
  }
}
