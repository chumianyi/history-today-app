import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'screens/home_screen.dart';
import 'widgets/neu_widgets.dart';

void main() {
  initializeDateFormatting('zh_CN', null).then((_) {
    runApp(const HistoryTodayApp());
  });
}

class HistoryTodayApp extends StatelessWidget {
  const HistoryTodayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '历史上今天',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: NeuColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: NeuColors.primary,
          primary: NeuColors.primary,
          secondary: NeuColors.accent,
          surface: NeuColors.background,
        ),
        fontFamily: 'sans-serif',
      ),
      home: const HomeScreen(),
    );
  }
}
