import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

/* HELPERS */
import 'package:app_mapa_flutter/helpers/helpers.dart';


/* PAGES */
import 'package:app_mapa_flutter/pages/mapa_page.dart';
import 'package:app_mapa_flutter/pages/acceso_gps_page.dart';

class LoadingPage extends StatefulWidget {

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> with WidgetsBindingObserver{

  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {

    if( state == AppLifecycleState.resumed ){
      if( await Geolocator.isLocationServiceEnabled() ){
        Navigator.pushReplacement(context, navegarMapaFadeIn(context, MapaPage()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: this.checkGPSandLocation(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          
          if( snapshot.hasData ){
            return Center(child: Text( snapshot.data ),);
          }else {
            return Center( child: CircularProgressIndicator(strokeWidth: 3,));
          }
        },
      ),  
   );
  }

  Future checkGPSandLocation(BuildContext context) async{

    //Permisos GPS
    final permisoGPS = await Permission.location.isGranted;
    //El GPS esta activo
    final gpsActivo = await Geolocator.isLocationServiceEnabled();

    if( permisoGPS && gpsActivo ){
      Navigator.pushReplacement(context, navegarMapaFadeIn(context, MapaPage()));
      return '';
    }else if( !permisoGPS ){
      Navigator.pushReplacement(context, navegarMapaFadeIn(context, AccesoGPSPage()));
      return 'Es necesario que actives el GPS';
    }else {
      return 'Activa tu GPS';
    }


    //print('Hola, llegaste al loadingPage 😁');
    


  }
}