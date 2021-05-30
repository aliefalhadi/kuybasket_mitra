import 'package:flutterstarter/provider/BaseProvider.dart';

class HomeProvider extends BaseProvider {
  int counter;

  void main(){
    counter = 0;
  }

  void incrementCounter() {
      counter++;
      notifyListeners();
  }
}