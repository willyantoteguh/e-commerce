import 'package:account/presentation/bloc/edit_profile_bloc/edit_profile_event.dart';
import 'package:account/presentation/bloc/edit_profile_bloc/edit_profile_state.dart';
import 'package:common/utils/constants/app_constants.dart';
import 'package:common/utils/error/failure_response.dart';
import 'package:common/utils/state/view_data_state.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/firebase/firebase.dart';
import 'package:profile/domain/entity/request/user_request_entity.dart';
import 'package:profile/domain/usecase/update_user_usecase.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final UpdateUserUseCase updateUserUseCase;
  final FirebaseMessaging firebaseMessaging;

  EditProfileBloc({required this.updateUserUseCase, required this.firebaseMessaging})
      : super(
          EditProfileState(
            editProfileState: ViewData.initial(),
          ),
        ) {
    on<FullNameChange>((event, emit) => {
          if (event.fullName.isEmpty)
            {
              emit(
                EditProfileState(
                  editProfileState: ViewData.error(
                    message: AppConstants.errorKey.username,
                    failure: FailureResponse(errorMessage: AppConstants.errorMessage.fullNameEmpty),
                  ),
                ),
              ),
            }
          else
            {
              emit(
                EditProfileState(
                  editProfileState: ViewData.initial(),
                ),
              ),
            }
        });

    on<AddressChange>((event, emit) => {
          if (event.address.isEmpty)
            {
              emit(
                EditProfileState(
                  editProfileState: ViewData.error(
                    message: AppConstants.errorKey.password,
                    failure: FailureResponse(errorMessage: AppConstants.errorMessage.addressEmpty),
                  ),
                ),
              ),
            }
          else
            {
              emit(
                EditProfileState(
                  editProfileState: ViewData.initial(),
                ),
              ),
            }
        });

    on<EditProfile>((event, emit) async {
      emit(
        EditProfileState(
          editProfileState: ViewData.loading(),
        ),
      );
      if (event.fullName.isNotEmpty && event.address.isNotEmpty) {
        final fcmToken = await firebaseMessaging.getToken();
        final UserRequestEntity userRequestEntity =
            UserRequestEntity(fullName: event.fullName, simpleAddress: event.address, fcmToken: fcmToken ?? '', fcmServerKey: AppConstants.fcmServerKey.fcmServerKey);
        final updateUser = await updateUserUseCase.call(userRequestEntity);
        updateUser.fold(
          (failure) => emit(
            EditProfileState(
              editProfileState: ViewData.error(
                message: failure.errorMessage,
                failure: failure,
              ),
            ),
          ),
          (updateUser) => emit(
            EditProfileState(
              editProfileState: ViewData.loaded(),
            ),
          ),
        );
      } else {
        emit(
          EditProfileState(
            editProfileState: ViewData.error(
              message: AppConstants.errorMessage.formNotEmpty,
              failure: FailureResponse(errorMessage: AppConstants.errorMessage.formNotEmpty),
            ),
          ),
        );
      }
    });
  }
}
