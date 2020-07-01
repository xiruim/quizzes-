import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

//---------------Переменные------Начало
Random random = new Random(); //Для генерации случайных чисел

//---------------Переменные------Конец

class MyProvider{



  //---------Функция сохранения пройденного уровня в памяти телефона - Начало----------------

  saveInMemory(int nameLevelInt) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("Level_completed", nameLevelInt + 1); //открываем следующий уровень и сохраняем в памяти телефона
    print("nameLevelInt ");
    print(nameLevelInt);
  }
  //---------Функция сохранения пройденного уровня в памяти телефона - Конец----------------

  //---------Функция проверки сложности уровня - Начало-------

  slognostLevel(level_of_difficulty) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    level_of_difficulty = pref.getInt("Uroven_slognosti"); //присваеваем переменной уровень сложности

    print("Уровень сложности");
    print(level_of_difficulty);
  }
//---------Функция проверки сложности уровня - Конец-------

  //--------Функция генерации Левых цифр от 0 до 9 - Начало-------
  randomLeft(int value) {
    value = random.nextInt(10); //Генерируем цифры от 0 до 9
    print("my_provider numL ${value} ");
  return value;
  }
//--------Функция генерации Левых цифр от 0 до 9 - Конец-------

  //--------Функция генерации Правых цифр от 0 до 9 - Начало-------
  randomRight( int value) {
    value = random.nextInt(10); //Генерируем цифры от 0 до 9
//    print("my_provider numR ${numRight} ");
    return value;
  }
//--------Функция генерации Правых цифр от 0 до 9 - Конец-------

}