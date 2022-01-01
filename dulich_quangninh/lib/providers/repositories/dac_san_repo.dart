import 'package:dulichquangninh/providers/data_sources/remote/dac_san_remote_provider.dart';
import 'package:dulichquangninh/providers/models/dac_san_model.dart';
import 'package:flutter/cupertino.dart';

abstract class DacSanRepo {
  Future<List<DacSanModel>> getAllDacSan();
}

class DacSanRepoImpl implements DacSanRepo {
  final DacSanSource dacSanSource;

  DacSanRepoImpl(
      {@required this.dacSanSource});

  @override
  Future<List<DacSanModel>> getAllDacSan() => dacSanSource.getAllDacSan();
}
