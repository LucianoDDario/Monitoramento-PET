import 'package:flutter/material.dart';

class RecuperarSenha extends StatefulWidget {
  const RecuperarSenha({super.key});

  @override
  State<RecuperarSenha> createState() => _RecuperarSenhaEstado();
}

class _RecuperarSenhaEstado extends State<RecuperarSenha> {
  final _chaveFormulario = GlobalKey<FormState>();
  final _controleEmail = TextEditingController();
  bool _emailValido = false;

  @override
  void initState() {
    super.initState();
    _controleEmail.addListener(() {
      final texto = _controleEmail.text;
      final valido = _verificarEmail(texto);
      if (valido != _emailValido) {
        setState(() => _emailValido = valido);
      }
    });
  }

  @override
  void dispose() {
    _controleEmail.dispose();
    super.dispose();
  }

  bool _verificarEmail(String valor) {
    final regex = RegExp(r"^[^\s@]+@[^\s@]+\.[^\s@]{2,}$");
    return regex.hasMatch(valor.trim());
  }

  void _enviar() {
    FocusScope.of(context).unfocus();
    if (_chaveFormulario.currentState?.validate() ?? false) {
      Navigator.pushNamed(context, '/inserir_codigo');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD02670),
      body: Center(
        child: Container(
          width: 320,
          height: 290,
          decoration: const BoxDecoration(color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _chaveFormulario,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/images/Pets.png',
                        width: 24,
                        height: 24,
                        errorBuilder: (context, erro, pilha) =>
                            const Icon(Icons.pets, size: 24),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Pets',
                        style: TextStyle(fontSize: 24, color: Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Recuperar senha',
                    style: TextStyle(fontSize: 28, color: Colors.black),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Digite seu e-mail para recuperar a senha',
                    style: TextStyle(fontSize: 14, color: Color(0xFF525252)),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'E-mail',
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  const SizedBox(height: 6),
                  SizedBox(
                    width: 288,
                    height: 32,
                    child: TextFormField(
                      controller: _controleEmail,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'Insira seu e-mail',
                        isDense: true,
                        filled: true,
                        fillColor: Color(0xFFF5F5F5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 6,
                        ),
                      ),
                      validator: (valor) {
                        if (valor == null || valor.trim().isEmpty) {
                          return 'Informe seu e-mail';
                        }
                        if (!_verificarEmail(valor)) {
                          return 'E-mail inválido';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      SizedBox(
                        width: 139,
                        height: 32,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFFD02670),
                            backgroundColor: Colors.white,
                            side: const BorderSide(
                              color: Color(0xFFBDBDBD),
                              width: 1,
                            ),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                            padding: EdgeInsets.zero,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text('    Voltar            '),
                              Icon(Icons.arrow_back, size: 20),
                              SizedBox(width: 20),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 139,
                        height: 32,
                        child: ElevatedButton(
                          onPressed: _emailValido ? _enviar : null,
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: const Color(0xFFD02670),
                            disabledBackgroundColor: const Color(0xFFEB8FB2),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                            padding: EdgeInsets.zero,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text('Enviar'),
                              SizedBox(width: 30),
                              Icon(Icons.arrow_forward, size: 20),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
