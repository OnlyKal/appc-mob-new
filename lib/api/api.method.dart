import 'package:appc/func/export.dart';


Future getProvices() async {
  return apigetData("api/auth/provinces/");
}
