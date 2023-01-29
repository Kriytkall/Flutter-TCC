import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'chegagem_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firebaseAuth = FirebaseAuth.instance;

  late String _uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastro Page"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          TextFormField(
            controller: _nomeController,
            decoration: const InputDecoration(
              label: Text("Nome Completo"),
            ),
          ),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              label: Text("E-mail"),
            ),
          ),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(
              label: Text("Senha"),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              cadastrar();
            },
            child: const Text("Cadastrar"),
          ),
        ],
      ),
    );
  }

  cadastrar() async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      userCredential.user!.updateDisplayName(_nomeController.text);
      final User? user = userCredential.user;
      _uid = user!.uid;
      FirebaseFirestore.instance.collection("Usuarios").doc(_uid).set({
        "nome": _nomeController.text,
        "email": _emailController.text,
        "imagem_capa": "",
        "imagem_perfil": "",
        "biografia": "",
        "uid": _uid,
      });

      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const ChecagemPage(),
          ),
          (route) => false);
    } on FirebaseException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Crie uma senha mais forte'),
            backgroundColor: Colors.redAccent,
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email ja cadastrado'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }
}
