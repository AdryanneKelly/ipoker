import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:planning_poker_ifood/src/app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:planning_poker_ifood/src/routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo_ipoker.png', width: 200),
                const SizedBox(height: 20),
                Text('Entre na sua conta', style: GoogleFonts.nunito(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Campo obrigatório';
                    } else if (!value.contains('@')) {
                      return 'Email inválido';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: passwordController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Senha',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is LoginAuthFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(
                            state.message,
                            style: GoogleFonts.nunito(color: Colors.white),
                          )));
                    }
                    if (state is LoginAuthSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.green,
                          content: Text(
                            'Login realizado com sucesso',
                            style: GoogleFonts.nunito(color: Colors.white),
                          )));
                      router.go('/home');
                    }
                  },
                  builder: (context, state) {
                    if (state is LoginAuthLoading) {
                      return const CircularProgressIndicator();
                    }
                    return ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          authBloc.add(LoginAuthEvent(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          ));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: Colors.red,
                      ),
                      child: const Text('Entrar', style: TextStyle(fontSize: 16, color: Colors.white)),
                    );
                  },
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    router.go('/register');
                  },
                  child: const Text('Não tem uma conta? Cadastre-se', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
