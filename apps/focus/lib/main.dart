import 'package:flutter/material.dart';
import 'package:focus/app/app/view/app.dart';
import 'package:focus/app/app_router/app_router.dart';
import 'package:focus/bootstrap.dart';
import 'package:focus/events/repository/events_repository_with_shared_preferences.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  bootstrap(() async {
    Intl.defaultLocale = 'pt_BR';
    await initializeDateFormatting('pt_BR');
    final prefs = await SharedPreferences.getInstance();
    final eventsRepository =
        EventsRepositoryWithSharedPreferences(prefs: prefs);
    return App(router: AppRouter().router, eventsRepository: eventsRepository);
  });
}
