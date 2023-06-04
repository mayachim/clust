import '../models/event_model.dart';
import 'api_helper.dart';

class EventController {
  String domain = "192.168.93.1:3333";
  String path = "event/";
  Future<List<Event>> getAll({hot, live}) async {
    dynamic jsonObject = await ApiHelper().get(hot == true
        ? "${path}hot"
        : live == true
            ? "${path}getlive"
            : "${path}nonpast");
    List<Event> result = [];
    jsonObject.forEach((json) {
      // print(json);
      result.add(Event.fromJson(json));
    });
    return result;
  }

  Future<Event> getByID(int id) async {
    dynamic jsonObject = await ApiHelper().get("$path$id");
    late Event result;
    jsonObject.forEach((json) {
      result = Event.fromJson(json);
    });
    return result;
  }

  Future<Event> create(Event event) async {
    dynamic jsonObject = await ApiHelper().post(path, body: event.toJson());
    dynamic result = Event.fromJson(jsonObject);
    return result;
  }

  Future<Event> update(Event event) async {
    dynamic jsonObject = await ApiHelper().put(path, event.toJson());
    Event result = Event.fromJson(jsonObject);
    return result;
  }

  Future<void> destroy(int id) async {
    dynamic jsonObject = await ApiHelper().delete("$path$id");
    // Event result = Event.fromJson(jsonObject);
    // return result;
  }
}
