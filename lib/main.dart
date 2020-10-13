import 'package:flutter/material.dart';
import 'package:newstoday/app.dart';
import 'package:newstoday/config/base_url_config.dart';
import 'package:newstoday/config/flavor_config.dart';
import 'package:newstoday/injection_container.dart' as di;
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('settings');
  FlavorConfig(
    flavor: Flavor.PRODUCTION,
    values: FlavorValues(baseUrl: BaseUrlConfig().baseUrlProduction),
  );
  await di.init();
  runApp(App());
}
