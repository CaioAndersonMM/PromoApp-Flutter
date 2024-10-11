import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _login() async {
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
      Get.snackbar(
        'Sucesso',
        'Login efetuado com sucesso!',
        backgroundColor: const Color.fromARGB(255, 3, 41, 117),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        borderRadius: 10,
        margin: const EdgeInsets.all(10),
      );
      Get.offNamed('/home');
    } else {
      Get.snackbar(
        'Erro', 'Usuário ou senha inválidos!',
        backgroundColor: const Color.fromARGB(255, 3, 41, 117),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        borderRadius: 10,
        margin: const EdgeInsets.all(10),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Efetue o login no PromoApp',
            style: TextStyle(
                color: Color.fromRGBO(4, 20, 53, 1),
                fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      backgroundColor: const Color.fromRGBO(0, 12, 36, 1),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            const Text(
              "As melhores ofertas e promoções estão esperando por você, não fique de fora!",
              style: TextStyle(color: Colors.white, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
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
            const SizedBox(height: 50),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(
                    double.infinity, 50), // Largura máxima e altura fixa
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(15), // Raio de borda menor
                ),
              ),
              onPressed: _login,
              child: const Text('Login',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 30),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: "Não possui uma conta? ",
                style: const TextStyle(color: Colors.white, fontSize: 18),
                children: <TextSpan>[
                  TextSpan(
                    text: "Cadastre-se!",
                    style: const TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Get.toNamed('/cadastro');
                      },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
