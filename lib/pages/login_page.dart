import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_loading/cubits/cubit/login_cubit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email = '';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.pushNamed(context, '/loading',
              arguments: 'Buscando dados do usuário...')
          .then((value) {
        if (value == 'success') {
          Navigator.pushNamed(context, '/');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Erro ao carregar os dados do usuário.'),
          ));
        }
      });
      // Simulando um carregamento bem-sucedido após 3 segundos
      Future.delayed(const Duration(seconds: 6), () {
        // Simulação de sucesso no carregamento
        Navigator.pop(context, 'success');
      });
      debugPrint('Email: $_email');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.loginStatus == LoginStatus.loading) {
            Navigator.pushNamed(context, '/loading',
                    arguments: 'Buscando dados do usuário...')
                .then((value) {
              if (value == 'success') {
                Navigator.pushNamed(context, '/');
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Erro ao carregar os dados do usuário.'),
                ));
              }
            });
            context
                .read<LoginCubit>()
                .login()
                .then((value) => Navigator.pop(context, 'success'))
                .catchError((err) {
              Navigator.pop(context, 'error');
            });
          }
          if (state.loginStatus == LoginStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Erro ao carregar os dados do usuário.'),
            ));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, insira um email';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _email = value!;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    context.read<LoginCubit>().callLoadingPage();
                  },
                  child: const Text('Entrar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
