import 'package:flutter/material.dart';
import 'package:world_time/sevices/world_time.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({super.key});

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  List<WorldTime> locations = [
    WorldTime(urlString: '/api/timezone/Europe/London', location: 'London', flag: 'uk.png'),
    WorldTime(urlString: '/api/timezone/Europe/Berlin', location: 'Athens', flag: 'germany.png'),
    WorldTime(urlString: '/api/timezone/Africa/Cairo', location: 'Cairo', flag: 'egypt.png'),
    WorldTime(urlString: '/api/timezone/Africa/Nairobi', location: 'Nairobi', flag: 'kenya.png'),
    WorldTime(urlString: '/api/timezone/America/Chicago', location: 'Chicago', flag: 'usa.png'),
    WorldTime(urlString: '/api/timezone/America/New_York', location: 'New York', flag: 'usa.png'),
    WorldTime(urlString: '/api/timezone/Asia/Seoul', location: 'Seoul', flag: 'south_korea.png'),
    WorldTime(urlString: '/api/timezone/Asia/Jakarta', location: 'Jakarta', flag: 'indonesia.png'),
  ];

  void updateTime (index) async {
    WorldTime instance = locations[index];
    await instance.getTime();
    // navigator to home screen
    Navigator.pop(context, {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDayTime': instance.isDayTime
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Choose a Location'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
          itemCount: locations.length,
          itemBuilder: (context, index){
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
              child: Card(
                child: ListTile(
                  onTap: (){
                    updateTime(index);
                  },
                  title: Text(locations[index].location),
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('assets/${locations[index].flag}'),
                  ),
                ),
              ),
            );
          }
      ),

    );
  }
}
