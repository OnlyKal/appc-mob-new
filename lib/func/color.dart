import 'dart:math';

import 'package:flutter/material.dart';

Color mainColor = const Color.fromARGB(255, 18, 108, 182);
Color colorRandom() {
  final Random random = Random();
  int r = random.nextInt(128);
  int g = random.nextInt(128);
  int b = random.nextInt(128);
  return Color.fromARGB(255, r, g, b);
}

Color getMembershipColor(String tier) {
  switch (tier.toLowerCase()) {
    case 'gold':
      return const Color.fromARGB(255, 89, 61, 12); // Gold
    case 'argent':
      return const Color.fromARGB(255, 21, 98, 149); // Silver
    case 'bronze':
      return const Color.fromARGB(255, 140, 39, 30); // Bronze
    case 'platine':
      return const Color.fromARGB(255, 143, 136, 125); // Platinum
    case 'premium':
      return const Color.fromARGB(
          255, 6, 49, 147); // Premium (using a gold color)
    default:
      return const Color.fromARGB(
          255, 59, 14, 94); // Default to white if no match
  }
}
