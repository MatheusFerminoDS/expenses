import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove;

TransactionList(this.transactions, this.onRemove);

  @override
  Widget build(BuildContext context){
    return Container(
      height: 430,
      child: transactions.isEmpty ? Column(
        children: <Widget>[
          Text(
            'Nenhuma Transação Registrada!',
            style: TextStyle(color: Color.fromARGB(255, 252, 0, 0)), // Define a cor do texto
          ),
          SizedBox(height: 20),
          Container(
            height: 200,
            child: Image.asset(
              'assets/images/waiting.png',
            fit: BoxFit.cover,
            ),
          ),
        ],
      )
      :ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (ctx, index) {
          final tr = transactions[index];
          return Card(
            color: Color.fromARGB(255, 176, 176, 176), // Define a cor de fundo do Card
            child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Color.fromARGB(255, 39, 160, 176), // Define a cor de fundo do CircleAvatar
              radius: 30,
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: FittedBox(
                  child: Text('R\$${tr.value}', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))), // Define a cor do texto
              ),
            ),
            ),
            title: Text(
              tr.title,
              style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)), // Define a cor do texto
            ),
            subtitle: Text(
              DateFormat('d MMM y').format(tr.date),
              style: TextStyle(color: Color.fromARGB(255, 223, 250, 255)), // Define a cor do texto
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              color: Color.fromARGB(255, 255, 0, 0), // Define a cor do ícone
              onPressed: () => onRemove(tr.id),
            ),
          ),
          );
        },
      ),
    );
  }
}
