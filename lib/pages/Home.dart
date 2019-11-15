import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:falamais/bloc/result_bloc.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _controllerOrigem = TextEditingController();
  final _controllerDestino = TextEditingController();
  final _controllerTempo = TextEditingController();

  final _resBloc = BlocProvider.getBloc<ResultBloc>();

  String planoSelecionado = '30';

  dynamic _texto = 'Informe os dados';
  double result = 0;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ListTile _buildPlanTile() {
    const _planos = <String>[
      '30',
      '60',
      '120',
    ];

    final List<DropdownMenuItem<String>> _dropDownMenuPlanos = _planos
        .map((value) => DropdownMenuItem<String>(
              value: value,
              child: Text('FalaMais: $value'),
            ))
        .toList();

    return ListTile(
      title: Text('Plano'),
      trailing: DropdownButton<String>(
        value: planoSelecionado,
        onChanged: (novoValor) {
          setState(() {
            planoSelecionado = novoValor;
          });
        },
        items: _dropDownMenuPlanos,
      ),
    );
  }

  TextFormField _buildTextField(
      String label, TextEditingController controller) {
    //print(controller.text);
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      style: TextStyle(fontSize: 20),
      controller: controller,
      validator: (value) {
        if (value.isEmpty) return 'Parametro obrigatorio';
      },
    );
  }

  void _calcRes() {
    double origem = double.parse(_controllerOrigem.text);
    double destino = double.parse(_controllerDestino.text);
    int tempo = int.parse(_controllerTempo.text);

    int plano = int.parse(planoSelecionado);

    _resBloc.calcRes(origem, destino, tempo, plano);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fala Mais"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(16),
          child: ListView(children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(height: 16),
                _buildTextField('DDD Origem', this._controllerOrigem),
                SizedBox(height: 16),
                _buildTextField('DDD Destino', this._controllerDestino),
                SizedBox(height: 16),
                _buildTextField('Tempo', this._controllerTempo),
                SizedBox(height: 16),
                _buildPlanTile(),
                SizedBox(height: 16),
                FlatButton(
                    child: Text(
                      'Calcular',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    textTheme: ButtonTextTheme.primary,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _calcRes();
                      }
                    }),
                StreamBuilder(
                  stream: _resBloc.outRes,
                  initialData: 0,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return Container(
                      child: Text(
                        'Total R\$ ${snapshot.data.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 25),
                      ),
                    );
                  },
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
