import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Importe o pacote intl

class TransactionForm extends StatefulWidget {
  // A função onSubmit é passada como parâmetro no construtor da classe
  final void Function(String, double, DateTime) onSubmit;

  const TransactionForm(this.onSubmit, {super.key});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  // Controladores para os campos de texto
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();

  // A data selecionada, inicializada com a data atual
  DateTime _selectedDate =
      DateTime.now(); // _selectedDate é um DateTime não nulo

  // Função para submeter o formulário
  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    // Verifica se os campos estão preenchidos corretamente
    if (title.isEmpty || value <= 0) {
      return;
    }

    // Chama a função onSubmit passada pelo widget pai
    widget.onSubmit(title, value, _selectedDate);
  }

  // Função para mostrar o seletor de data
  _showDatePicker() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate:
          DateTime.now().subtract(const Duration(days: 365)), // um ano atrás
      lastDate: DateTime.now(),
    );

    if (pickedDate == null) {
      return;
    }

    // Atualiza a data selecionada
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(
          255, 94, 94, 94), // Define a cor de fundo do Card
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _titleController,
              onSubmitted: (_) => _submitForm(),
              decoration: const InputDecoration(
                labelText: 'Titulo',
                labelStyle:
                    TextStyle(color: Colors.white), // Alterado para branco
              ),
            ),
            TextField(
              controller: _valueController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _submitForm(),
              decoration: const InputDecoration(
                labelText: 'Valor (R\$)',
                labelStyle:
                    TextStyle(color: Colors.white), // Alterado para branco
              ),
            ),
            SizedBox(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'Data Selecionada: ${DateFormat('dd/MM/y').format(_selectedDate)}',
                      style: const TextStyle(
                          color: Color.fromARGB(
                              255, 123, 255, 123)), // Define a cor do texto
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: const Color.fromARGB(
                          255, 123, 255, 132), // Define a cor do botão
                    ),
                    onPressed: _showDatePicker,
                    child: const Text(
                      'Selecionar Data',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor:
                        Theme.of(context).textTheme.labelLarge!.color,
                    backgroundColor: const Color.fromARGB(255, 96, 161, 203),
                  ),
                  onPressed: _submitForm,
                  child: const Text('Nova Transação'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
