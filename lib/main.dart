import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';

void main() => runApp(
  MaterialApp(
    title: "Weather App",
    debugShowCheckedModeBanner: false,
    home: Home(),

  )
) ;
class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return _HomeState();
  }
}
class _HomeState extends State<Home>{
  var temp;
  var description;
  var currently;
  var humidity;
  var windspeed;
  Future getWeather () async {
    http.Response response = await http.get("http://api.openweathermap.org/data/2.5/weather?q=Boston&units=imperial&appid=7c7cc334b9f67951748eea47b848292d");
    var result = jsonDecode(response.body);
    setState(() {
      this.temp = result['main']['temp'];
      this.description = result['weather'][0]['description'];
      this.currently = result['weather'][0]['main'];
      this.humidity = result['main']['humidity'];
      this.windspeed = result['wind']['speed'];
    });
  }

  @override
  void initstate(){
    super.initState();
    this.getWeather();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      "Currently in London",
                    style: TextStyle(
                    color: Colors.white,
                        fontSize: 14.0,
                      fontWeight: FontWeight.w600
                  ),
                    ),


                     ),
                Text(
                  temp != null ? temp.toString() + "\u00B0" : "Loading",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.w600
                  ),

                ),

                Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                        currently !=null ? currently.toString() : "Loading",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600
                        ))


                ),
              ],
            ),
          ),
          Expanded(
          child: Padding(
          padding: EdgeInsets.all(20.0),
          child: ListView(
            children: <Widget>[
              ListTile(
                leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                title: Text("Tempreture"),
                trailing: Text(temp !=null ? temp.toString() + "\u00B0": "Loading"),

          ),
              ListTile(
              leading: FaIcon(FontAwesomeIcons.cloud),
              title: Text("Weather"),
              trailing: Text(description !=null ? description.toString() : "Loading"),

              ),
              ListTile(
              leading: FaIcon(FontAwesomeIcons.sun),
              title: Text("Humidity"),
              trailing: Text(humidity !=null ? humidity.toString() : "Loading"),

              ),
              ListTile(
              leading: FaIcon(FontAwesomeIcons.wind),
              title: Text("Wind Speed"),
              trailing: Text(windspeed !=null ? windspeed.toString() : "Loading"),

              ),
          ],
          ),
          ),
          )
        ],
      ),
    );
  }
}
