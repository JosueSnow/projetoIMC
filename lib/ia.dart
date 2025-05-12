import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formulário de Gênero',
      theme: ThemeData(
        colorSchemeSeed: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: const GenderFormScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class GenderFormScreen extends StatefulWidget {
  const GenderFormScreen({Key? key}) : super(key: key);

  @override
  State<GenderFormScreen> createState() => _GenderFormScreenState();
}

class _GenderFormScreenState extends State<GenderFormScreen> {
  String? _selectedGender;

  final List<String> _genders = [
    'Masculino',
    'Feminino'    
  ];

  void _submitForm() {
    if (_selectedGender != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gênero selecionado: $_selectedGender')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, selecione um gênero.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Imagem de fundo
          Image.asset(
            'assets/images/bg-afrodigital-projeto-imc.jpg', // Substitua pelo caminho da sua imagem
            fit: BoxFit.cover,
          ),
          // Overlay escuro para melhorar contraste do texto
          const DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.black45,
            ),
          ),
          // Conteúdo centralizado
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Selecione seu gênero:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: _genders.map((gender) {
                        return RadioListTile<String>(
                          title: Text(gender),
                          value: gender,
                          groupValue: _selectedGender,
                          onChanged: (value) {
                            setState(() {
                              _selectedGender = value;
                            });
                          },
                          activeColor: Theme.of(context).colorScheme.primary,
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: _submitForm,
                  icon: const Icon(Icons.check),
                  label: const Text('Enviar'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}