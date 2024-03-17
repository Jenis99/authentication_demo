import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../modules/google_home_page.dart';

class GoogleController extends GetxController{
  GoogleSignIn googleSignIn = GoogleSignIn();

  googleLogin()async{
   try{
    var result = await googleSignIn.signIn();

    if(result != null){
      Get.to(()=>const HomePage());
    }
    print(result);
    print(result!.email);
    print(result.displayName);
    print(result.photoUrl);
   }   catch(e){
     print("ERROR----->>e");
   }
 }
// ((1-->Create project google cloud console ))------------------>
//---->google cloud console---->select project[google cloud ni bajuma left side]---->new project-->name ---->create---->select

// ((2-->Create pop up google menu ))------------------>
// --->search oauth consent screen--->select------>select external--->name---->gmail---->developer gmail-->next next-->create-->back to dashboard

// ((3-->credential create-connect flutter app with package and sha key))------------------>
//---->credential create--->select app type-like android--package name--->sha key
 googleLogOut()async{
    GoogleSignIn googleSignIn = GoogleSignIn();
    try{
      googleSignIn.signOut();
      print("-----------LogOut");
    }
    catch(e){
      print("ERROR::::$e");
    }
 }

}