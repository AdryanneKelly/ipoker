import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:planning_poker_ifood/src/app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:planning_poker_ifood/src/routes.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nameController = TextEditingController();
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
                Text('Cadastre-se', style: GoogleFonts.nunito(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                TextFormField(
                  controller: nameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                    border: OutlineInputBorder(),
                  ),
                ),
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
                    } else if (value.length < 6 && !value.contains(RegExp(r'[0-9]'))) {
                      return 'Senha deve ter no mínimo 6 caracteres, com letras e números';
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
                    if (state is RegisterAuthFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(
                            state.message,
                            style: GoogleFonts.nunito(color: Colors.white),
                          )));
                    }
                    if (state is RegisterAuthSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.green,
                          content: Text(
                            'Usuário cadastrado com sucesso',
                            style: GoogleFonts.nunito(color: Colors.white),
                          )));
                      router.go('/home');
                    }
                  },
                  builder: (context, state) {
                    if (state is RegisterAuthLoading) {
                      return const CircularProgressIndicator();
                    }
                    return ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          authBloc.add(RegisterAuthEvent(
                            name: nameController.text.trim(),
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          ));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: Colors.red,
                      ),
                      child: const Text('Cadastrar', style: TextStyle(fontSize: 16, color: Colors.white)),
                    );
                  },
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {},
                  child: const Text('Já tem uma conta? Faça login', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
