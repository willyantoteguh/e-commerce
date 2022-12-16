import 'dart:io';

import 'package:account/presentation/bloc/edit_profile_bloc/edit_profile_event.dart';
import 'package:account/presentation/bloc/edit_profile_bloc/edit_profile_state.dart';
import 'package:account/presentation/bloc/update_photo_bloc/update_photo_cubit.dart';
import 'package:account/presentation/bloc/update_photo_bloc/update_photo_state.dart';
import 'package:account/presentation/bloc/user_bloc/user_cubit.dart';
import 'package:account/presentation/bloc/user_bloc/user_state.dart';
import 'package:common/utils/constants/app_constants.dart';
import 'package:common/utils/state/view_data_state.dart';
import 'package:component/widget/base/base_navigator.dart';
import 'package:component/widget/button/custom_button.dart';
import 'package:component/widget/progress_indicator/custom_circular_progress_indicator.dart';
import 'package:component/widget/stack/loading_stack.dart';
import 'package:component/widget/text_field/custom_text_field.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/cached_network_image/cached_network_image.dart';
import 'package:dependencies/flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:resources/assets.gen.dart';
import 'package:resources/colors.gen.dart';

import '../bloc/edit_profile_bloc/edit_profile_bloc.dart';

class EditProfileScreen extends StatelessWidget with BaseAuth {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorName.white,
        appBar: AppBar(
          backgroundColor: ColorName.white,
          elevation: 0,
          centerTitle: false,
          leading: IconButton(
            icon: Icon(
              Platform.isIOS ? Icons.arrow_back_ios_new : Icons.arrow_back,
            ),
            onPressed: () => back(arguments: "update"),
          ),
          iconTheme: const IconThemeData(color: ColorName.orange),
          title: Text(
            'Data Diri',
            style: TextStyle(color: ColorName.orange, fontSize: 20.sp, fontWeight: FontWeight.w500),
          ),
        ),
        body: BlocConsumer<UserCubit, UserState>(
          listener: (context, state) {
            final status = state.userState.status;

            if (status.isHasData) {
              fullNameController.text = state.userState.data?.fullName ?? "";
              addressController.text = state.userState.data?.simpleAddress ?? "";
            }
          },
          builder: (context, userState) {
            final userStatus = userState.userState.status;
            return BlocConsumer<EditProfileBloc, EditProfileState>(
              listener: (context, editProfileState) {
                final status = editProfileState.editProfileState.status;
                if (status.isHasData) {
                  back(arguments: "update");
                }
              },
              builder: (context, editProfileState) {
                final editProfileStatus = editProfileState.editProfileState.status;

                return LoadingStack(
                    isLoading: userStatus.isLoading || editProfileStatus.isLoading,
                    widget: ListView(
                      padding: EdgeInsets.all(16.w),
                      shrinkWrap: true,
                      children: [
                        BlocBuilder<UpdatePhotoCubit, UpdatePhotoState>(builder: (context, state) {
                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              userState.userState.data?.imageUrl != null
                                  ? ClipRRect(
                                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                                      child: state.updatePhotoState.data != null
                                          ? Image.file(
                                              state.updatePhotoState.data!,
                                              height: 72.h,
                                              width: 72.w,
                                            )
                                          : CachedNetworkImage(
                                              imageUrl: userState.userState.data!.imageUrl,
                                              placeholder: (context, url) => const Center(
                                                child: CustomCircularProgressIndicator(),
                                              ),
                                              errorWidget: (context, url, error) => const Icon(Icons.error),
                                            ),
                                    )
                                  : Container(
                                      height: 72.h,
                                      width: 72.w,
                                      decoration: const BoxDecoration(
                                        color: ColorName.iconGrey,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(50),
                                        ),
                                      ),
                                    ),
                              Positioned(
                                right: 0.38.sw,
                                bottom: 0,
                                child: InkWell(
                                  onTap: (() => context.read<UpdatePhotoCubit>().uploadImage()),
                                  child: Container(
                                    height: 15.w,
                                    width: 15.w,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: ColorName.white,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(50),
                                      ),
                                      border: Border.all(
                                        color: ColorName.iconWhite,
                                      ),
                                    ),
                                    child: Assets.images.icon.edit.svg(
                                      width: 8.w,
                                      height: 8.w,
                                    ),
                                  ),
                                ),
                              ),
                              if (state.updatePhotoState.status.isLoading)
                                const Center(
                                  child: CustomCircularProgressIndicator(),
                                )
                            ],
                          );
                        }),
                        SizedBox(
                          height: 10.h,
                        ),
                        CustomTextField(
                          labelText: "Nama",
                          controller: fullNameController,
                          errorText: editProfileState.editProfileState.message == AppConstants.errorKey.fullName ? editProfileState.editProfileState.failure!.errorMessage : "",
                          onChanged: (value) => context.read<EditProfileBloc>().add(
                                FullNameChange(fullName: value),
                              ),
                          textInputType: TextInputType.name,
                        ),
                        SizedBox(
                          height: 18.h,
                        ),
                        CustomTextField(
                          labelText: "Alamat",
                          controller: addressController,
                          errorText: editProfileState.editProfileState.message == AppConstants.errorKey.address ? editProfileState.editProfileState.failure!.errorMessage : "",
                          onChanged: (value) => context.read<EditProfileBloc>().add(
                                AddressChange(address: value),
                              ),
                          textInputType: TextInputType.streetAddress,
                        ),
                        SizedBox(
                          height: 45.h,
                        ),
                        CustomButton(
                          buttonText: "Simpan",
                          onTap: () => context.read<EditProfileBloc>().add(
                                EditProfile(
                                  fullName: fullNameController.text,
                                  address: addressController.text,
                                ),
                              ),
                        )
                      ],
                    ));
              },
            );
          },
        ));
  }
}
