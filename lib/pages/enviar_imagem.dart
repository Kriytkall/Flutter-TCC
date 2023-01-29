import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';

class Foto extends StatefulWidget {
  const Foto({super.key});

  @override
  State<Foto> createState() => _FotoState();
}

class _FotoState extends State<Foto> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late String _uid;
  late String _titulo;
  late String _texto;

  Future<XFile?> getImage() async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  Future<String> upload(String path) async {
    File file = File(path);
    try {
      String ref = 'images/img-${DateTime.now().toString()}.jpg';
      UploadTask task = storage.ref(ref).putFile(file);
      await task;
      return await storage.ref(ref).getDownloadURL();
    } on FirebaseException catch (e) {
      throw Exception('Erro no Upload: ${e.code}');
    }
  }

  pickAndUploadImage() async {
    XFile? file = await getImage();
    if (file != null) {
      final User? user = _auth.currentUser;
      _uid = user!.uid;
      String imageUrl = await upload(file.path);
      firestore.collection("Contos").add({
        "titulo": _titulo,
        "texto": _texto,
        "imageUrl": imageUrl,
        "data_criacao": FieldValue.serverTimestamp(),
        "uid": _uid,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(labelText: "Título"),
              onChanged: (value) => _titulo = value,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Texto"),
              onChanged: (value) => _texto = value,
            ),
            TextButton(
              onPressed: pickAndUploadImage,
              child: const Text("Enviar"),
            ),
          ],
        ),
      ),
    );
  }
}
