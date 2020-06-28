

import 'package:quiz/logika/my_provider.dart';

class MyRepositories{
  MyProvider _myProvider=MyProvider();//вызываем провайдер
  int randomLeftRepos(int numLeftreposit)=>_myProvider.randomLeft(numLeftreposit);
  int randomRightRepos(int numRight)=>_myProvider.randomRight(numRight);




//  @override
//  String toString() {
//    // TODO: implement toString
//    print("my_repositories numL/R ");
//
//  }


}