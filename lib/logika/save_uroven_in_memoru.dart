import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';


class SaveUrovenInMemoru {
//-------Переменные - Начало-------

int nameLevelInt;

//-------Переменные - Конец-------

  SaveUrovenInMemoru({this.nameLevelInt});

  //---------Функция сохранения пройденного уровня в памяти телефона - Начало----------------

void saveInMemoru(int nameLevelInt) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("Level_completed", nameLevelInt); //сохраняем пройденный уровень в памяти телефона
    print(nameLevelInt);
  }
}