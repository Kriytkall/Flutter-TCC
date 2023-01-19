import 'package:flutter/material.dart';
import 'package:projeto_tcc/widgets/widgets_perfil.dart';
import 'package:projeto_tcc/widgets/card.dart';

class Perfil extends StatefulWidget {
  const Perfil({Key? key}) : super(key: key);

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
            Capa(),
            SizedBox(height: 7),
            Row(
              children: <Widget>[
                Avatar(),
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
            Biografia(),
            CardConto(
              textLabel: 'Conto: JESUS ESTÁ COMIGO',
              imagem: 'assets/images/Rectangle 6.png',
            ),
            CardConto(
              textLabel: 'Conto: JESUS ESTÁ COMIGO',
              imagem: 'assets/images/12.jpg',
            ),
            CardConto(
              textLabel: 'Conto: JESUS ESTÁ COMIGO',
              imagem: 'assets/images/3.jpg',
            ),
            CardConto(
              textLabel: 'Conto: JESUS ESTÁ COMIGO',
              imagem: 'assets/images/8.jpg',
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
