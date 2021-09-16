import 'package:flutter/material.dart';

/* PAGES */
import 'package:app_mapa_flutter/pages/loading_page.dart';
import 'package:app_mapa_flutter/pages/acceso_gps_page.dart';
import 'package:app_mapa_flutter/pages/mapa_page.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: LoadingPage(),
      routes: {
        'acceso'  : ( _ ) => AccesoGPSPage(),
        'loading' : ( _ ) => LoadingPage(),
        'mapa'    : ( _ ) => MapaPage(),
      },
    );
  }
}