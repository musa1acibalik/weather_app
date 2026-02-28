import 'package:flutter/material.dart';

void main() => runApp(const weatherApp());

class weatherApp extends StatelessWidget {
  const weatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Material App', home: HomePage()); // MaterialApp
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> sehirler = [
    "Ankara",
    "Bursa",
    "İzmir",
    "İstanbul",
    "Van",
    "Antalya",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Material App Bar')), // AppBar
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    debugPrint("tıklanılan şehir ${sehirler[index]}");
                  },
                  child: Card(child: Center(child: Text(sehirler[index]))),
                );
              },
              itemCount: sehirler.length,
            ),
          ),
        ],
      ), // Center
    );
  }
}
