import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class SaveUrovenInMemoru extends StatefulWidget {

  _SaveUrovenInMemoruState saveUrovenInMemoruState = new _SaveUrovenInMemoruState();
  @override
  _SaveUrovenInMemoruState createState() => _SaveUrovenInMemoruState();
  void saveInMemory(nameLevelInt){
    saveUrovenInMemoruState.saveInMemory(nameLevelInt);
  }

  void slognostLevel(level_of_difficulty){
    saveUrovenInMemoruState.slognostLevel(level_of_difficulty);
  }
}

class _SaveUrovenInMemoruState extends State<SaveUrovenInMemoru> {

  //---------Функция сохранения пройденного уровня в памяти телефона - Начало----------------
  @override
  void saveInMemory(nameLevelInt) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("Level_completed", nameLevelInt + 1); //открываем следующий уровень и сохраняем в памяти телефона
    print("nameLevelInt ");
    print(nameLevelInt);
  }
  //---------Функция сохранения пройденного уровня в памяти телефона - Конец----------------

  //---------Функция проверки сложности уровня - Начало-------
  @override
  void slognostLevel(level_of_difficulty) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    level_of_difficulty = pref.getInt("Uroven_slognosti"); //присваеваем переменной уровень сложности

    print("Уровень сложности");
    print(level_of_difficulty);
  }
  //---------Функция проверки сложности уровня - Конец-------



  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
