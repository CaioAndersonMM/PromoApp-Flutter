import 'package:get/get.dart';
import 'package:meu_app/main.dart';
import 'package:meu_app/pages/cadastroPage.dart';
import 'package:meu_app/pages/desejosPage.dart';
import 'package:meu_app/pages/interessesPage.dart';
import 'package:meu_app/pages/loginPage.dart';
import 'package:meu_app/pages/myhomepage.dart';
import 'package:meu_app/pages/user_profile.dart';

class AppPages {
  static final pages = [
    GetPage(name: '/', page: () => AuthCheck()),
    GetPage(name: '/home', page: () => MyHomePage()),
    GetPage(name: '/login', page: () => LoginPage()),
    GetPage(name: '/cadastro', page: () => CadastroPage()),
    GetPage(name: '/userProfile', page: () => const UserProfilePage()),
    GetPage(name: '/desejo', page: () => const DesejosPage()),
    GetPage(name: '/interesses', page: () => InteressesPage()),
  ];
}