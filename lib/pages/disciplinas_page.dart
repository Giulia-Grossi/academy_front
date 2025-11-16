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
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Container(
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          title: Text(nome),
          subtitle: Text('Professor: $professor\nLocal: $local'),
          trailing: IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DisciplinaDetalhesPage(nome: nome)),
              );
            },
          ),
        ),
      ),
    );
  }
}

class DisciplinaDetalhesPage extends StatelessWidget {
  final String nome;

  DisciplinaDetalhesPage({required this.nome});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(nome: "Nome do Aluno", matricula: "Matrícula 123456",),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              child: ListView(
                children: [
                  Card(
                    margin: EdgeInsets.all(20),
                    child:Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        nome.toUpperCase(),
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Center(
                    child: Text('Aqui estão os detalhes da disciplina $nome. \n\nConteúdo programático, avaliações, materiais e outras informações relevantes podem ser exibidas aqui.'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

