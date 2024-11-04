import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Promoapp/services/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  AuthService authServ = AuthService();

  void _loginConvidado() {
    Get.offNamed('/home');

    Get.snackbar(
      'Logado como convidado!',
      'Para uma melhor experiência, faça login com sua conta!',
      backgroundColor: const Color.fromARGB(255, 3, 41, 117),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      borderRadius: 10,
      margin: const EdgeInsets.all(10),
    );
  }

  Future<void> _login() async {
    
    String message = await authServ.logarUsuario(
      email: emailController.text,
      password: passwordController.text,
    );

    if (message == '') {
      Get.offNamed('/home');
    } else {
      Get.snackbar('Erro', message,
        backgroundColor: const Color.fromARGB(255, 3, 41, 117),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
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
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Image.asset(
          //   'assets/background.jpg', // Adicione sua imagem de fundo aqui
          //   fit: BoxFit.cover,
          // ),
          Container(
            color: const Color.fromRGBO(0, 12, 36, 1),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width *
                          0.89, // 90% da largura da tela
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          backgroundColor:
                              const Color.fromARGB(255, 31, 57, 114),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          shadowColor: const Color.fromARGB(118, 3, 13, 196),
                          elevation: 5,
                        ),
                        onPressed: _loginConvidado,
                        child: const Text(
                          'Entrar como convidado',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      color: const Color.fromARGB(255, 255, 255, 255),
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const Text(
                              "As melhores ofertas e promoções estão esperando por você, não fique de fora!",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 12, 14, 126),
                                  fontSize: 15),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 40),
                            TextField(
                              controller: emailController,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle: const TextStyle(
                                    color: Color.fromRGBO(3, 10, 24, 1)),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Color.fromRGBO(3, 10, 24, 1)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: Colors.blue),
                                ),
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.1),
                              ),
                              style: const TextStyle(color: Colors.black),
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              controller: passwordController,
                              decoration: InputDecoration(
                                labelText: 'Senha',
                                labelStyle: const TextStyle(
                                    color: Color.fromRGBO(3, 10, 24, 1)),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Color.fromRGBO(3, 10, 24, 1)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: Colors.blue),
                                ),
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.1),
                              ),
                              obscureText: true,
                            ),
                            const SizedBox(height: 30),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 50),
                                backgroundColor:
                                    const Color.fromARGB(255, 3, 41, 117),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                shadowColor:
                                    const Color.fromARGB(118, 3, 13, 196),
                                elevation: 5,
                              ),
                              onPressed: _login,
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 255, 255, 255)),
                              ),
                            ),
                            const SizedBox(height: 20),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text: "Não possui uma conta? ",
                                style: const TextStyle(
                                    color: Color.fromRGBO(0, 12, 36, 1),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: "Cadastre-se!",
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 33, 106, 165),
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
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
