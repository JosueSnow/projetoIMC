import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(Calculadora());
}

class Calculadora extends StatelessWidget {
  const Calculadora({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora IMC para Adultos',
      theme: ThemeData(
        colorSchemeSeed:
          Colors.deepPurple,
          useMaterial3: true,
      ),
      home: const CalcImc(),
    );
  }
}

class CalcImc extends StatefulWidget {
  const CalcImc({super.key});

  @override
  State<CalcImc> createState() => _CalcImcState();
}

class _CalcImcState extends State<CalcImc> {
  String? generoSelecionado;
  double altura = 0.0;
  double peso = 0.0;
  double imc = 0.0;

  final List<String> generos =
  [
    'Masculino',
    'Feminino'
  ];

  void _submitForm(){
    if(generoSelecionado == null){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, selecione um gênero.'))
        );
    } else if ( altura == 0.0){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, digite uma altura.'))
        );
    } else if ( peso == 0.0){
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, digite um peso.'))
        );
    } else  {

      imc = peso + (altura * altura);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Resultado do IMC"),
          content: Text('Seu IMC é: $imc'),
          actions: [
            TextButton(
              onPressed: Navigator.of(context).pop,
              child: const Text("OK"),
            )
          ],
        ),
      );      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/bg-afrodigital-projeto-imc.jpg', fit: BoxFit.cover),
          const DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.black45,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Selecioneu seu Gênero:',
                  style: TextStyle(color: Colors.white, fontSize: 26),
                  textAlign: TextAlign.center),
                SizedBox(height: 20),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: generos.map((sexo) {
                        return RadioListTile<String>(
                          title: Text(sexo),
                          value: sexo,
                          groupValue: generoSelecionado,
                          onChanged: (value) {
                            setState(() {
                              generoSelecionado = value;
                            });
                          },
                          activeColor: Theme.of(context).colorScheme.primary,
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        TextFormField(                                                    
                          onChanged: (value) {altura = double.tryParse(value)!;},
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly,],
                          decoration: InputDecoration( labelText: "Altura", hintText: 'Ex: 1.75', border: OutlineInputBorder() ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(                          
                          onChanged: (value) {peso = double.tryParse(value)!;},
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly,],
                          decoration: InputDecoration( labelText: "Peso", hintText: 'Ex: 75', border: OutlineInputBorder() ),
                        ),
                      ],
                    ),
                    
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: _submitForm,
                  icon: Icon(Icons.send),
                  label: Text('Enviar'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
            )

        ],
      ),
    );
  }
}