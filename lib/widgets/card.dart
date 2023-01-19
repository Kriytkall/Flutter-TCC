import 'package:flutter/material.dart';

class CardConto extends StatelessWidget {
  final String textLabel;
  final String imagem;
  const CardConto({Key? key, required this.textLabel, required this.imagem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 20,
          bottom: 20,
        ),
        child: Container(
          width: 370,
          height: 505,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                offset: Offset(0, 0),
                blurRadius: 10,
              ),
            ],
            color: Colors.white,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  //------------------------ CIRCLEAVATAR ---------------------------
                  Padding(
                    padding: EdgeInsets.only(
                        top: 15, bottom: 10, left: 15, right: 10),
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          child: CircleAvatar(backgroundColor: Colors.lime),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 12,
                          ),
                          child: Text(
                            "Muzan Kibutsuji",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //--------------------- FIM AVATAR -------------------------
                  IconsTopCard(),
                ],
              ),
              //------------------------- CAPA CARD --------------------------
              Padding(
                padding: const EdgeInsets.only(
                  right: 10,
                  left: 10,
                ),
                child: Container(
                  width: double.infinity,
                  height: 350,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: AssetImage(imagem), fit: BoxFit.cover),
                  ),
                ),
              ),
              //-------------------------- FIM CAPA -------------------------
              //------------------------ CARD RESUMO ------------------------
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(left: 14, right: 14, top: 10),
                  child: Text(
                    textLabel,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.expand_more),
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
              ),
            ],
          ),
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
            icon: Icon(Icons.favorite_border_rounded),
            iconSize: 30,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.bookmark_border_sharp),
            iconSize: 30,
          ),
        ],
      ),
    );
  }
}
