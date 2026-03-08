import 'package:focus/events/models/event_model.dart';

abstract class EventsRepository {
  Future<List<Event>> getEvents();
  Future<void> saveEvents(List<Event> events);
}
