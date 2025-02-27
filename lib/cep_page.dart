import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CepPage extends StatefulWidget {
  const CepPage({super.key});

  @override
  State<CepPage> createState() => _CepPageState();
}

class _CepPageState extends State<CepPage> {
  String cep = "";
  String rua = "";
  String bairro = "";
  String cidade = "";
  //criamos uma string para cada aba que queremos e vamos passar os valores recebidos
  Future<void> obterendereco() async {
    //programação assincrona
    final response = await Dio().get('https://viacep.com.br/ws/$cep/json/'); //para mudar o cep colocamos o $ com a variavel string cep
    print(response.data["logradouro"]);
    print(response.data["bairro"]);
    print(response.data["localidade"]);
    //adiciona o .data ao responde para ter um print diferente do campo que queremos ex:print(response.data["lagradouro"])

    setState(() {
      rua = response.data["logradouro"];
      bairro = response.data["bairro"];
      cidade = response.data["localidade"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        title: Text(
          "Api CEP test",
          style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 100),
        child: Column(
          children: [
            TextFormField(
              onChanged: (valor) {
                //onchange é para mudar o valor digitado
                setState(() {
                  cep = valor;
                });
              },
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
                label: Text("CEP"),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 193, 170, 255),
              ),
              onPressed: obterendereco,
              child: Text("Consultar", style: TextStyle(color: Colors.black)),
            ),
            SizedBox(height: 20),
            Text("CEP:"),
            Text(cep),
            Text("Rua:"),
            Text(rua),
            Text("Bairro:"),
            Text(bairro),
            Text("Cidade:"),
            Text(cidade),
          ],
        ),
      ),
    );
  }
}
