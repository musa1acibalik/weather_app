import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';

void main() => runApp(const weatherApp());

// ignore: camel_case_types
class weatherApp extends StatelessWidget {
  const weatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: HomePage(),
    ); // MaterialApp
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

  Widget _buildWeatherCard(WeatherModel weatherModel) {
    return Card(
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              weatherModel.name!,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 8),
            Text(
              "${weatherModel.main!.temp!.round()}°",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            SizedBox(height: 8),
            Text(weatherModel.weather![0].description ?? "değer bulunamadı"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Icon(Icons.water_drop),
                    Text(weatherModel.main!.humidity!.round().toString()),
                  ],
                ),
                SizedBox(width: 32),
                Column(
                  children: [
                    Icon(Icons.air),
                    Text(weatherModel.wind!.speed!.round().toString()),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Hava Durumu'),
      ), // AppBar
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
                  return _buildWeatherCard(snapshot.data!);
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
                final isSelected = secilenSehir == sehirler[index];
                return GestureDetector(
                  onTap: () => selectedCity(sehirler[index]),
                  child: Card(
                    color:
                        isSelected
                            ? Theme.of(context).colorScheme.primaryContainer
                            : null,
                    child: Center(child: Text(sehirler[index])),
                  ),
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
