# 🌤️ Weather App

A simple Flutter weather application that displays current weather data for Turkish cities using the OpenWeatherMap API.

## 📱 Screenshots

> Add your screenshots here

## ✨ Features

- View current weather for 6 major Turkish cities (Ankara, İstanbul, İzmir, Bursa, Van, Antalya)
- Displays temperature, weather description, humidity, and wind speed
- Selected city is highlighted in the grid
- Clean Material Design 3 UI

## 🛠️ Tech Stack

- **Flutter** — UI framework
- **Dart** — Programming language
- **Dio** — HTTP client for API requests
- **OpenWeatherMap API** — Weather data provider

## 🚀 Getting Started

### Prerequisites

- Flutter SDK
- An [OpenWeatherMap](https://openweathermap.org/) API key

### Installation

1. Clone the repo
   ```bash
   git clone https://github.com/musa1acibalik/weather_app.git
   ```

2. Install dependencies
   ```bash
   flutter pub get
   ```

3. Add your API key in `main.dart`
   ```dart
   "appid": "YOUR_API_KEY_HERE"
   ```

4. Run the app
   ```bash
   flutter run
   ```

## 📦 Dependencies

```yaml
dio: ^5.x.x
```

## 📄 License

This project is open source and available under the [MIT License](LICENSE).
