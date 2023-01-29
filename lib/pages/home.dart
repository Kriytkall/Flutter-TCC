import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../chegagem_page.dart';
import '../widgets/card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _firebaseAuth = FirebaseAuth.instance;
  String nome = '';
  String email = '';

  @override
  Widget build(BuildContext context) {
    /*pegarUsuario();*/
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(nome),
              accountEmail: Text(email),
            ),
            ListTile(
              dense: true,
              title: const Text("Sair"),
              trailing: Icon(Icons.exit_to_app),
              onTap: () {
                sair();
              },
            ),
            ListTile(
              dense: true,
              title: const Text("Excluir Conta"),
              trailing: const Icon(Icons.delete_forever),
              onTap: () {
                deletarConta();
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Home Page"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Contos')
                  .orderBy("data_criacao", descending: true)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Algo deu errado: ${snapshot.error}');
                }
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                final List<DocumentSnapshot> contos = snapshot.data!.docs;
                return Column(
                  children: List.generate(
                    contos.length,
                    (index) {
                      final conto = contos[index];
                      return CardConto(
                        textLabel: conto.get('titulo').toString(),
                        imagem: conto.get('imageUrl').toString(),
                        idUser: conto.get('uid').toString(),
                      );
                    },
                  ),
                );
              },
            ),
            SizedBox(
              height: 80,
            ),
          ],
        ),
      ),
    );
  }

  /*pegarUsuario() async {
    User? usuario = _firebaseAuth.currentUser;
    if (usuario != null) {
      setState(() {
        nome = usuario.displayName!;
        email = usuario.email!;
      });
    }
  }*/

  sair() async {
    await _firebaseAuth.signOut().then(
          (user) => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const ChecagemPage(),
            ),
          ),
        );
  }

  void deletarConta() async {
    final user = await _firebaseAuth.currentUser;
    if (user != null) {
      try {
        await user.delete();
        print("Conta deletada com sucesso");
      } catch (error) {
        print("Erro ao deletar conta: $error");
      }
    }
    await _firebaseAuth.signOut();
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const ChecagemPage(),
      ),
    );
  }
}
