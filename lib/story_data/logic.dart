import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoryDataLogic extends GetxController {

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String? selectedGenre;
  final formKey = GlobalKey<FormState>();

  bool showGenreError=false;
  bool isLoading=false;




  showGenreErr(){
    showGenreError=true;
  }
  hideGenreErr(){
    showGenreError=false;
  }
  final List<String> genres = [
    'Fantasy',
    'Sci-Fi',
    'Mystery',
    'Thriller',
    'Romance',
    'Horror',
    'Adventure',
  ];

  selectGenre(String newGenre) {
    selectedGenre = newGenre;
    update();
  }
}
