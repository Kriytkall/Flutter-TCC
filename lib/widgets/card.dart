import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_tcc/pages/perfil_user.dart';

class CardConto extends StatefulWidget {
  final String textLabel;
  final String imagem;
  final String idUser;
  CardConto({
    Key? key,
    required this.textLabel,
    required this.imagem,
    required this.idUser,
  }) : super(key: key);

  @override
  State<CardConto> createState() => _CardContoState();
}

class _CardContoState extends State<CardConto> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  late String nomeUsuario = '';
  late String imagemUrl = '';

  Future<void> _getUserData() async {
    var userDocument =
        await firestore.collection('Usuarios').doc(widget.idUser).get();
    if (userDocument.exists) {
      nomeUsuario = userDocument.data()!['nome'];
      imagemUrl = userDocument.data()!['imagem_perfil'];
    } else {
      nomeUsuario = 'Não encontrado';
      imagemUrl = 'Não encontrado';
    }
  }

  Widget userId() {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PerfilUser(idUser: widget.idUser),
        ),
      ),
      child: FutureBuilder<void>(
          future: _getUserData(),
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  //------------------------ CIRCLEAVATAR ---------------------------
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 10,
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12, left: 8),
                          child: Container(
                            width: 40,
                            height: 40,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(imagemUrl),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 12,
                            bottom: 10,
                          ),
                          child: Text(
                            nomeUsuario,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //--------------------- FIM AVATAR -------------------------
                  const IconsTopCard(),
                ],
              );
            } else {
              return const CircularProgressIndicator();
            }
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        height: 400,
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0, -4),
            ),
          ],
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //------------------------- CAPA CARD --------------------------
            Padding(
              padding: const EdgeInsets.only(
                right: 12,
                left: 12,
                top: 10,
              ),
              child: Container(
                width: double.infinity,
                height: 260,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                      image: NetworkImage(widget.imagem), fit: BoxFit.cover),
                ),
              ),
            ),
            //-------------------------- FIM CAPA -------------------------
            //------------------------ CARD RESUMO ------------------------
            SizedBox(
              width: 500,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 14, right: 14, top: 10, bottom: 10),
                child: Text(
                  widget.textLabel,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
            userId(),
          ],
        ),
      ),
    );
  }
}

class IconsTopCard extends StatefulWidget {
  const IconsTopCard({Key? key}) : super(key: key);

  @override
  State<IconsTopCard> createState() => _IconsTopCardState();
}

class _IconsTopCardState extends State<IconsTopCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 10,
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite_border_rounded),
            iconSize: 22,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.bookmark_border_outlined),
            iconSize: 22,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.share_outlined),
            iconSize: 22,
          ),
        ],
      ),
    );
  }
}
