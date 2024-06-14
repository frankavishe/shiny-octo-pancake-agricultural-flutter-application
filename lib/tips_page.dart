import 'package:flutter/material.dart';

class TipsPage extends StatefulWidget {
  @override
  _TipsPageState createState() => _TipsPageState();
}

class _TipsPageState extends State<TipsPage> {
  int _selectedIndex = 2;

  List<String> _images = [
    'assets/maize.jpg',
    'assets/cassava.jpg',
    'assets/millet.jpg',
    'assets/potato.jpg',
    'assets/banana.jpg',
    'assets/coffee.jpg',
  ];

  List<String> _texts = [
    'maize',
    'cassava',
    'millet',
    'potato',
    'banana',
    'coffee',
  ];

  List<String> _descriptions = [
    'Maize does best under moderate temperatures and is vulnerable to warm temperatures. Ideal maximum temperatures are between 27 to 30°C. Temperatures above that, especially those above 35°C, lead to much lower productivity. Also, generally the warmer the temperature, the faster the plant completes its development (phenology). In warm temperatures such as in Tanzania, the more rapid phenology leads to lower yield as the plant matures rapidly before grains grow large, reducing yields.',
    'Cassava cultivation in Tanzania is well-suited to diverse agro-climatic conditions, thriving in temperatures ranging from 25°C to 30°C and requiring annual rainfall between 1,000 mm to 1,500 mm, although it can tolerate drought conditions and poor soils. It grows best in well-drained, loamy soils with a pH between 5.5 to 6.5. Planting usually occurs at the onset of the rainy season, with cassava varieties selected based on factors such as root size, disease resistance, and culinary preferences. Cassava roots typically mature within 6 to 18 months, with harvesting initiated once the tubers reach the desired size and the leaves start to yellow and fall. Renowned for its versatility and resilience, cassava serves as a staple food crop and a valuable source of income for millions of Tanzanian farmers, with proper agronomic practices, including soil fertility management, pest control, and timely harvesting, crucial for optimizing yields and ensuring food security and economic sustainability.',
    'Millet cultivation in Tanzania thrives in warm temperatures between 25°C and 30°C and requires 300 mm to 700 mm of annual rainfall, making it ideal for semi-arid regions. Planting occurs at the onset of the rainy seasons: late November to December for short rains and March to April for long rains. Millet matures in 70-90 days, with harvesting from late January to February or June to July, depending on the season. It prefers well-drained sandy or loamy soils and is highly drought-resistant, contributing to food security. Key farming practices include using high-yield, drought-resistant seeds, ensuring a fine seedbed, planting seeds 2-3 cm deep, regular early weeding, and prompt pest and disease management.',
    'Potato cultivation in Tanzania thrives in temperatures ranging from 15°C to 20°C, requiring well-distributed rainfall of about 500 mm to 700 mm during its growth period. Ideal soil conditions include well-drained, fertile sandy loam soils with a pH of 5.0 to 6.5. Planting typically occurs during the rainy seasons from March to June and September to December. The crop germinates in about two weeks and matures within 90 to 120 days. Harvesting is usually done when the foliage begins to yellow and die back. Potatoes are a high-yield crop rich in essential nutrients, making them vital for food security and income generation in Tanzania. To optimize yields, farmers should prioritize seed selection, land preparation, irrigation, weed and pest control, and proper harvesting and storage techniques.',
    'Banana cultivation in Tanzania thrives in warm tropical climates with temperatures ranging from 25°C to 30°C and requires abundant rainfall between 1,500 mm to 2,500 mm annually, evenly distributed throughout the year. It flourishes in well-drained, fertile soils rich in organic matter, preferring a pH range of 5.5 to 7.0. Planting can occur year-round but is most successful during the rainy season. Depending on the variety, bananas take approximately 9 to 12 months to mature, with harvesting initiated when fruits reach the desired stage of ripeness indicated by a change in skin color and firmness. High in carbohydrates, vitamins, and minerals, bananas significantly contribute to food security and income generation. Farmers should prioritize variety selection, proper land preparation, irrigation, mulching, fertilization, and integrated pest and disease management to optimize yields and ensure sustainable production.',
    'Coffee cultivation in Tanzania is well-suited to regions with altitudes ranging from 800 to 1,600 meters and temperatures between 15°C to 24°C, with rainfall averaging between 1,200 mm to 2,000 mm annually, ideally distributed throughout the year. It thrives in well-drained, fertile soils with a pH of 5.5 to 6.5, commonly found in regions like Kilimanjaro and Mbeya. Planting typically occurs during the rainy season, with Arabica coffee varieties dominating due to their superior quality and adaptability to the Tanzanian climate. Coffee trees take approximately three to four years to reach maturity, with harvesting beginning once the berries ripen to a deep red color, usually from June to September. Renowned for its rich flavor and aroma, Tanzanian coffee contributes significantly to both local and international markets, with proper farming practices such as shade management, pest control, and selective harvesting crucial for sustaining high-quality yields and ensuring the economic viability of coffee farming communities.',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/crop_recommendation');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/tips');
        break;
    }
  }

  void _showDescriptionDialog(String description) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Crop Description'),
          content: Text(description),
          actions: [
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/theog.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: SizedBox(),
              ),
              Text(
                'Cultivation Tips',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20), // Add space between the title and the horizontal list
              Center(
                child: Container(
                  height: screenWidth < 600 ? 400 : 200, // Adjust height based on screen width
                  child: screenWidth < 600
                      ? Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _images.sublist(0, 3).map((image) {
                          int index = _images.indexOf(image);
                          return Padding(
                            padding: EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () => _showDescriptionDialog(_descriptions[index]),
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  CircleAvatar(
                                    radius: 75,
                                    backgroundImage: AssetImage(image),
                                  ),
                                  Container(
                                    color: Colors.black54,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                                      child: Text(
                                        _texts[index],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _images.sublist(3, 6).map((image) {
                          int index = _images.indexOf(image);
                          return Padding(
                            padding: EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () => _showDescriptionDialog(_descriptions[index]),
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  CircleAvatar(
                                    radius: 75,
                                    backgroundImage: AssetImage(image),
                                  ),
                                  Container(
                                    color: Colors.black54,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                                      child: Text(
                                        _texts[index],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  )
                      : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _images.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () => _showDescriptionDialog(_descriptions[index]),
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              CircleAvatar(
                                radius: 75,
                                backgroundImage: AssetImage(_images[index]),
                              ),
                              Container(
                                color: Colors.black54,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                                  child: Text(
                                    _texts[index],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green, // Set the background color of the bottom navigation bar to green
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.white), // Adjust the icon size
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.autorenew_rounded,color: Colors.white), // Adjust the icon size
            label: 'Crop Recommendation',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_stories_outlined,color: Colors.white), // Adjust the icon size
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
