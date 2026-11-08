import 'package:flutter/material.dart';
import 'package:mi_primera_app/features/auth/services/auth_service.dart';
import 'package:mi_primera_app/features/auth/widgets/custom_text_field.dart';
import 'package:mi_primera_app/features/home/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  void _iniciarSesion() async {
    setState(() {
      _isLoading = true;
    });

    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    final success = await _authService.login(username, password);

    setState(() {
      _isLoading = false;
    });

    if (!mounted) return;

    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MyHomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Credenciales incorrectas o error al conectar')),
      );
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'FitTrack Pro',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              CustomTextField(controller: _usernameController, label: "Usuario"),
              const SizedBox(height: 16),
              CustomTextField(controller: _passwordController, label: "Contraseña"),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _isLoading ? null : _iniciarSesion,
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Iniciar Sesión'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
