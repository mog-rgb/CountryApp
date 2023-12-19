import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map? data; // Declare data as a nullable Map

  @override
  Widget build(BuildContext context) {
    // Check if data is null or empty before assigning values
    data = data.isNotEmpty ? data : ModalRoute.of(context)?.settings.arguments as Map ?? {};


    // Set Background
    bool? isDayTime = data?['isDayTime'] as bool?;
    String bgImage = isDayTime ?? false ? 'day.png' : 'night.png';
    Color bgColor = isDayTime ?? false ? Colors.lightBlue : Colors.indigo;

    return Scaffold(
      backgroundColor: bgColor,
      // SafeArea brings all widgets back into the screen
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/$bgImage'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 120.0, 0, 0),
            child: Column(
              children: <Widget>[
                TextButton.icon(
                  onPressed: () async {
                    dynamic result = await Navigator.pushNamed(context, '/location');
                    setState(() {
                      data = {
                        'time': result?['time'],
                        'location': result?['location'],
                        'isDayTime': result?['isDayTime'],
                        'flag': result?['flag'],
                      };
                    });
                  },
                  icon: Icon(
                    Icons.edit_location,
                    color: Colors.grey[300],
                  ),
                  label: Text(
                    'Edit Location',
                    style: TextStyle(color: Colors.grey[300]),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      data?['location'] ?? '',
                      style: TextStyle(
                        fontSize: 28.0,
                        letterSpacing: 2.0,
                        color: Colors.grey[300],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  data?['time'] ?? '',
                  style: TextStyle(
                    fontSize: 66.0,
                    color: Colors.grey[300],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
