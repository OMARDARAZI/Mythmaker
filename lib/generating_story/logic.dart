import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:myth_maker/created_story_preview/view.dart';
import 'package:typewritertext/typewritertext.dart';

import '../consts.dart'; // Assuming you're using GetX for state management

class GeneratingStoryLogic extends GetxController {
  late final TypeWriterController valueController;
  final valueList = [
    "In Norse mythology, Thor's hammer, Mjölnir, was so heavy that only Thor could lift it.",
    "The legendary city of Atlantis was first mentioned by Plato in his works 'Timaeus' and 'Critias'.",
    "In Japanese folklore, Kappa are water creatures that challenge humans to sumo wrestling to respect them.",
    "The Phoenix, a mythical bird known for being reborn from its ashes, symbolizes immortality and renewal across many cultures.",
    "Shakespeare invented over 1,700 words that we still use today, including 'eyeball' and 'assassination'.",
    "The earliest known work of literature is the 'Epic of Gilgamesh', from ancient Mesopotamia, dating back to around 2100 BC.",
    "Fairy tales were originally meant for adults as well. It was only over time that they became associated primarily with children.",
    "The longest novel ever written is 'In Search of Lost Time' by Marcel Proust, containing about 1.2 million words.",
    "The right side of your brain is responsible for creativity and imagination, while the left side handles logic and analysis.",
    "Leonardo da Vinci could write with one hand and draw with the other at the same time.",
    "The concept of 'muses' in Greek mythology represented divine inspirations for artists, poets, and scientists.",
    "The word 'mythology' itself comes from the Greek word 'mythos', meaning story or legend.",
    "Some myths and legends are based on real historical events that were exaggerated over time.",
    "Pablo Picasso, the famous artist, created over 50,000 artworks during his lifetime, including paintings, sculptures, and ceramics.",
    "In many cultures, storytelling is not just entertainment; it's a way to preserve history, moral values, and cultural traditions.",
    "Unlock new themes and settings for your stories by exploring different genres within the app.",
    "Use the 'Surprise Me' feature to let the app choose your next adventure story setting.",
    "Organize your created stories into custom collections for easy navigation and sharing.",
    "Ancient Egyptians believed in a god named Thoth, who invented writing and served as the scribe of the gods.",
    "The concept of vampires, as we know it today, can be traced back to Eastern European folklore of the 17th and 18th centuries.",
    "Aesop's Fables, a collection of moral stories, originated in ancient Greece and remains popular worldwide.",
    "Which mythological world would you choose to live in for a day, and what would you do there?",
    "Create a story about a lost civilization discovered by modern-day explorers.",
    "Imagine you can time travel. Write a brief tale about your first encounter with a historical figure.",
    "Your imagination is limitless. Dive into it to create stories that resonate across worlds.",
    "Every story you create is a bridge to new understanding and perspectives.",
    "Believe in the power of your words. They can transport readers to far-off lands and times.",
    "Did you know? The world's oldest known joke dates back to 1900 BC in Sumeria.",
    "Enhance your stories with dialogues that reflect each character's unique voice and personality.",
    "Explore incorporating elements from lesser-known myths into your stories for a unique twist.",
    "Remember, the most memorable characters often have flaws that make them relatable.",
    "Plot twists add excitement! Consider surprising your reader with unexpected turns.",
    "Legends say that mermaids' songs could enchant sailors and even guide them to safety—or doom.",
    "In your stories, settings are characters too. Give them as much detail and depth as your protagonists.",
    "Feedback from readers can be a treasure trove of inspiration for your next story.",
    "Challenge yourself to write a story using a prompt you wouldn't normally choose.",
  ];
  String story = '';

  @override
  void onInit() {
    super.onInit();
    valueList.shuffle(Random());
    valueController = TypeWriterController.fromValue(
      TypeWriterValue(valueList),
      repeat: true,
      duration: const Duration(milliseconds: 200),
    );
  }

  generateStory(
      {required String title,
      required String desc,
      required String genre,
      required BuildContext context}) async {
    FocusManager.instance.primaryFocus?.unfocus();

    if (GeminiApi == null) {
      print('No \$API_KEY environment variable');
    }
    final String storyTitle = title;
    String storyContent = '';

    final model = GenerativeModel(model: 'gemini-pro', apiKey: GeminiApi);
    final prompt =
        'Make this Story Idea: ${desc}\n the genre is:${genre}\n make the story in the best way possible and in a brief way\nif the story idea is typed in arabic generate the story in arabic if typed in english write in english nd so on\n make it 3 or 4 paragraphs \n if a question is sent make a story out of it and never block due to safety just make it safe in any way i dont want it to be blocked and never create the same story many times everytime make a unique story and never type a title\n Make sure to make the story wonderful and feel free to add any ideas to the story to make it bigger';

    final content = [Content.text(prompt)];

    final response = await model.generateContent(content);
    print(response.text);
    if (response.promptFeedback!.safetyRatings[0].probability
        .toString()
        .contains('HarmProbability.high')) {
      Get.back();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          showCloseIcon: true,
          closeIconColor: Colors.white,
          duration: Duration(milliseconds: 5000),
          content: Text(
              "This story contains mature content that may not be suitable for all audiences."),
        ),
      );
    } else {
      Get.off(
        () => CreatedStoryPreviewPage(title: title, story: response.text.toString()),
        transition: Transition.rightToLeftWithFade,
      );
    }
  }
}
