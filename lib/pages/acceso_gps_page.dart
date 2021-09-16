import 'package:flutter/material.dart';

import 'package:permission_handler/permission_handler.dart';


class AccesoGPSPage extends StatefulWidget {

  @override
  _AccesoGPSPageState createState() => _AccesoGPSPageState();
}

class _AccesoGPSPageState extends State<AccesoGPSPage> with WidgetsBindingObserver{

  /* El WidgetsBindingObserver permite estar pendiente de todos los cambios de la aplicacion. */

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
      if( await Permission.location.isDenied ){
        Navigator.pushReplacementNamed(context, 'loading');
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
          Text('Necesitas activar los permisos del GPS'),
          SizedBox(height: 20),
          MaterialButton(
            onPressed: () async {
              /**Verificar permisos**/
              final status = await Permission.location.request();

              this.accesoGPS(status);

            },
            child: Text("Solicita Acceso", style: TextStyle(color: Colors.white),),
            color: Colors.blueGrey,
            shape: StadiumBorder(),
            elevation: 0,
            ),
        ], 
      ),
      )
   );
  }

  void accesoGPS( PermissionStatus status){

    switch (status){
      
      case PermissionStatus.limited:

      case PermissionStatus.granted:
        Navigator.pushReplacementNamed(context, 'mapa');
        break;

      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.permanentlyDenied:
      openAppSettings();


    }
  }
}