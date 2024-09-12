import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merokaam/core/entities/job_profile.dart';
import '../../../../../core/models/job_profile_model.dart';
import '../../../../../injection_container.dart';
import '../../../../../resources/colour_manager.dart';
import '../../../../../resources/strings_manager.dart';
import '../../../../../resources/values_manager.dart';
import '../../../widgets.dart/custom_button.dart';
import '../../../widgets.dart/custom_input_field.dart';
import '../../../widgets.dart/image_frame.dart';
import '../bloc/create_job_profile_bloc.dart';
import '../bloc/create_job_profile_bloc_event.dart';
import '../bloc/create_job_profile_bloc_state.dart';

class CreateJobProfilePage extends StatefulWidget {
  const CreateJobProfilePage({
    super.key,
    this.jobProfile,
  });

  final JobProfile? jobProfile;

  @override
  State<CreateJobProfilePage> createState() => _CreateJobProfilePageState();
}

class _CreateJobProfilePageState extends State<CreateJobProfilePage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController workAuthorizationController = TextEditingController();
  final TextEditingController employmentTypeController = TextEditingController();
  late int id;

  @override
  void initState() {
    if (widget.jobProfile != null) {
      id = widget.jobProfile!.userAccountId!;

      firstNameController.text = widget.jobProfile!.firstName;
      lastNameController.text = widget.jobProfile!.lastName;
      cityController.text = widget.jobProfile!.city;
      stateController.text = widget.jobProfile!.state;
      countryController.text = widget.jobProfile!.country;
      workAuthorizationController.text = widget.jobProfile!.workAuthorization;
      employmentTypeController.text = widget.jobProfile!.employmentType;
      // createJobProfileBloc.add(JobProfileAddReadyToUpdateEvent(widget.jobProfile!));
    } else {
      createJobProfileBloc.add(JobProfileAddInitialEvent());
    }
    super.initState();
  }

  final CreateJobProfileBloc createJobProfileBloc = sl<CreateJobProfileBloc>();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<CreateJobProfileBloc, CreateJobProfileState>(
      bloc: createJobProfileBloc,
      listenWhen: (previous, current) => current is JobProfileAddActionState,
      buildWhen: (previous, current) => current is! JobProfileAddActionState,
      listener: (context, state) {
        if (state is AddJobProfileSavedState) {
          firstNameController.clear();
          lastNameController.clear();
          cityController.clear();
          stateController.clear();
          countryController.clear();
          countryController.clear();
          workAuthorizationController.clear();
          Navigator.pop(context);
        } else if (state is AddJobProfileUpdatedState) {
          firstNameController.clear();
          lastNameController.clear();
          cityController.clear();
          stateController.clear();
          countryController.clear();
          countryController.clear();
          workAuthorizationController.clear();
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              widget.jobProfile == null ? AppStrings.addJobProfile : AppStrings.updateJobProfile,
            ),
          ),
          body: Form(
            key: _formKey,
            child: Container(
              margin: const EdgeInsets.all(AppSize.s14),
              child: ListView(children: [
                SizedBox(height: size.height * 0.02),
                CustomTextFormField(
                  maxLines: 2,
                  minLines: 1,
                  controller: firstNameController,
                  hintText: AppStrings.firstName,
                  validator: (value) {
                    if (value == null || value == '') {
                      return AppStrings.required;
                    }
                    return null;
                  },
                ),
                SizedBox(height: size.height * 0.02),
                CustomTextFormField(
                  maxLines: 5,
                  minLines: 1,
                  controller: lastNameController,
                  hintText: AppStrings.lastName,
                  validator: (value) {
                    if (value == null || value == '') {
                      return AppStrings.required;
                    }
                    return null;
                  },
                ),
                SizedBox(height: size.height * 0.02),
                CustomTextFormField(
                  maxLines: 5,
                  minLines: 1,
                  controller: cityController,
                  hintText: AppStrings.city,
                  validator: (value) {
                    if (value == null || value == '') {
                      return AppStrings.required;
                    }
                    return null;
                  },
                ),
                SizedBox(height: size.height * 0.02),
                CustomTextFormField(
                  maxLines: 5,
                  minLines: 1,
                  controller: stateController,
                  hintText: AppStrings.state,
                  validator: (value) {
                    if (value == null || value == '') {
                      return AppStrings.required;
                    }
                    return null;
                  },
                ),
                SizedBox(height: size.height * 0.02),
                CustomTextFormField(
                  maxLines: 5,
                  minLines: 1,
                  controller: countryController,
                  hintText: AppStrings.country,
                  validator: (value) {
                    if (value == null || value == '') {
                      return AppStrings.required;
                    }
                    return null;
                  },
                ),
                SizedBox(height: size.height * 0.02),
                CustomTextFormField(
                  maxLines: 5,
                  minLines: 1,
                  controller: workAuthorizationController,
                  hintText: AppStrings.workAuthorisation,
                  validator: (value) {
                    if (value == null || value == '') {
                      return AppStrings.required;
                    }
                    return null;
                  },
                ),
                SizedBox(height: size.height * 0.02),
                CustomTextFormField(
                  maxLines: 5,
                  minLines: 1,
                  controller: employmentTypeController,
                  hintText: AppStrings.employmentType,
                  validator: (value) {
                    if (value == null || value == '') {
                      return AppStrings.required;
                    }
                    return null;
                  },
                ),
                SizedBox(height: size.height * 0.02),
                CustomButton(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      var firstName = firstNameController.text;
                      var lastName = lastNameController.text;
                      var city = cityController.text;
                      var state = stateController.text;
                      var country = countryController.text;
                      var workAuthorisation = workAuthorizationController.text;
                      var employmentType = employmentTypeController.text;

                      if (widget.jobProfile != null) {
                        var updatedJobProfile = JobProfileModel(
                          userAccountId: id,
                          firstName: firstName,
                          lastName: lastName,
                          city: city,
                          state: state,
                          country: country,
                          workAuthorization: workAuthorisation,
                          employmentType: employmentType,
                          resume: null,
                          profilePhoto: null,
                          photosImagePath: null,
                        );
                        createJobProfileBloc.add(JobProfileAddUpdateButtonPressEvent(updatedJobProfile));
                      } else {
                        var newJobProfile = JobProfileModel(
                          userAccountId: 0,
                          firstName: firstName,
                          lastName: lastName,
                          city: city,
                          state: state,
                          country: country,
                          workAuthorization: workAuthorisation,
                          employmentType: employmentType,
                          resume: null,
                          profilePhoto: null,
                          photosImagePath: null,
                        );
                        createJobProfileBloc.add(JobProfileAddSaveButtonPressEvent(newJobProfile));
                      }
                    }
                  },
                  text: widget.jobProfile == null ? AppStrings.addJobProfile : AppStrings.updateJobProfile,
                  size: size,
                ),
              ]),
            ),
          ),
        );
      },
    );
  }
}
