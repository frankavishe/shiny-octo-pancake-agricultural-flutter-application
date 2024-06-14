import 'package:flutter/material.dart';
import 'services/weather_service.dart'; // Import the weather service

class CropRecommendation extends StatefulWidget {
  @override
  _CropRecommendationState createState() => _CropRecommendationState();
}

class _CropRecommendationState extends State<CropRecommendation> {
  int _selectedIndex = 1;
  String _selectedRegion = 'Choose the region';
  TextEditingController _districtController = TextEditingController();
  TextEditingController _temperatureController = TextEditingController();
  bool _isLoading = false; // Loading indicator

  final WeatherService _weatherService = WeatherService(); // Initialize WeatherService

  final List<String> _regions = [
    'Choose the region',
    'Arusha', 'Dar es Salaam', 'Dodoma', 'Geita', 'Iringa', 'Kagera', 'Katavi', 'Kigoma',
    'Kilimanjaro', 'Lindi', 'Manyara', 'Mara', 'Mbeya', 'Morogoro', 'Mtwara', 'Mwanza',
    'Njombe', 'Pemba North', 'Pemba South', 'Pwani', 'Rukwa', 'Ruvuma', 'Shinyanga',
    'Simiyu', 'Singida', 'Tabora', 'Tanga', 'Zanzibar North', 'Zanzibar South and Central',
    'Zanzibar West'
  ];

  final Map<String, String> _regionDescriptions = {
    'Arusha': 'Arusha is known for its mild climate and rich volcanic soils, making it suitable for coffee and vegetable farming.',
    'Dar es Salaam': 'Dar es Salaam has a tropical climate suitable for tropical fruits, spices, and rice.',
    'Dodoma': 'Dodoma has a semi-arid climate with suitable conditions for growing grapes and millet.',
    'Geita': 'Geita is known for its mining activities but also supports maize and cassava farming due to its moderate climate.',
    'Iringa': 'Iringa is known for its cool climate and is ideal for growing tea and horticultural crops.',
    'Kagera': 'Kagera has a lake-influenced climate ideal for bananas, coffee, and tea.',
    'Katavi': 'Katavi is suitable for rice and maize farming due to its warm and wet climate.',
    'Kigoma': 'Kigoma has a climate suitable for oil palm, coffee, and rice.',
    'Kilimanjaro': 'Kilimanjaro is known for its coffee and banana plantations due to its volcanic soils and moderate climate.',
    'Lindi': 'Lindi has a coastal climate ideal for cashew nuts, coconut, and rice.',
    'Manyara': 'Manyara supports maize and pigeon peas due to its semi-arid climate.',
    'Mara': 'Mara is suitable for cotton and maize farming.',
    'Mbeya': 'Mbeya has a cool climate ideal for coffee and tea cultivation.',
    'Morogoro': 'Morogoro is known for its sugarcane and horticultural crops.',
    'Mtwara': 'Mtwara is suitable for cashew nuts and rice.',
    'Mwanza': 'Mwanza has a lake-influenced climate suitable for maize and cotton.',
    'Njombe': 'Njombe is known for its cool climate, ideal for tea and horticultural crops.',
    'Pemba North': 'Pemba North supports clove and coconut farming.',
    'Pemba South': 'Pemba South is suitable for cloves and spices.',
    'Pwani': 'Pwani is suitable for cashew nuts and rice due to its coastal climate.',
    'Rukwa': 'Rukwa supports maize and rice farming due to its warm and wet climate.',
    'Ruvuma': 'Ruvuma is known for its cool climate ideal for coffee and tea.',
    'Shinyanga': 'Shinyanga has a semi-arid climate suitable for cotton and maize.',
    'Simiyu': 'Simiyu supports cotton and millet farming.',
    'Singida': 'Singida is suitable for sunflower and maize due to its semi-arid climate.',
    'Tabora': 'Tabora is known for its tobacco and maize farming.',
    'Tanga': 'Tanga has a coastal climate suitable for sisal and horticultural crops.',
    'Zanzibar North': 'Zanzibar North supports clove and coconut farming.',
    'Zanzibar South and Central': 'Zanzibar South and Central are suitable for cloves and spices.',
    'Zanzibar West': 'Zanzibar West supports horticultural crops and spices.',
  };

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

  void _recommendCrop() {
    String region = _selectedRegion;
    String district = _districtController.text;
    String temperature = _temperatureController.text;

    if (region == 'Choose the region' || district.isEmpty || temperature.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please fill in all the fields to get a recommendation.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    String description = _regionDescriptions[region] ?? 'No description available for this region.';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Recommendations'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Region: $region'),
                SizedBox(height: 10),
                Text('Description: $description'),
                SizedBox(height: 10),
                Text(''),
                SizedBox(height: 10),
                Text(''),
                Text(''),
                Text(''),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _fetchTemperature(String region) async {
    if (region == 'Choose the region') {
      _temperatureController.clear();
      return;
    }

    setState(() {
      _isLoading = true; // Show loading indicator
    });

    try {
      final temperature = await _weatherService.getTemperatureForRegion(region);
      setState(() {
        _temperatureController.text = temperature.toString();
      });
    } catch (e) {
      print("Error fetching temperature: $e");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to fetch temperature for the selected region.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } finally {
      setState(() {
        _isLoading = false; // Hide loading indicator
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/theog.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Text(
                  'Crop Recommendation',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: DropdownButton<String>(
                    value: _selectedRegion,
                    onChanged: (String? newValue) {
                      setState(() {
                        if (newValue != null) {
                          _selectedRegion = newValue;
                          _fetchTemperature(_selectedRegion); // Fetch temperature
                        }
                      });
                    },
                    items: _regions.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 36,
                    isExpanded: true,
                    underline: SizedBox(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    dropdownColor: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _districtController,
                  decoration: InputDecoration(
                    labelText: 'Fill the District',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    TextField(
                      controller: _temperatureController,
                      decoration: InputDecoration(
                        labelText: 'Fill the temperature',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      readOnly: true, // Make temperature field read-only
                    ),
                    if (_isLoading)
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(30.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.greenAccent.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: _recommendCrop,
                    child: Text(
                      'Recommend',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.eco),
              label: 'Crop Recommendation',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.lightbulb),
              label: 'Tips',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
