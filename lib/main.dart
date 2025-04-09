import 'package:anotacoes/anotacao_page.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
    // A url e o anonkey deverá ser substituido pelo mesmo que estiver em seu banco do supabase
    url: 'https://ssojdzznofcojothdmpk.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNzb2pkenpub2Zjb2pvdGhkbXBrIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDM5OTE0MTgsImV4cCI6MjA1OTU2NzQxOH0.R495zB333kwSU5tJjcFujK0kbHYEXQLMraKPkpLQDxY',
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnotacaoPage(),
    );
  }
}
