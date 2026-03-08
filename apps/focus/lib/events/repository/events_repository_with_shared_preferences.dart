import 'dart:convert';

import 'package:focus/events/models/event_model.dart';
import 'package:focus/events/repository/events_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventsRepositoryWithSharedPreferences implements EventsRepository {
  EventsRepositoryWithSharedPreferences({required SharedPreferences prefs})
      : _prefs = prefs;

  static const _key = 'events';

  final SharedPreferences _prefs;

  @override
  Future<List<Event>> getEvents() async {
    final raw = _prefs.getString(_key);
    if (raw == null) return [];
    final list = jsonDecode(raw) as List<dynamic>;
    return list
        .map((e) => Event.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> saveEvents(List<Event> events) async {
    final raw = jsonEncode(events.map((e) => e.toJson()).toList());
    await _prefs.setString(_key, raw);
  }
}
