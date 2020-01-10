import 'dart:async';

import 'package:to_do/models/tiles.dart';

import 'database.dart';

class TileBloc {
  static final TileBloc _tileBloc = TileBloc._internal();
  factory TileBloc() {
    return _tileBloc;
  }

  TileBloc._internal();
  var _tileController = StreamController<List<Tile>>.broadcast();
  get tiles => _tileController.stream;

  dispose() {
    _tileController.close();
  }

  getTile() async {
    if (_tileController.isClosed) {
      _tileController = StreamController<List<Tile>>.broadcast();
    }
    try {
      _tileController.sink.add(await DBProvider.db.display());
    } catch (e) {
      _tileController = StreamController<List<Tile>>.broadcast();
      _tileController.sink.add(await DBProvider.db.display());
    }
  }

  delete(int id) {
    DBProvider.db.delete(id);
    getTile();
  }

  add(Tile t) {
    DBProvider.db.insert(t);
    getTile();
  }

  update(Tile t) {
    DBProvider.db.update(t);
    getTile();
  }

  updateWithId(Tile t, int id) {
    DBProvider.db.updateWithId(t, id);
    getTile();
  }

  deleteAll() {
    DBProvider.db.deleteAll();
    getTile();
  }
}
