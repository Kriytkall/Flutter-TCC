import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

// ------------------- CAPA ----------------------

class Capa extends StatefulWidget {
  const Capa({Key? key}) : super(key: key);

  @override
  State<Capa> createState() => _CapaState();
}

class _CapaState extends State<Capa> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection("Usuarios")
          .doc(_auth.currentUser?.uid)
          .snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Algo deu errado: ${snapshot.error}');
        }
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        final imagemUrl = snapshot.data?['imagem_capa'];

        return Container(
          width: double.infinity,
          height: 330,
          decoration: BoxDecoration(
            image: imagemUrl != null && imagemUrl.isNotEmpty
                ? DecorationImage(
                    image: NetworkImage(imagemUrl),
                    fit: BoxFit.cover,
                  )
                : const DecorationImage(
                    image: AssetImage("assets/images/Rectangle 6.png"),
                    fit: BoxFit.cover,
                  ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(185),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withOpacity(0.75),
                offset: Offset(0, 0),
                blurRadius: 20,
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const <Widget>[
                  ButtonBack(),
                  ButtonEdit(),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class ButtonEdit extends StatefulWidget {
  const ButtonEdit({Key? key}) : super(key: key);

  @override
  State<ButtonEdit> createState() => _ButtonEditState();
}

class _ButtonEditState extends State<ButtonEdit> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final FirebaseStorage storage = FirebaseStorage.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  late String _uid;

  Future<XFile?> getImage() async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  Future<String> upload(String path) async {
    File file = File(path);
    try {
      String ref = 'capa_perfil/img-${DateTime.now().toString()}.jpg';
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
      String imageCapa = await upload(file.path);
      firestore.collection("Usuarios").doc(_uid).update({
        "imagem_capa": imageCapa,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 20,
        top: 40,
      ),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.50),
          borderRadius: BorderRadius.circular(100),
        ),
        child: IconButton(
          onPressed: () {
            pickAndUploadImage();
          },
          icon: Icon(Icons.edit),
          color: Colors.black,
        ),
      ),
    );
  }
}

class ButtonBack extends StatelessWidget {
  const ButtonBack({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        top: 40,
      ),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.50),
          borderRadius: BorderRadius.circular(100),
        ),
        child: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
        ),
      ),
    );
  }
}

// --------------------- PERFIL --------------------

class Avatar extends StatefulWidget {
  const Avatar({Key? key}) : super(key: key);

  @override
  State<Avatar> createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late String _uid;

  Future<XFile?> getImage() async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  Future<String> upload(String path) async {
    File file = File(path);
    try {
      String ref = 'avatar/img-${DateTime.now().toString()}.jpg';
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
      String imageAvatar = await upload(file.path);
      firestore.collection("Usuarios").doc(_uid).update({
        "imagem_perfil": imageAvatar,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection("Usuarios")
          .doc(_auth.currentUser?.uid)
          .snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Algo deu errado: ${snapshot.error}');
        }
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        final imagemUrl = snapshot.data!['imagem_perfil'];

        return GestureDetector(
          child: Padding(
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
                    offset: Offset(0, 0),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: imagemUrl == ''
                  ? const CircleAvatar(
                      backgroundImage: AssetImage("assets/images/avatar.jpg"),
                      radius: 45,
                    )
                  : CircleAvatar(
                      backgroundImage: NetworkImage(imagemUrl),
                      radius: 45,
                    ),
            ),
          ),
          onTap: () {
            pickAndUploadImage();
          },
        );
      },
    );
  }
}

class Nome extends StatefulWidget {
  const Nome({super.key});

  @override
  State<Nome> createState() => _NomeState();
}

class _NomeState extends State<Nome> {
  final _firebaseAuth = FirebaseAuth.instance;
  String nome = '';

  @override
  Widget build(BuildContext context) {
    pegarUsuario();
    return Text(
      nome,
      style: TextStyle(fontSize: 20),
    );
  }

  pegarUsuario() async {
    User? usuario = await _firebaseAuth.currentUser;
    if (usuario != null) {
      setState(() {
        nome = usuario.displayName!;
      });
    }
  }
}

class Seguidores extends StatelessWidget {
  const Seguidores({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "33 Seguidores",
      style: TextStyle(fontSize: 18),
    );
  }
}

class Biografia extends StatelessWidget {
  const Biografia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 16, bottom: 16, left: 30, right: 30),
      child: Text(
        "Adoro escrever, pois pra mim, a escrita é onde podemos nos expressar e criar nossos próprios mundos.",
        style: TextStyle(fontSize: 18, height: 1.7),
      ),
    );
  }
}
