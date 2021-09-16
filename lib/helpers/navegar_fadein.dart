part of 'helpers.dart';


Route navegarMapaFadeIn( BuildContext context, Widget page){

  return PageRouteBuilder(
    pageBuilder: ( _, __ , ___ ) => page,
    transitionDuration: Duration(milliseconds: 300),
    transitionsBuilder: ( context, animaion, _, child ){

      return FadeTransition(
        child: child,
        opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: animaion, curve: Curves.easeOut)
        )
        );
    }
    );
}