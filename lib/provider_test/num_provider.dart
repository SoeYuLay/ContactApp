import 'package:flutter/cupertino.dart';

class NumProvider extends ChangeNotifier{
  int num = 0;

  void minus(){
    if(num>0){
      num--;
    }
    notifyListeners();
  }

  void plus(){
    num++;
    notifyListeners();
  }
}