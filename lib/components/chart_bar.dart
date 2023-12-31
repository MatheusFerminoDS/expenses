import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {

  final String label;
  final double value;
  final double percentage;

  ChartBar({
    required this.label,
    required this.value,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 20,
          child: FittedBox(
            child: Text('${value.toStringAsFixed(2)}', style: TextStyle(color: Color.fromARGB(255, 165, 165, 165))), // Define a cor do texto
          ),
        ),
        SizedBox(height: 5),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color.fromARGB(255, 128, 43, 43), // Define a cor da borda
                    width: 1.0,
                  ),
                  color: Color.fromARGB(255, 139, 139, 139), // Define a cor de fundo
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [ // Adiciona sombras para criar o efeito neomorfismo
                    BoxShadow(
                      color: Color.fromARGB(255, 255, 241, 241).withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(-3, -3),
                    ),
                    BoxShadow(
                      color: Color.fromARGB(255, 189, 189, 189).withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(3, 3),
                    ),
                  ],
                ),
              ),
              FractionallySizedBox(
                heightFactor: percentage,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 87, 145, 172), // Define a cor do gráfico
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 5),
        Text(label, style: TextStyle(color: const Color.fromARGB(255, 221, 17, 17))), // Define a cor do texto
      ],
    );
  }
}
