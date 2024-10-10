import 'package:appc/func/notification.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    bool taskSuccess = true;
    print(inputData);
    try {
      switch (taskName) {
        case "welcome-event":
          NotificationClass.openNotifMono(
            "APPC-RDC",
            "APPC-RDC, où nous inspirons notre peuple à créer le changement et à oser inventer son avenir. Ensemble, façonnons un futur prometteur pour notre nation. Soyez les artisans de demain",
          );
          break;
        default:
          taskSuccess = false;
      }
    } catch (e) {
      taskSuccess = false;
    }

    return Future.value(taskSuccess);
  });
}

Future<void> initBackgroundFetch() async {
  Workmanager().initialize(callbackDispatcher, isInDebugMode: false);
  Workmanager().registerPeriodicTask(
    "appc.notif.background",
    "welcome-event",
    initialDelay: const Duration(seconds: 1),
    constraints: Constraints(networkType: NetworkType.connected),
    frequency: const Duration(minutes: 15),
  );
}

