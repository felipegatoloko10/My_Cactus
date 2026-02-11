import 'package:flutter/material.dart';
import '../models/Plant.dart';
import '../utils/DatabaseHelper.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class PlantProvider with ChangeNotifier {
  List<Plant> _plants = [];
  List<Plant> get plants => _plants;

  final DatabaseHelper _dbHelper = DatabaseHelper.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  PlantProvider() {
    _initNotifications();
    loadPlants();
  }

  Future<void> _initNotifications() async {
    tz.initializeTimeZones();
    
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    final platform = flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.requestNotificationsPermission();
    
    final iosPlatform = flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>();
    await iosPlatform?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<void> loadPlants() async {
    _plants = await _dbHelper.readAllPlants();
    notifyListeners();
  }

  Future<void> addPlant(Plant plant) async {
    if (_plants.length >= 3) {
      throw Exception('Premium Check Failed');
    }
    final newPlant = await _dbHelper.create(plant);
    await loadPlants();
    _scheduleNotification(newPlant);
  }

  Future<void> waterPlant(Plant plant) async {
    final updatedPlant = Plant(
      id: plant.id,
      name: plant.name,
      species: plant.species,
      imagePath: plant.imagePath,
      frequencyDays: plant.frequencyDays,
      lastWateredDate: DateTime.now(),
    );

    await _dbHelper.update(updatedPlant);
    await loadPlants();
    _scheduleNotification(updatedPlant);
  }

  Future<void> deletePlant(int id) async {
    await _dbHelper.delete(id);
    await loadPlants();
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> _scheduleNotification(Plant plant) async {
     // Cancel previous notification for this plant
     if (plant.id != null) {
       await flutterLocalNotificationsPlugin.cancel(plant.id!);
     }

     final nextWateringDate = plant.lastWateredDate.add(Duration(days: plant.frequencyDays));
     
     if (nextWateringDate.isBefore(DateTime.now())) {
       // If already due, don't schedule, arguably we could show immediate notification but let's skip
       return;
     }

     await flutterLocalNotificationsPlugin.zonedSchedule(
        plant.id!,
        'Water ${plant.name}',
        'It is time to water your ${plant.species}!',
        tz.TZDateTime.from(nextWateringDate, tz.local),
        const NotificationDetails(
            android: AndroidNotificationDetails(
                'watering_channel', 'Watering Reminders',
                channelDescription: 'Reminders to water your plants')),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }
}
