import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  )
  );
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState>  _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados!";

  void _resetFields(){
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados!";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate(){
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight/(height * height);

      if(imc<17){
        _infoText = "Muito abaixo do peso (${imc.toStringAsPrecision(3)})";
      }else if((imc >= 17) && (imc <= 18.49)){
        _infoText = "Abaixo do peso (${imc.toStringAsPrecision(3)})";
      }else if((imc >= 18.5) && (imc <= 24.99)){
        _infoText = "Peso Ideal (${imc.toStringAsPrecision(3)})";
      }else if((imc >= 25) && (imc <= 29.99)){
        _infoText = "Acima do peso (${imc.toStringAsPrecision(3)})";
      }else if ((imc >= 30) && (imc <= 34.99)){
        _infoText = "Obesidade I (${imc.toStringAsPrecision(3)})";
      }else if ((imc >= 35) && (imc <= 39.99)){
        _infoText = "Obesidade II (severa) (${imc.toStringAsPrecision(3)})";
      }else{
        _infoText = "Obesidade III (mórbida) (${imc.toStringAsPrecision(3)})";
      }
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        actions: <Widget>[
         IconButton(icon: Icon(Icons.refresh,color: Colors.white,),tooltip: "Resetar dados", onPressed: _resetFields)
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person_outline, size: 120.0, color: Colors.purple),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Peso (kg)",
                    labelStyle: TextStyle(color: Colors.purple)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.purple, fontSize: 25.0),
                controller: weightController,
                validator: (value){
                  if(value.isEmpty){
                    return "Insira seu Peso";
                  }
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Altura (cm)",
                    labelStyle: TextStyle(color: Colors.purple)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.purple, fontSize: 25.0),
                controller: heightController,
                validator: (value){
                  if(value.isEmpty){
                    return "Insira sua Altura";
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  height: 50,
                  child: RaisedButton(
                    onPressed: () {
                      if(_formKey.currentState.validate()){
                        _calculate();
                      }
                    },
                    child: Text("Calcular", style: TextStyle(color: Colors.white, fontSize: 25)),
                    color: Colors.purple,
                  ),
                ),
              ),
              Text(_infoText, textAlign: TextAlign.center,style: TextStyle(color: Colors.purple, fontSize: 25),),
            ],
          ),
        ),
      ),
    );
  }
}
