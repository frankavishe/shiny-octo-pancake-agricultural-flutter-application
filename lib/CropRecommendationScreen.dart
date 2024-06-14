import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
      home: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/theog.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            CropRecommendationHomePage(),
          ],
        ),
      ),
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
        backgroundColor: Colors.green, // Green background color
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
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.agriculture),
              title: Text('Crop Recommendation'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CropRecommendationScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.lightbulb),
              title: Text('Tips'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TipsScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.transparent, // Set background color to transparent
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
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.agriculture),
            label: 'Crop Recommendation',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb),
            label: 'Tips',
          ),
        ],
        selectedItemColor: Colors.green,
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CropRecommendationHomePage()),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CropRecommendationScreen()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TipsScreen()),
            );
          }
        },
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
    WeatherCondition(condition: 'Arusha', temperature: '24°C', icon: Icons.flash_on),
    WeatherCondition(condition: 'Mwanza', temperature: '22°C', icon: Icons.wb_cloudy),
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
            mainAxisAlignment: MainAxisAlignment.center,
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
        backgroundColor: Colors.green,
      ),
      body: Container(
        color: Colors.lightBlue[50], // Pale blue background color for the body
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Mkoa',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'Wilaya',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'Mwezi',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'Temperature',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add your recommendation action here
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green, // Green background for the button
              ),
              child: Text('Recommend'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.agriculture),
            label: 'Crop Recommendation',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb),
            label: 'Tips',
          ),
        ],
        selectedItemColor: Colors.green,
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CropRecommendationHomePage()),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CropRecommendationScreen()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TipsScreen()),
            );
          }
        },
      ),
    );
  }
}

class TipsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tips'),
        backgroundColor: Colors.green,
      ),
      body: Container(
        color: Colors.lightBlue[50], // Pale blue background color for the body
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: List.generate(9, (index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/pic${index + 1}.png'),
                ),
                SizedBox(height: 5),
                Text('picture${index + 1}', style: TextStyle(fontSize: 16)),
              ],
            );
          }),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.agriculture),
            label: 'Crop Recommendation',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb),
            label: 'Tips',
          ),
        ],
        selectedItemColor: Colors.green,
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CropRecommendationHomePage()),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CropRecommendationScreen()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TipsScreen()),
            );
          }
        },
      ),
    );
  }
}
