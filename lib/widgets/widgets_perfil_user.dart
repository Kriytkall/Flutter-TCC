import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

// ------------------- CAPA ----------------------

class Capa extends StatelessWidget {
  Capa({Key? key, required this.imgCapa}) : super(key: key);

  final String imgCapa;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 330,
      decoration: BoxDecoration(
        image: imgCapa != '' && imgCapa.isNotEmpty
            ? DecorationImage(
                image: NetworkImage(imgCapa),
                fit: BoxFit.cover,
              )
            : const DecorationImage(
                image: AssetImage("assets/images/Rectangle 6.png"),
                fit: BoxFit.cover,
              ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(185),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.75),
            offset: const Offset(0, 0),
            blurRadius: 20,
          ),
        ],
      ),
    );
  }
}

// --------------------- PERFIL --------------------

class Avatar extends StatelessWidget {
  Avatar({Key? key, required this.avatarUrl}) : super(key: key);

  final String avatarUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              offset: const Offset(0, 0),
              blurRadius: 10,
            ),
          ],
        ),
        child: avatarUrl == ''
            ? const CircleAvatar(
                backgroundImage: AssetImage("assets/images/avatar.jpg"),
                radius: 45,
              )
            : CircleAvatar(
                backgroundImage: NetworkImage(avatarUrl),
                radius: 45,
              ),
      ),
    );
  }
}

class Nome extends StatelessWidget {
  const Nome({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: TextStyle(fontSize: 20),
    );
  }
}

class Seguidores extends StatelessWidget {
  const Seguidores({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      "33 Seguidores",
      style: TextStyle(fontSize: 18),
    );
  }
}

class Biografia extends StatelessWidget {
  const Biografia({Key? key, required this.biografia}) : super(key: key);

  final String biografia;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 16, left: 30, right: 30),
      child: Text(
        biografia,
        style: const TextStyle(fontSize: 18, height: 1.7),
      ),
    );
  }
}
