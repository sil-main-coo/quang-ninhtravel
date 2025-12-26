import 'package:dulichquangninh/common/session/shared_pref_manager.dart';
import 'package:dulichquangninh/presentation/blocs/app_bloc/app_bloc.dart';
import 'package:dulichquangninh/presentation/journey/hoi_nhap/bloc/hoi_nhap_bloc.dart';
import 'package:dulichquangninh/presentation/journey/phi_vat_the/bloc/phi_vat_the_bloc.dart';
import 'package:dulichquangninh/providers/data_sources/remote/auth_remote_provider.dart';
import 'package:dulichquangninh/providers/data_sources/remote/dac_san_remote_provider.dart';
import 'package:dulichquangninh/providers/data_sources/remote/di_tich_source.dart';
import 'package:dulichquangninh/providers/data_sources/remote/diem_du_lich_source.dart';
import 'package:dulichquangninh/providers/data_sources/remote/image_storage_source.dart';
import 'package:dulichquangninh/providers/data_sources/remote/loai_di_tich_source.dart';
import 'package:dulichquangninh/providers/data_sources/remote/loai_luu_tru_source.dart';
import 'package:dulichquangninh/providers/data_sources/remote/luu_tru_source.dart';
import 'package:dulichquangninh/providers/repositories/dac_san_repo.dart';
import 'package:dulichquangninh/providers/repositories/di_tich_repo.dart';
import 'package:dulichquangninh/providers/repositories/diem_du_lich_repo.dart';
import 'package:dulichquangninh/providers/repositories/image_repo.dart';
import 'package:dulichquangninh/providers/repositories/luu_tru_repo.dart';
import 'package:dulichquangninh/providers/repositories/phi_vat_the_repo.dart';
import 'package:get_it/get_it.dart';

import '../../presentation/journey/diem_den_nghi_duong/diem_du_lich/bloc/diem_du_lich_bloc.dart';
import '../../presentation/journey/diem_den_nghi_duong/nghi_duong/bloc/luu_tru_bloc.dart';
import '../../presentation/journey/hoi_nhap/dac_san/bloc/dac_san_bloc.dart';
import '../../providers/data_sources/remote/phi_vat_the_remote_provider.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton(SharedPreferencesManager());

  // data source
  locator.registerFactory(() => DiTichSource());
  locator.registerFactory(() => DiemDuLichSource());
  locator.registerFactory(() => LoaiDiTichSource());
  locator.registerFactory(() => LoaiLuuTruSource());
  locator.registerFactory(() => LuuTruSource());
  locator.registerFactory(() => ImageStorageSource());
  locator.registerFactory(() => AuthRemoteProvider());
  locator.registerFactory(() => DacSanSource());
  locator.registerFactory(() => PhiVatTheSource());

  // repository
  locator.registerFactory<DiTichRepo>(() => DiTichRepoImpl(
      diTichSource: locator(),
      loaiDiTichSource: locator(),
      imageStorageSource: locator()));
  locator.registerFactory<ImageRepo>(
      () => ImageRepoImpl(imageStorageSource: locator()));
  locator.registerFactory<LuuTruRepo>(() =>
      LuuTruRepoImpl(luuTruSource: locator(), loaiLuuTruSource: locator()));
  locator.registerFactory<DiemDuLichRepo>(
      () => DiemDuLichRepoImpl(diemDuLichSource: locator()));
  locator.registerFactory<DacSanRepo>(
      () => DacSanRepoImpl(dacSanSource: locator()));
  locator.registerFactory<PhiVatTheRepo>(
      () => PhiVatTheRepoImpl(phiVatTheSource: locator()));

  locator.registerLazySingleton(
      () => AppBloc(diTichRepo: locator(), imageRepo: locator()));
  locator.registerLazySingleton(() => LuuTruBloc(luuTruRepo: locator()));
  locator
      .registerLazySingleton(() => DiemDuLichBloc(diemDuLichRepo: locator()));
  locator.registerLazySingleton(() => DacSanBloc(dacSanRepo: locator()));
  locator.registerLazySingleton(() => HoiNhapBloc(dacSanRepo: locator()));
  locator.registerLazySingleton(() => PhiVatTheBloc(phiVatTheRepo: locator()));
}
