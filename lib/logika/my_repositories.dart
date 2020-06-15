

import 'package:quiz/logika/my_provider.dart';

class MyRepositories{
  MyProvider _myProvider=MyProvider();//вызываем провайдер
  int randomLeft(int numLeft)=>_myProvider.randomLeft(numLeft);
  int randomRight(int numRight)=>_myProvider.randomRight(numRight);

  @override
  String toString() {
    // TODO: implement toString
    print("my_repositories numL/R ");

  }


}