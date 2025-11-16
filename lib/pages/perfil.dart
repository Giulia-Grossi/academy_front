import 'package:flutter/material.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({Key? key}) : super(key: key);

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          margin: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
              // Imagem do usuário
              CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey[300],
              child: const Icon(Icons.person, size: 50),
              ),
              const SizedBox(height: 20),
            
              // Informações pessoais
              _buildInfoField('Nome: ', 'Nome do usuário'),
              _buildInfoField('Email: ', 'email@exemplo.com'),
              _buildInfoField('RA: ', '123456'),
              _buildInfoField('Instituição: ', 'Instituição'),
              _buildInfoField('Curso: ', 'Nome do Curso'),
              _buildInfoField('Semestre: ', '1º'),
              _buildInfoField('Turno: ', 'Matutino'),
              _buildInfoField('Nota Média: ', '8.5'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
}