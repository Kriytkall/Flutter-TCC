import 'package:flutter/material.dart';
import 'package:projeto_tcc/pages/pegar_card.dart';
import 'package:projeto_tcc/widgets/widgets_perfil.dart';
import 'package:projeto_tcc/widgets/card.dart';

class Perfil extends StatefulWidget {
  const Perfil({Key? key, required String idUser}) : super(key: key);

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const Capa(),
            const SizedBox(height: 7),
            Row(
              children: <Widget>[
                Flexible(child: Avatar()),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    Nome(),
                    SizedBox(height: 10),
                    Seguidores(),
                  ],
                ),
              ],
            ),
            const Biografia(),
            const PegarCard(idUser: ''),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
