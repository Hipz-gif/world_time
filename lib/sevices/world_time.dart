import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  late String location; // location name for the UI
  late String time; // the time in that location
  late String flag; // url to asset flag icon
  late String urlString; // location url for api endpoint
  bool isDayTime = false;

  WorldTime({ required this.location,  required this.flag,  required this.urlString});

  Future<void> getTime() async {

    Uri url = Uri.http('worldtimeapi.org', urlString);
    try{
      Response response = await get(url);
      print('Response Body: ${response.body}');
      Map data = jsonDecode(response.body);
      // get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'];
      String offsetConvert = offset.substring(1,3);

      // create DateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offsetConvert)));

      // set the time properties
      time = DateFormat.jm().format(now);
      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
    } catch(e){
      print('Lỗi khi lấy dữ liệu thời gian: $e');
      time = 'could not get time data';
      isDayTime = false;
    }

  }
}
