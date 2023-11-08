import 'package:expenses/pages/home_page.dart';
import 'package:flutter/material.dart';

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Retorna um widget MaterialApp que é a raiz do aplicativo
    return MaterialApp(
      home: const MyHomePage(), // Define a página inicial do aplicativo
      theme: ThemeData(
        primarySwatch: Colors.purple, // Define a cor primária do tema
        colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: const Color.fromARGB(
                255, 128, 0, 0)), // Define a cor secundária do tema
        fontFamily: 'Lato', // Define a fonte padrão do tema
        textTheme: ThemeData.light().textTheme.copyWith(
                titleLarge: const TextStyle(
              fontFamily: 'Lato',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            )),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        appBarTheme: AppBarTheme(
          toolbarTextStyle: ThemeData.light().textTheme.titleLarge!.copyWith(
                fontFamily: 'Lato',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }
}
