import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:merokaam/core/entities/job_profile.dart';
import 'package:merokaam/core/errors/failures.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/db/db_helper.dart';
import '../../../../../core/models/job_profile_model.dart';
import '../../../../../injection_container.dart';
import '../../../../../resources/colour_manager.dart';
import '../../../../../resources/routes_manager.dart';
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

  late int id;

  final List<String> workAuthorization = <String>["Nepali Citizen", "TN permit", "Indian Citizen", "Pakistani Citizen", "Canadian Citizen"];
  String selectedWorkAuthorization = "Nepali Citizen";

  final List<String> employmentType = <String>["Seeking Employment", "Full-time", "Part-time", "Freelance", "Part-Time"];
  String selectedEmploymentType = "Seeking Employment";

  @override
  void initState() {
    if (widget.jobProfile != null) {
      id = widget.jobProfile!.userAccountId!;
      firstNameController.text = widget.jobProfile!.firstName;
      lastNameController.text = widget.jobProfile!.lastName;
      cityController.text = widget.jobProfile!.city;
      stateController.text = widget.jobProfile!.state;
      countryController.text = widget.jobProfile!.country;
      selectedWorkAuthorization = widget.jobProfile!.workAuthorization;
      selectedEmploymentType = widget.jobProfile!.employmentType;
      // createJobProfileBloc.add(JobProfileAddReadyToUpdateEvent(widget.jobProfile!));
    } else {
      createJobProfileBloc.add(JobProfileAddInitialEvent());
    }
    super.initState();
  }

  final CreateJobProfileBloc createJobProfileBloc = sl<CreateJobProfileBloc>();

  final _formKey = GlobalKey<FormState>();

  SharedPreferences sharedPreferences = sl<SharedPreferences>();
  DatabaseHelper databaseHelper = sl<DatabaseHelper>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<CreateJobProfileBloc, CreateJobProfileState>(
      bloc: createJobProfileBloc,
      listenWhen: (previous, current) => current is JobProfileAddActionState,
      buildWhen: (previous, current) => current is! JobProfileAddActionState,
      listener: (context, state) {
        if (state is AddJobProfileLoadingState) {
          _showLoadingDialog(context);
        } else if (state is AddJobProfileSavedState) {
          Navigator.pop(context);
          firstNameController.clear();
          lastNameController.clear();
          cityController.clear();
          stateController.clear();
          countryController.clear();
          countryController.clear();
          Navigator.pop(context);
        } else if (state is AddJobProfileUpdatedState) {
          Navigator.pop(context);
          firstNameController.clear();
          lastNameController.clear();
          cityController.clear();
          stateController.clear();
          countryController.clear();
          countryController.clear();
          Navigator.pop(context);
        } else if (state is AddJobProfileErrorState) {
          if (state.failure is UnauthorizedFailure) {
            sharedPreferences.clear();
            databaseHelper.deleteAllJobProfiles();
            Navigator.pushReplacementNamed(context, Routes.loginRoute);
          } else {
            Navigator.pop(context);
            Fluttertoast.showToast(
              msg: state.failure.message,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: ColorManager.error,
            );
          }
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
                // CustomTextFormField(
                //   maxLines: 5,
                //   minLines: 1,
                //   controller: workAuthorizationController,
                //   hintText: AppStrings.workAuthorisation,
                //   validator: (value) {
                //     if (value == null || value == '') {
                //       return AppStrings.required;
                //     }
                //     return null;
                //   },
                // ),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    fillColor: Colors.grey[10],
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: AppWidth.w4, vertical: AppHeight.h12),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      //BorderSide(color: ColorManager.white, width: 0, style: BorderStyle.none),
                      borderRadius: BorderRadius.all(
                        Radius.circular(AppRadius.r10),
                      ),
                    ),
                  ),
                  isExpanded: true,
                  icon: const Icon(Icons.arrow_drop_down),
                  iconEnabledColor: ColorManager.blue,
                  iconSize: 30,
                  items: workAuthorization.map((item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Container(
                        margin: const EdgeInsets.only(left: 1),
                        padding: const EdgeInsets.only(left: 10),
                        height: 55,
                        width: double.infinity,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            item,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedWorkAuthorization = newValue!;
                    });
                  },
                  value: selectedWorkAuthorization,
                ),
                SizedBox(height: size.height * 0.02),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    fillColor: Colors.grey[10],
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: AppWidth.w4, vertical: AppHeight.h12),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      //BorderSide(color: ColorManager.white, width: 0, style: BorderStyle.none),
                      borderRadius: BorderRadius.all(
                        Radius.circular(AppRadius.r10),
                      ),
                    ),
                  ),
                  isExpanded: true,
                  icon: const Icon(Icons.arrow_drop_down),
                  iconEnabledColor: ColorManager.blue,
                  iconSize: 30,
                  items: employmentType.map((item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Container(
                        margin: const EdgeInsets.only(left: 1),
                        padding: const EdgeInsets.only(left: 10),
                        height: 55,
                        width: double.infinity,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            item,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedEmploymentType = newValue!;
                    });
                  },
                  value: selectedEmploymentType,
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
                      var workAuthorisation = selectedWorkAuthorization;
                      var employmentType = selectedEmploymentType;

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

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
