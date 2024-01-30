import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:note_hive/app/data/hive_class/HiveFunctions.dart';

import 'app/routes/app_pages.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox(HiveFunctions.userHiveBox);
  // Hive.registerAdapter(CatModelAdapter());
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
