import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

// ------------------- CAPA ----------------------

class Capa extends StatelessWidget {
  const Capa({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 330,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/Rectangle 6.png"),
            fit: BoxFit.cover),
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
  }
}

class ButtonEdit extends StatelessWidget {
  const ButtonEdit({Key? key}) : super(key: key);
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
          onPressed: () {},
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
  ImagePicker imagePicker = ImagePicker();
  File? imagemSelecionada;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: imagemSelecionada == null
            ? CircleAvatar(
                backgroundColor: Colors.red,
                radius: 45,
              )
            : CircleAvatar(
                backgroundImage: FileImage(imagemSelecionada!),
                radius: 45,
              ),
      ),
      onTap: () {
        pegarImagemGaleria();
      },
    );
  }

  pegarImagemGaleria() async {
    final PickedFile? imagemTemporaria =
        await imagePicker.getImage(source: ImageSource.gallery);
    if (imagemTemporaria != null) {
      setState(() {
        imagemSelecionada = File(imagemTemporaria.path);
      });
    }
  }
}

class Nome extends StatelessWidget {
  const Nome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "Powder",
      style: TextStyle(fontSize: 20),
    );
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

// ------------------- CARD ------------------------