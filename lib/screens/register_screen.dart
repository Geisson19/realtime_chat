import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime_chat/helpers/show_alert.dart';
import 'package:realtime_chat/service/auth_service.dart';
import 'package:realtime_chat/widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

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
                  Logo(titulo: "Registro"),
                  _Form(),
                  Labels(
                    auxText: "¿Ya tienes cuenta?",
                    text: "Ingresa aquí",
                    route: '/login',
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
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final AuthService authService = Provider.of<AuthService>(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          CustomInput(
            hintText: "Nombre",
            icon: Icons.person,
            controller: _nameController,
          ),
          const SizedBox(height: 20),
          CustomInput(
              icon: Icons.email,
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
                      final bool signUpOk = await authService.signUp(
                          _nameController.text,
                          _emailController.text,
                          _passwordController.text);

                      if (signUpOk) {
                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacementNamed(context, '/users');
                      } else {
                        // ignore: use_build_context_synchronously
                        showAlert(context, "Registro inválido",
                            AuthService.errorMessage);
                      }
                    },
              text: authService.isLoading ? "Cargando..." : "Crear cuenta"),
          // ElevatedButton(onPressed: () {}, child: const Text("Login")),
        ],
      ),
    );
  }
}
