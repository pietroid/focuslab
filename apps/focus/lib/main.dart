import 'package:flutter/material.dart';
import 'package:focus/app/app/view/app.dart';
import 'package:focus/app/app_router/app_router.dart';
import 'package:focus/bootstrap.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  bootstrap(() async {
    Intl.defaultLocale = 'pt_BR';
    await initializeDateFormatting('pt_BR');
    return App(
      router: AppRouter().router,
    );
  });
}
