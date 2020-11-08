import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:weather_app/pages/menu_bar.dart';
import 'package:weather_app/reusable_card.dart';
import 'package:weather_app/pages/location.dart';

const kTextStyle = TextStyle(color: Colors.white);

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Weather App",
        home: Home(),
      ),
    );

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var temp;
  var description;
  var currently;
  var humidity;
  var windSpeed;
  var country;
  var city;
  var lat;
  var lon;

  getWeather() async {
    String city = 'California';
    http.Response response = await http.get(
        'http://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=417e4395bb9fa381afd1a45ad65d9ca8');
    var results = jsonDecode(response.body);
    setState(() {
      this.temp = results['main']['temp'];
      this.description = results['weather'][0]['description'];
      this.humidity = results['main']['humidity'];
      this.windSpeed = results['wind']['speed'];
      this.country = results['sys']['country'];
      this.city = results['name'];
    });
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    lat = location.latitude;
    lon = location.longitude;
    print(lon);
    print(lat);
    getWeather();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
    //getWeather();
  }

  @override
  Widget build(BuildContext context) {
    getWeather();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[900],
        centerTitle: true,
        title: Text(country != null ? 'Weather in $country' : 'Loading...'),
        actions: [
          Icon(Octicons.location),
          Padding(padding: EdgeInsets.symmetric(horizontal: 8.0)),
        ],
      ),
      drawer: MenuBar(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/sunset.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            ReusableCard(
              colour: Color(0x90000000),
              cardChild: Container(
                height: MediaQuery.of(context).size.height / 5,
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        city != null ? 'Currently in $city' : 'Loading',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      temp != null ? temp.toString() + '\u00B0' : 'Loading...',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        description != null
                            ? description.toString()
                            : 'Loading...',
                        style: kTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ReusableCard(
              colour: Color(0x90000000),
              cardChild: Container(
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: ListView(
                    children: [
                      ListTile(
                        leading: Icon(
                          FontAwesome.thermometer_half,
                          color: Colors.red[500],
                        ),
                        title: Text(
                          'Temperature',
                          style: kTextStyle,
                        ),
                        trailing: Text(
                          temp != null
                              ? temp.toString() + "\u00B0"
                              : 'Loading...',
                          style: kTextStyle,
                        ),
                      ),
                      ListTile(
                        leading:
                            Icon(FontAwesome.cloud, color: Colors.blueAccent),
                        title: Text(
                          'Weather',
                          style: kTextStyle,
                        ),
                        trailing: Text(
                          description != null
                              ? description.toString()
                              : 'Loading...',
                          style: kTextStyle,
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          Ionicons.ios_water,
                          color: Colors.white,
                        ),
                        title: Text(
                          'Humidity',
                          style: kTextStyle,
                        ),
                        trailing: Text(
                          humidity != null
                              ? '${humidity.toString()}%'
                              : 'Loading...',
                          style: kTextStyle,
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          FontAwesome5Solid.wind,
                          color: Colors.white54,
                        ),
                        title: Text(
                          'Wind Speed',
                          style: kTextStyle,
                        ),
                        trailing: Text(
                          windSpeed != null
                              ? windSpeed.toString()
                              : 'Loading...',
                          style: kTextStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// http://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=417e4395bb9fa381afd1a45ad65d9ca8
