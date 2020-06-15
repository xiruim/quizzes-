


import 'package:bloc/bloc.dart';
import 'package:quiz/logika/my_repositories.dart';
import 'package:quiz/logika/my_state.dart';

import 'my_event.dart';

class MyBloc extends Bloc<MyEvent, MyState>{
  MyRepositories _myRepositories=MyRepositories();

  MyState get initialState=> InitState();//инициаализируем MyState


  Stream<MyState> mapEventToState(MyEvent event) async*{
    try{
      if(event is RandomLeftEvent){
        int numLeft=_myRepositories.randomLeft(event.numLeft);
        print("my_bloc numL ${numLeft}");
        yield RandomLeftState(numLeft);

      }else if(event is RandomRightEvent){
        int numRight=_myRepositories.randomRight(event.numRight);
        print("my_bloc numL ${numRight}");
        yield RandomRightState(numRight);
      }

    } catch(err){
      yield ErrState(err);
    }
  }
}