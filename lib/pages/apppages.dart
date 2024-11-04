import 'package:get/get.dart';
import 'package:Promoapp/main.dart';
import 'package:Promoapp/pages/cadastroPage.dart';
import 'package:Promoapp/pages/desejosPage.dart';
import 'package:Promoapp/pages/interessesPage.dart';
import 'package:Promoapp/pages/loginPage.dart';
import 'package:Promoapp/pages/myhomepage.dart';
import 'package:Promoapp/pages/user_profile.dart';

class AppPages {
  static final pages = [
    GetPage(name: '/', page: () => AuthCheck()),
    GetPage(name: '/home', page: () => MyHomePage()),
    GetPage(name: '/login', page: () => const LoginPage()),
    GetPage(name: '/cadastro', page: () => const CadastroPage()),
    GetPage(name: '/userProfile', page: () => const UserProfilePage()),
    GetPage(name: '/desejo', page: () => const DesejosPage()),
    GetPage(name: '/interesses', page: () => InteressesPage()),
  ];
}