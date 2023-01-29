import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeto_tcc/models/User.dart';
import 'package:projeto_tcc/pages/pegar_card.dart';
import 'package:projeto_tcc/widgets/widgets_perfil_user.dart';

class PerfilUser extends StatelessWidget {
  PerfilUser({Key? key, required this.idUser});
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final String idUser;
  late User userData;

  Future<User> _getUserData() async {
    final userDocument =
        await firestore.collection('Usuarios').doc(idUser).get();

    return User(
      uid: userDocument.data()!['uid'],
      nome: userDocument.data()!['nome'],
      biografia: userDocument.data()!['biografia'],
      email: userDocument.data()!['email'],
      imagem_capa: userDocument.data()!['imagem_capa'],
      imagem_perfil: userDocument.data()!['imagem_perfil'],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _getUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          userData = snapshot.data as User;

          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Capa(imgCapa: userData.imagem_capa),
                  const SizedBox(height: 7),
                  Row(
                    children: <Widget>[
                      Flexible(
                          child: Avatar(avatarUrl: userData.imagem_perfil)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Nome(name: userData.nome),
                          const SizedBox(height: 10),
                          const Seguidores(),
                        ],
                      ),
                    ],
                  ),
                  Biografia(biografia: userData.biografia),
                  PegarCard(idUser: userData.uid),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
