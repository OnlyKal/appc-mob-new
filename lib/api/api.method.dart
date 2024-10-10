import 'dart:convert';

import 'package:appc/func/export.dart';

Future getProvices() async {
  return apigetDataNoAuth("api/auth/provinces/");
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
  return apipostDataNoAuth("api/auth/member/create/", data);
}

Future login(matricule, codepin) async {
  return apipostDataNoAuth("api/auth/member/signin/",
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

Future postNewssubComment(newsId, parentId, commentaire) async {
  return apipostData("api/news/comment/add/", {
    "comment": commentaire,
    "comment_parent_id": parentId.toString(),
    "news_id": newsId.toString()
  });
}

Future postAddQuestion(question) async {
  return apipostData("api/news/question/add/", {"question": question});
}

Future updatePIN(oldPIN, newPIN) async {
  return apipostData(
      "api/auth/member/update-pin/", {"old_pin": oldPIN, "new_pin": newPIN});
}

Future getAllCardType() async {
  return apigetDataNoAuth("api/subscription/cards/");
}

Future getUserCards() async {
  return apigetData("api/subscription/member-cards/");
}

Future getUserQuestions() async {
  return apipostData("api/news/question/get-all/", {});
}

Future getNewsDetails(id) async {
  return apigetDataNoAuth("api/news/news/$id/");
}

Future getCommentNews(newsId) async {
  return apipostDataNoAuth(
      "api/news/comment/get-by-news/", {"news_id": newsId.toString()});
}

Future getSubCommentsnews(commentId) async {
  return apipostDataNoAuth(
      "api/news/get-by-comment/", {"comment_id": commentId.toString()});
}

Future getAllnews(limit, page) async {
  return apigetDataNoAuth("api/news/get-all/?limit=$limit&page=$page");
}

Future getSubscription(number) async {
  return apipostData("api/subscription/get/", {"member_card": number});
}

Future buyAbonnement(cardnumber, qty, trans) async {
  return apipostDataJSON(
      "api/subscription/add/",
      jsonEncode({
        "member_card": cardnumber.toString(),
        "quantity": qty.toString(),
        "transaction": trans
      }));
}

Future createCard(cardId, transaction) async {
  return apipostDataJSON("api/subscription/member-card/create/",
      jsonEncode({"card_id": cardId.toString(), "transaction": transaction}));
}

//NEW
Future updateStatusCard(matricule, status) async {
  return apipostData("api/subscription/update-card-status/",
      {"matricule": matricule, "status": status});
}

//NEW
Future getMyFrenquency(matricule) async {
  return apigetData("api/auth/frenquecies/get-user-frequencies/$matricule/");
}

// NEW
Future getUserCardInfo(idcard) async {
  return apigetData("api/subscription/member-cards/$idcard/");
}

// NEW
Future addFrequency(memberId, service) async {
  return apipostData("api/auth/frenquecies/add-user-frequency/",
      {"owner": 12, "service": "transport", "frequentation": 1});
}
