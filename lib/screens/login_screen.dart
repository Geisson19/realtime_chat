import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime_chat/helpers/show_alert.dart';
import 'package:realtime_chat/service/services.dart';
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
    final authService = Provider.of<AuthService>(context);

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
            onPressed: authService.isLoading
                ? null
                : () async {
                    FocusScope.of(context).unfocus();

                    bool loginOk = await authService.login(
                        _emailController.text.trim(),
                        _passwordController.text.trim());

                    if (loginOk) {
                      // ignore: use_build_context_synchronously
                      Navigator.pushReplacementNamed(context, '/users');
                    } else {
                      // ignore: use_build_context_synchronously
                      showAlert(context, "Login incorrecto",
                          "Email o contraseña incorrectos");
                    }
                  },
            text: authService.isLoading ? "Cargando..." : "Ingresar",
          ),
          // ElevatedButton(onPressed: () {}, child: const Text("Login")),
        ],
      ),
    );
  }
}
