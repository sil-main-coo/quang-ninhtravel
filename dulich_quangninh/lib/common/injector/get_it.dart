import 'package:dulichquangninh/presentation/blocs/app_bloc/app_bloc.dart';
import 'package:dulichquangninh/presentation/journey/luu_tru/bloc/luu_tru_bloc.dart';
import 'package:dulichquangninh/providers/data_sources/remote/di_tich_source.dart';
import 'package:dulichquangninh/providers/data_sources/remote/diem_du_lich_source.dart';
import 'package:dulichquangninh/providers/data_sources/remote/image_storage_source.dart';
import 'package:dulichquangninh/providers/data_sources/remote/loai_di_tich_source.dart';
import 'package:dulichquangninh/providers/data_sources/remote/loai_luu_tru_source.dart';
import 'package:dulichquangninh/providers/data_sources/remote/luu_tru_source.dart';
import 'package:dulichquangninh/providers/repositories/di_tich_repo.dart';
import 'package:dulichquangninh/providers/repositories/image_repo.dart';
import 'package:dulichquangninh/providers/repositories/luu_tru_repo.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(
      () => AppBloc(diTichRepo: locator(), imageRepo: locator()));
  locator.registerLazySingleton(() => LuuTruBloc(luuTruRepo: locator()));

  // repository
  locator.registerFactory<DiTichRepo>(() => DiTichRepoImpl(
      diTichSource: locator(),
      loaiDiTichSource: locator(),
      imageStorageSource: locator()));
  locator.registerFactory<ImageRepo>(
      () => ImageRepoImpl(imageStorageSource: locator()));
  locator.registerFactory<LuuTruRepo>(() =>
      LuuTruRepoImpl(luuTruSource: locator(), loaiLuuTruSource: locator()));

  // data source
  locator.registerFactory(() => DiTichSource());
  locator.registerFactory(() => DiemDuLichSource());
  locator.registerFactory(() => LoaiDiTichSource());
  locator.registerFactory(() => LoaiLuuTruSource());
  locator.registerFactory(() => LuuTruSource());
  locator.registerFactory(() => ImageStorageSource());
}
