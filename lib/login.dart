import 'package:flutter/material.dart';
import 'services/auth_service.dart';
import 'home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final usuarioController = TextEditingController();
  final senhaController = TextEditingController();

  final AuthService authService = AuthService();

  bool carregando = false;

  Future<void> entrar() async {
    if (usuarioController.text.isEmpty ||
        senhaController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Preencha o usuário e a senha.',
          ),
        ),
      );

      return;
    }

    setState(() {
      carregando = true;
    });

    bool resultado = await authService.login(
      usuarioController.text,
      senhaController.text,
    );

    if (!mounted) {
      return;
    }

    setState(() {
      carregando = false;
    });

    if (resultado) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Home(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Acesso negado. Usuário ou senha incorretos.',
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    usuarioController.dispose();
    senhaController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login',
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            const Icon(
              Icons.lock,
              size: 80,
            ),

            const SizedBox(height: 20),

            const Text(
              'Entrar',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            TextField(
              controller: usuarioController,
              decoration: const InputDecoration(
                labelText: 'Usuário',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: senhaController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                onPressed: carregando ? null : entrar,

                child: carregando
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(),
                      )
                    : const Text(
                        'Entrar',
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

