import 'package:flutter/material.dart';
import 'package:realtime_chat/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF2F2F2),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Logo(titulo: "Messenger"),
                  _Form(),
                  Labels(
                    auxText: "¿No tienes una cuenta?",
                    text: "¡Crea una ahora!",
                    route: '/register',
                  ),
                  Terms(),
                ],
              ),
            ),
          ),
        ));
  }
}

class _Form extends StatefulWidget {
  const _Form({Key? key}) : super(key: key);

  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          CustomInput(
              icon: Icons.person,
              hintText: "Correo",
              keyboardType: TextInputType.emailAddress,
              controller: _emailController),
          const SizedBox(height: 20),
          CustomInput(
            icon: Icons.lock,
            hintText: "Contraseña",
            obscureText: true,
            controller: _passwordController,
          ),
          const SizedBox(height: 40),
          CustomButton(
            onPressed: () {
              // TODO POST login to server
              print("Login");
              print(_emailController.text);
              print(_passwordController.text);
            },
            text: "Ingresar",
          ),
          // ElevatedButton(onPressed: () {}, child: const Text("Login")),
        ],
      ),
    );
  }
}
