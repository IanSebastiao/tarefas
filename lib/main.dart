import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:tarefas/presentation/pages/sprash_screen.dart';
import 'presentation/pages/home_page.dart'; // Certifique-se de que o ThemeProvider está no caminho correto.

// Desenvolvido por Ian

void main() {
  // Verifique se está em um ambiente desktop (Windows, Linux, macOS)
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    // Inicializa o factory do banco de dados para uso com sqflite_common_ffi
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Acessa o ThemeProvider para gerenciar o tema.
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(), // Tema claro.
      darkTheme: ThemeData.dark(), // Tema escuro.
      themeMode: themeProvider.themeMode, // Alterna entre claro e escuro.
      home: const SplashScreen(),
    );
  }
}
