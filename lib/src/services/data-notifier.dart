
import 'package:flutter/material.dart';

class DataNotifiter extends ChangeNotifier {

  String _idCodigo;

  String get idCodigo {
    return this._idCodigo;
  }

  set idCodigo(String code){
     this._idCodigo = code;
     notifyListeners();
  }
//// Activicación del folio
  String _idFolio;

  String get idFolio {
    return this._idFolio;
  }

  set idFolio(String folio) {
    this._idFolio = folio;
    notifyListeners();
  }


}