import 'package:get_storage/get_storage.dart';

class LocalStorage{
  void setLoginTrue(){
    GetStorage().write('isLoggedIn', true);
  }

  void setLoginFalse(){
    GetStorage().write('isLoggedIn', false);
  }

  bool isLoggedIn(){
    bool? status =  GetStorage().read('isLoggedIn');
    if(status==null){return false;}
    return status;
  }

  void setDarkMode(){
    GetStorage().write('isDarkMode', true);
  }

  void setLightMode(){
    GetStorage().write('isDarkMode', false);
  }

  bool isDarkMode(){
    bool? isDark = GetStorage().read('isDarkMode');
    if(isDark==null){return false;}
    return isDark;
  }
}


