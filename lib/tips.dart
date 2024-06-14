import 'package:flutter/material.dart';

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
      debugShowCheckedModeBanner: false,
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
          style: TextStyle(color: Colors.green),
        ),
        centerTitle: true,
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
                color: Colors.green,
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
                Navigator.pushNamed(context, '/home');
              },
            ),
            ListTile(
              leading: Icon(Icons.agriculture),
              title: Text('Crop Recommendation'),
              onTap: () {
                Navigator.pushNamed(context, '/crop-recommendation');
              },
            ),
            ListTile(
              leading: Icon(Icons.lightbulb),
              title: Text('Tips'),
              onTap: () {
                Navigator.pushNamed(context, '/tips');
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to Crop Recommendation System!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                'Weekly Market Report',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: PDFContainers(),
              ),
              SizedBox(height: 20),
              WeatherWidget(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.green,
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.home, color: Colors.white),
                  Text('Home', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/crop-recommendation');
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.agriculture, color: Colors.white),
                  Text('Crop Recommendation', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/tips');
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.lightbulb, color: Colors.white),
                  Text('Tips', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PDFContainers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        PDFContainer(title: 'Report 1', pdfUrl: 'url_to_pdf1.pdf'),
        SizedBox(height: 10),
        PDFContainer(title: 'Report 2', pdfUrl: 'url_to_pdf2.pdf'),
        SizedBox(height: 10),
        PDFContainer(title: 'Report 3', pdfUrl: 'url_to_pdf3.pdf'),
        SizedBox(height: 10),
        PDFContainer(title: 'Report 4', pdfUrl: 'url_to_pdf4.pdf'),
        SizedBox(height: 10),
      ],
    );
  }
}

class PDFContainer extends StatelessWidget {
  final String title;
  final String pdfUrl;

  PDFContainer({required this.title, required this.pdfUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Add code to open the PDF when tapped
        // Example: launchURL(pdfUrl);
      },
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Icon(
                Icons.picture_as_pdf,
                color: Colors.red,
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WeatherWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(Icons.cloud),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Zanzibar',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '30°C',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
