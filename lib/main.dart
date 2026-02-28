import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';

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
  String? secilenSehir;
  Future<WeatherModel>? weatherFuture;
  void selectedCity(String sehir) {
    setState(() {
      secilenSehir = sehir;
      weatherFuture = getweather(sehir);
    });
  }

  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.openweathermap.org/data/2.5',
      queryParameters: {
        "appid": "79a61f70f90ec141fcb33583b7a93480",
        "lang": "tr",
        "units": "metric",
      },
    ),
  );

  Future<WeatherModel> getweather(String secilenSehir) async {
    final response = await dio.get(
      '/weather',
      queryParameters: {"q": secilenSehir},
    );
    var model = WeatherModel.fromJson(response.data);
    debugPrint(model.main?.temp.toString());
    return model;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Material App Bar')), // AppBar
      body: Column(
        children: [
          if (weatherFuture != null)
            FutureBuilder<WeatherModel>(
              future: weatherFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                }
                if (snapshot.hasData) {
                  return Card(child: Text(snapshot.data!.name!));
                }
                return SizedBox();
              },
            ),
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
                  onTap: () => selectedCity(sehirler[index]),
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
