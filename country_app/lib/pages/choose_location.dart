  import 'package:flutter/material.dart';
  import 'package:country_app/services/world_time.dart';

  class ChooseLocation extends StatefulWidget {
    const ChooseLocation({super.key});

    @override
    State<ChooseLocation> createState() => _ChooseLocationState();
  }

  class _ChooseLocationState extends State<ChooseLocation> {

    List<WorldTime> locations = [
      WorldTime(url: 'Europe/London', location: 'London', flag: 'uk.png'),
      WorldTime(url: 'Europe/Berlin', location: 'Athens', flag: 'greece.png'),
      WorldTime(url: 'Africa/Cairo', location: 'Cairo', flag: 'egypt.png'),
      WorldTime(url: 'Africa/Nairobi', location: 'Nairobi', flag: 'kenya.png'),
      WorldTime(url: 'America/Chicago', location: 'Chicago', flag: 'usa.png'),
      WorldTime(url: 'America/New_York', location: 'New York', flag: 'usa.png'),
      WorldTime(url: 'Asia/Seoul', location: 'Seoul', flag: 'south_korea.png'),
      WorldTime(url: 'Asia/Jakarta', location: 'Jakarta', flag: 'indonesia.png'),
    ];

   void updateTime(index) async {
  WorldTime instance = locations[index];
  
  try {
    await instance.getTime();

    // Check if the widget is still mounted before updating the UI
    if (mounted) {
      Navigator.pop(context, {
        'location': instance.location,
        'flag': instance.flag,
        'time': instance.time,
        'isDayTime': instance.isDayTime,
      });
    }
  } catch (e) {
    print('caught error: $e');
    // Handle error if needed
  }
}

    @override
    Widget build(BuildContext context) {
      print('build function ran');
      return Scaffold(

        backgroundColor: Color.fromARGB(255, 245, 245, 245),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 35, 156, 255),
          title: Text('Choose Location'),
          centerTitle: true,
          elevation: 0,
        ),

        body: ListView.builder(

          itemCount: locations.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
              child: Card(
                child: ListTile(
                  onTap: () {
                    updateTime(index);
                  }, 
                  title: Text(locations[index].location.toString()),
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/${locations[index].flag}'),
                  ),
                ),
              ),
            );
          }

        ),


      );
    }
  }