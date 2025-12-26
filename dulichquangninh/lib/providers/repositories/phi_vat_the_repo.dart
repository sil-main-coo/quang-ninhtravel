import 'package:dulichquangninh/providers/data_sources/remote/dac_san_remote_provider.dart';
import 'package:dulichquangninh/providers/models/dac_san_model.dart';
import 'package:dulichquangninh/providers/models/phi_vat_the_model.dart';
import 'package:flutter/cupertino.dart';

import '../data_sources/remote/phi_vat_the_remote_provider.dart';

abstract class PhiVatTheRepo {
  Future<List<PhiVatTheModel>> getAllPhiVatThe();
}

class PhiVatTheRepoImpl implements PhiVatTheRepo {
  final PhiVatTheSource phiVatTheSource;

  PhiVatTheRepoImpl({required this.phiVatTheSource});

  @override
  Future<List<PhiVatTheModel>> getAllPhiVatThe() =>
      phiVatTheSource.getAllPhiVatThe();
}
