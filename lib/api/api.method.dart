import 'package:appc/func/export.dart';

Future getProvices() async {
  return apigetData("api/auth/provinces/");
}

Future addMember(
    provinceId, pincode, name, lastname, email, phone, function, adress) async {
  var data = {
    "province": provinceId.toString(),
    "pin": pincode.toString(),
    "first_name": name,
    "last_name": lastname,
    "email": email,
    "function": function,
    "phone_number": phone.toString(),
    "address": adress
  };
  return apipostData("api/auth/member/create/", data);
}

Future login(matricule, codepin) async {
  return apipostDataAuth("api/auth/member/signin/",
      {"matricule": matricule, "pin": codepin.toString()});
}

Future updateImage(base64String) async {
  return apipostData("api/auth/member/set-profil-image/",
      {"image": "data:image/png;base64,$base64String"});
}

Future postNewsComment(newsId, commentaire) async {
  return apipostData("api/news/comment/add/",
      {"comment": commentaire, "news_id": newsId.toString()});
}

Future getAllCardType() async {
  return apigetData("api/subscription/cards/");
}

Future getOnenews(id) async {
  return apigetData("api/news/news/$id/");
}

Future getAllnews(limit, page) async {
  return apigetData("api/news/get-all/?limit=$limit&page=$page");
}
