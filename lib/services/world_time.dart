import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String location; // name of the location
  String time; // time for the location
  String flag; // url to asset
  String url;
  bool isDayTime;

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {

    try {
      // Se realiza la peticion
    Response response = await get('http://worldtimeapi.org/api/timezone/$url');
    Map data = jsonDecode(response.body);

    // Obtener la informacion querida de la respuesta del API
    String datetime = data['datetime'];
    String offset = data['utc_offset'].substring(1,3);

    //Crear un objeto tipo datetime para almacenar el valor de la hora
    DateTime now = DateTime.parse(datetime);
    now = now.subtract(Duration(hours: int.parse(offset)));

    // set the time property
    isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
    time = DateFormat.jm().format(now);

    } catch (e) {
      print('caught error: $e');
      time = 'Could not get the time data';
    }

  }

}

