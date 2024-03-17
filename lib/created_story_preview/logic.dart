import 'package:get/get.dart';

class CreatedStoryPreviewLogic extends GetxController {


  bool isMostlyArabic(String input) {
    int arabicCount = 0;
    int englishCount = 0;

    input.runes.forEach((int rune) {
      var character = String.fromCharCode(rune);
      if (character.contains(RegExp(r'[\u0600-\u06FF]'))) {
        arabicCount++;
      } else if (character.contains(RegExp(r'[a-zA-Z]'))) {
        englishCount++;
      }
    });

    return arabicCount > englishCount;
  }
}
