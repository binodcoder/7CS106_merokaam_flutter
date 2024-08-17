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
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    if (widget.jobProfile != null) {
      titleController.text = widget.jobProfile!.firstName;
      contentController.text = widget.jobProfile!.lastName;
      createJobProfileBloc.add(JobProfileAddReadyToUpdateEvent(widget.jobProfile!));
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
          titleController.clear();
          contentController.clear();
          Navigator.pop(context);
        } else if (state is AddJobProfileUpdatedState) {
          titleController.clear();
          contentController.clear();
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
                  controller: titleController,
                  hintText: AppStrings.title,
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
                  controller: contentController,
                  hintText: AppStrings.content,
                  validator: (value) {
                    if (value == null || value == '') {
                      return AppStrings.required;
                    }
                    return null;
                  },
                ),
                SizedBox(height: size.height * 0.02),
                SizedBox(height: size.height * 0.02),
                SizedBox(height: size.height * 0.02),
                CustomButton(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      var title = titleController.text;
                      var content = contentController.text;

                      if (title.isNotEmpty && content.isNotEmpty) {
                        if (widget.jobProfile != null) {
                          var updatedJobProfile = JobProfileModel(
                            userAccountId: 0,
                            firstName: '',
                            lastName: '',
                            city: '',
                            state: '',
                            country: '',
                            workAuthorization: '',
                            employmentType: '',
                            resume: '',
                            profilePhoto: '',
                            photosImagePath: '',
                          );
                          createJobProfileBloc.add(JobProfileAddUpdateButtonPressEvent(updatedJobProfile));
                        } else {
                          var newJobProfile = JobProfileModel(
                            userAccountId: 0,
                            firstName: '',
                            lastName: '',
                            city: '',
                            state: '',
                            country: '',
                            workAuthorization: '',
                            employmentType: '',
                            resume: '',
                            profilePhoto: '',
                            photosImagePath: '',
                          );
                          createJobProfileBloc.add(JobProfileAddSaveButtonPressEvent(newJobProfile));
                        }
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
