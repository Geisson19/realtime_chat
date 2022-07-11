import 'package:flutter/material.dart';
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
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
          const SizedBox(height: 20),
          CustomInput(
            icon: Icons.lock,
            hintText: "Confirmar contraseña",
            obscureText: true,
            controller: _confirmPasswordController,
          ),
          const SizedBox(height: 40),
          CustomButton(
            onPressed: () {
              // TODO Login with email and password
            },
            text: "Crear cuenta",
          ),
          // ElevatedButton(onPressed: () {}, child: const Text("Login")),
        ],
      ),
    );
  }
}
