import 'package:flutter/material.dart';
//import 'package:image/image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:quiz/gamelivels.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {



  //----------Текстовые переменные-------------
  String text_appBar_main="Викторина";

//-------Начало ---- При двойном нжтии наа системную кнопку назад - выход из игры-----
//  private static long back_pressed;
//
//  @override
//  public void onBackPressed() {
//    if (back_pressed + 2000 > System.currentTimeMillis()) {
//      super.onBackPressed();
//    } else {
//      Toast.makeText(getBaseContext(), "Нажмите еще раз чтобы выйти!", Toast.LENGTH_SHORT).show();
//    }
//    back_pressed = System.currentTimeMillis();
//  }
//-------Конец ---- При двойном нжтии наа системную кнопку назад - выход из игры-----

  @override
  Widget build(BuildContext context) {

    //----Нчало - Скрывает строку состояния (время, заряд и т.д.)--------
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    //----Конец - Скрывает строку состояния (время, заряд и т.д.)--------


    return Scaffold(

//      appBar: AppBar(
//
//        title: Center(
//          child: Text(
//          text_appBar_main,
//        textAlign: TextAlign.center,
//        textScaleFactor: 1.1,
//        maxLines: 10,
//        style: TextStyle(color: Colors.black,),
//        ),),
//
//      ),
      body: Center(
        child: Stack(

          children: <Widget>[
            Positioned(
              child: Image.asset("assets/main_background.jpg"),
            ),
            Positioned(
              child: Center(
                child: Container(
                width: 250,
                height: 250,
                alignment: Alignment.center,
                //padding: ,
                child: Image.asset("assets/main_img_boy.png"),),),
            ),
            Positioned(
              top: 560,
              left: MediaQuery.of(context).size.width/2-150/2,
              child: Container(
                width: 150,
                height: 50,
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.all(2),
                decoration:
                BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: Colors.white,width: 2,),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),

                child: RaisedButton(
                  elevation: 0.0, //убераем тень
                  color: Colors.transparent,
//                  disabledColor: Colors.transparent,
//                  textColor: Colors.white,
//                  disabledTextColor: Colors.transparent,
//                  padding: EdgeInsets.all(1),

                  child: Text(
                    "НАЧАТЬ",
                    textScaleFactor: 1.5,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.white
                    ),

                  ),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>GameLivels()));
                  },
                ),
              ),
            ),
            

            
          ],
        ),

      ),
    );
  }
}
