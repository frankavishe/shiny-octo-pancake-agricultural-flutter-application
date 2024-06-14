import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'CropRecommendationScreen.dart';

void main() {
  runApp(CropRecommendationApp());
}

class CropRecommendationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crop Recommendation System',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      debugShowCheckedModeBanner: false, // Remove debug banner
      home: CropRecommendationHomePage(),
    );
  }
}

class CropRecommendationHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Crop Recommendation System',
          style: TextStyle(color: Colors.white), // Set title color to white
        ),
        centerTitle: true, // Center the title
        backgroundColor: Colors.green, // Set background color to green
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green, // Green background for drawer header
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                // Add your home action here
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.agriculture),
              title: Text('Crop Recommendation'),
              onTap: () {
                // Add your crop recommendation action here
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.lightbulb),
              title: Text('Tips'),
              onTap: () {
                // Add your tips action here
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.blue[100], // Set background color to pale blue
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Weekly Reports',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  WeeklyReportContainer(title: 'Report for Zanzibar'),
                  SizedBox(height: 10),
                  WeeklyReportContainer(title: 'Report for Dar es Salaam'),
                  SizedBox(height: 10),
                  WeeklyReportContainer(title: 'Report for Arusha'),
                  SizedBox(height: 10),
                  WeeklyReportContainer(title: 'Report for Dodoma'),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Weather Slideshow',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 10),
            WeatherSlideshow(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.green, // Green background for bottom navigation bar
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                // Add your home action here
              },
              child: Icon(Icons.home),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CropRecommendationScreen()),
                );
              },
              child: Icon(Icons.agriculture),
            ),
            ElevatedButton(
              onPressed: () {
                // Add your tips action here
              },
              child: Icon(Icons.lightbulb),
            ),
          ],
        ),
      ),
    );
  }
}

class WeeklyReportContainer extends StatelessWidget {
  final String title;

  WeeklyReportContainer({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(
            Icons.picture_as_pdf,
            color: Colors.red,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}

class WeatherCondition {
  final String condition;
  final String temperature;
  final IconData icon;

  WeatherCondition({required this.condition, required this.temperature, required this.icon});
}

class WeatherSlideshow extends StatelessWidget {
  final List<WeatherCondition> weatherConditions = [
    WeatherCondition(condition: 'Zanzibar', temperature: '30°C', icon: Icons.wb_sunny),
    WeatherCondition(condition: 'Dar es Salaam', temperature: '28°C', icon: Icons.wb_cloudy),
    WeatherCondition(condition: 'Dodoma', temperature: '26°C', icon: Icons.grain),
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: weatherConditions.map((weather) {
        return Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey[200], // Gray background color for weather widget
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Icon(
                weather.icon,
                size: 50,
                color: Colors.blue,
              ),
              SizedBox(height: 10),
              Text(
                weather.condition,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                weather.temperature,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        );
      }).toList(),
      options: CarouselOptions(
        height: 200,
        aspectRatio: 16 / 9,
        viewportFraction: 0.8,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}

class CropRecommendationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crop Recommendation'),
      ),
      body: Center(
        child: Text('Crop Recommendation Screen'),
      ),
    );
  }
}
