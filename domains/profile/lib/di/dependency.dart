import 'package:dependencies/get_it/get_it.dart';
import 'package:profile/data/datasource/remote/profile_remote_datasource.dart';
import 'package:profile/data/mapper/profile_mapper.dart';
import 'package:profile/data/repository/profile_repository_impl.dart';
import 'package:profile/domain/repository/profile_repository.dart';
import 'package:profile/domain/usecase/get_user_usecase.dart';
import 'package:profile/domain/usecase/update_user_usecase.dart';
import 'package:profile/domain/usecase/upload_photo_usecase.dart';

class ProfileDependency {
  ProfileDependency() {
    _registerDataSource();
    _registerMapper();
    _registerRepository();
    _registerUseCase();
  }

  _registerDataSource() => sl.registerLazySingleton<ProfileRemoteDataSource>(
        () => ProfileRemoteDataSourceImpl(
          dio: sl(),
        ),
      );

  _registerMapper() => sl.registerLazySingleton<ProfileMapper>(
        () => ProfileMapper(),
      );

  _registerRepository() => sl.registerLazySingleton<ProfileRepository>(
        () => ProfileRepositoryImpl(
          profileMapper: sl(),
          profileRemoteDataSource: sl(),
        ),
      );

  _registerUseCase() {
    sl.registerLazySingleton<GetUserUseCase>(
      () => GetUserUseCase(
        profileRepository: sl(),
      ),
    );

    sl.registerLazySingleton<UpdateUserUseCase>(
      () => UpdateUserUseCase(
        profileRepository: sl(),
      ),
    );

    sl.registerLazySingleton<UploadPhotoUseCase>(
      () => UploadPhotoUseCase(
        profileRepository: sl(),
      ),
    );
  }
}
