import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CadastroPage extends StatefulWidget {
  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController userController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final List<String> cities = [
    'Mossoró',
    'Natal',
    'Jucurutu',
    'Campina Grande'
  ];
  String selectedCity = 'Mossoró';

  Future<void> _register() async {
    // try {
    //   UserCredential userCredential = await _auth.signInWithEmailAndPassword(
    //     email: emailController.text,
    //     password: passwordController.text,
    //   );
    //   // Autenticação bem-sucedida, redireciona para a página inicial
    //   Get.offNamed('/home');
    // } catch (e) {
    //   Get.snackbar('Erro de login', 'Falha na autenticação: $e');
    // }

    if (emailController.text == 'admin' && passwordController.text == 'admin') {
      Get.snackbar('Sucesso', 'Login efetuado com sucesso!',  backgroundColor: const Color.fromARGB(255, 3, 41, 117),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        borderRadius: 10,
        margin: const EdgeInsets.all(10),);
      Get.offNamed('/home');
    } else {
      Get.snackbar('Erro', 'Usuário ou senha inválidos!',  backgroundColor: const Color.fromARGB(255, 3, 41, 117),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        borderRadius: 10,
        margin: const EdgeInsets.all(10),);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastre-se no PromoApp',
            style: TextStyle(
                color: Color.fromRGBO(4, 20, 53, 1),
                fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      backgroundColor: const Color.fromRGBO(0, 12, 36, 1),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            const Text(
              "Realize agora mesmo seu cadastro e aproveite as melhores ofertas e promoções!",
              style: TextStyle(color: Colors.white, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: userController,
                    decoration: const InputDecoration(
                      labelText: 'Nome de usuário',
                      labelStyle: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedCity,
                    decoration: const InputDecoration(
                      labelText: 'Cidade',
                      labelStyle: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    dropdownColor: Colors.blueGrey,
                    style: const TextStyle(color: Colors.white),
                    items: cities.map((String city) {
                      return DropdownMenuItem<String>(
                        value: city,
                        child: Text(city),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      selectedCity = newValue!;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                  labelText: 'Telefone',
                  labelStyle: TextStyle(color: Colors.white, fontSize: 18)),
              keyboardType: TextInputType.phone,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.white, fontSize: 18)),
              // ignore: prefer_const_constructors
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                  labelText: 'Senha',
                  labelStyle: TextStyle(color: Colors.white, fontSize: 18)),
              obscureText: true,
            ),
            const SizedBox(height: 80),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: const Color.fromARGB(255, 3, 41, 117),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                shadowColor: const Color.fromARGB(118, 3, 13, 196),
                elevation: 5,
              ),
              onPressed: _register,
              child: const Text(
                'Cadastrar',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 255, 255, 255)),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
