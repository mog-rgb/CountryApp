import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String? location; // location name for UI
  String time = ""; // time in location for UI
  String? flag; // URL to asset flag icon
  String? url; // location URL for API endpoints
  late bool isDayTime = false; // initialize isDayTime to false

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      // make http request
      Response response = await get(Uri.parse('https://worldtimeapi.org/api/timezone/$url'));

      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);

        // get properties from data
        String datetime = data['datetime'];

        // Creating the DateTime object:
        DateTime now = DateTime.parse(datetime);
        isDayTime = (now.hour > 6 && now.hour < 20);
        time = DateFormat.jm().format(now); // set the time property within the class
      } else {
        print('API request failed with status code: ${response.statusCode}');
        time = 'could not get time data';
      }
    } catch (e) {
      print('caught error: $e');
      time = 'could not get time data';
    }
  }
}
