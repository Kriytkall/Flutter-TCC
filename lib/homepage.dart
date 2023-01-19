import 'package:projeto_tcc/pages/create.dart';
import 'package:projeto_tcc/pages/home.dart';
import 'package:projeto_tcc/pages/perfil.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int paginaAtual = 0;
  late PageController pc;

  @override
  void initState() {
    super.initState();
    pc = PageController(initialPage: 0);
  }

  setPaginaAtual(pagina) {
    setState(() {
      paginaAtual = pagina;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: SafeArea(
        top: false,
        child: Scaffold(
          extendBody: true,
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pc,
            onPageChanged: setPaginaAtual,
            children: const [
              Home(),
              Create(),
              Perfil(),
            ],
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.08),
                  offset: Offset(0, 0),
                  blurRadius: 15,
                ),
              ],
            ),
            child: CurvedNavigationBar(
              backgroundColor: Colors.transparent,
              height: 60,
              onTap: (pagina) {
                pc.animateToPage(
                  pagina,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.ease,
                );
              },
              items: const <Widget>[
                Icon(Icons.home),
                Icon(Icons.add_circle),
                Icon(Icons.person),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
