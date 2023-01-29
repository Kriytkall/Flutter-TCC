import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeto_tcc/widgets/card.dart';

class PegarCard extends StatefulWidget {
  const PegarCard({super.key, required this.idUser});

  final String idUser;

  @override
  State<PegarCard> createState() => _PegarCardState();
}

class _PegarCardState extends State<PegarCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Contos')
          .where('uid', isEqualTo: widget.idUser)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Algo deu errado: ${snapshot.error}');
        }
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }
        final List<DocumentSnapshot> contos = snapshot.data!.docs;
        if (contos.isEmpty) {
          return Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(.3),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                "Você não tem nenhuma postagem",
                style: TextStyle(fontSize: 18),
              ),
            ),
          );
        }
        return Column(
          children: List.generate(
            contos.length,
            (index) {
              final conto = contos[index];
              // final idUser = conto.get('uid').toString();
              return CardConto(
                textLabel: conto.get('titulo').toString(),
                imagem: conto.get('imageUrl').toString(),
                idUser: conto.get('uid').toString(),
              );
            },
          ),
        );
      },
    );
  }
}
