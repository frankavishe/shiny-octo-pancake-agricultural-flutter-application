import 'package:flutter/material.dart';
import 'crop_recommendation.dart';
import 'tips_page.dart'; // Assuming you have a Tips page
import 'services/weather_service.dart'; // Import the weather service

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Background Image App',
      home: MyHomePage(),
      routes: {
        '/home': (context) => MyHomePage(),
        '/crop_recommendation': (context) => CropRecommendation(),
        '/tips': (context) => TipsPage(), // Assuming you have created TipsPage
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  double? temperature;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  Future<void> fetchWeather() async {
    try {
      final temperature = await WeatherService().getTemperatureForRegion('Dar es Salaam');
      setState(() {
        this.temperature = temperature;
        isLoading = false;
      });
      print('Temperature in Dar es Salaam: ${this.temperature}°C');
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Failed to fetch temperature data: $e');
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/home');
        break;
      case 1:
        Navigator.pushNamed(context, '/crop_recommendation');
        break;
      case 2:
        Navigator.pushNamed(context, '/tips');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    var weather;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/theog.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(top: 200.0), // Adjust top padding as needed
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16.0),
                  width: 300, // Adjust the width of the container as needed
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: isLoading
                      ? CircularProgressIndicator()
                      : weather == null
                      ? Text(
                    'welcome.',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  )
                      : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.sunny,
                        size: 40,
                        color: Colors.white70,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Temperature: ${weather?.temperature ?? '--'}°C',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Weekly Market Report',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20),
                Column(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        // Add functionality for downloading PDF 1
                      },
                      icon: Icon(Icons.picture_as_pdf, size: 20),
                      label: Text('Final environmental and social system Assessment (ESSA)'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Add functionality for downloading PDF 2
                      },
                      icon: Icon(Icons.picture_as_pdf, size: 20),
                      label: Text('Final environmental and social system Assessment (ESSA)'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    // Add more buttons as needed
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.white),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.autorenew_rounded, color: Colors.white),
            label: 'Crop Recommendation',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_stories_outlined, color: Colors.white),
            label: 'Tips',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

class WeatherModel {
  final String description;
  final double temperature;
  final double feelsLike;

  WeatherModel({
    required this.description,
    required this.temperature,
    required this.feelsLike,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      description: json['weather'][0]['description'],
      temperature: json['main']['temp'].toDouble(),
      feelsLike: json['main']['feels_like'].toDouble(),
    );
  }
}
