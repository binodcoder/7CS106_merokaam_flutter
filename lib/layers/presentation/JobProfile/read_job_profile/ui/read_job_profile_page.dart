import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:merokaam/core/errors/failures.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/db/db_helper.dart';
import '../../../../../injection_container.dart';
import '../../../../../resources/colour_manager.dart';
import '../../../../../resources/font_manager.dart';
import '../../../../../resources/routes_manager.dart';
import '../../../../../resources/strings_manager.dart';
import '../../../../../resources/styles_manager.dart';
import '../../../widgets.dart/drawer.dart';
import '../../add_update_job_profile/ui/create_job_profile_page.dart';
import '../bloc/read_job_profile_bloc.dart';
import '../bloc/read_job_profile_event.dart';
import '../bloc/read_job_profile_state.dart';

class ReadJobProfilePage extends StatefulWidget {
  const ReadJobProfilePage({super.key});

  @override
  State<ReadJobProfilePage> createState() => _ReadJobProfilePageState();
}

class _ReadJobProfilePageState extends State<ReadJobProfilePage> {
  TextEditingController searchMenuController = TextEditingController();
  late final int id;

  @override
  void initState() {
    id = sharedPreferences.getInt("id")!;
    jobProfileBloc.add(JobProfileInitialEvent(id));
    super.initState();
  }

  void refreshPage() {
    jobProfileBloc.add(JobProfileInitialEvent(id));
  }

  ReadJobProfileBloc jobProfileBloc = sl<ReadJobProfileBloc>();
  SharedPreferences sharedPreferences = sl<SharedPreferences>();
  DatabaseHelper databaseHelper = sl<DatabaseHelper>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<ReadJobProfileBloc, ReadJobProfileState>(
      bloc: jobProfileBloc,
      listenWhen: (previous, current) => current is JobProfileActionState,
      buildWhen: (previous, current) => current is! JobProfileActionState,
      listener: (context, state) {
        if (state is JobProfileNavigateToAddJobProfileActionState) {
          Navigator.pushNamed(context, Routes.createJobProfileRoute).then((value) => refreshPage());
        } else if (state is JobProfileNavigateToUpdatePageActionState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => CreateJobProfilePage(jobProfile: state.jobProfile),
              fullscreenDialog: true,
            ),
          ).then((value) => refreshPage());
        } else if (state is JobProfileItemsUpdatedState) {
          jobProfileBloc.add(JobProfileInitialEvent(id));
        } else if (state is JobProfileErrorState) {
          if (state.failure is NotFoundFailure) {
            Navigator.pushNamed(context, Routes.createJobProfileRoute).then((value) => refreshPage());
          } else if (state.failure is UnauthorizedFailure) {
            sharedPreferences.clear();
            databaseHelper.deleteAllJobProfiles();
            Navigator.pushReplacementNamed(context, Routes.loginRoute);
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Error'),
                  content: Text(state.failure.message ?? 'Something went wrong. Please try again.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        // Add your refresh logic here, e.g., triggering an event to refresh the data
                        jobProfileBloc.add(JobProfileInitialEvent(id));
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      child: const Text('Refresh'),
                    ),
                  ],
                );
              },
            );
          }
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case JobProfileLoadingState:
            return const Scaffold(
                body: Center(
              child: CircularProgressIndicator(),
            ));
          case JobProfileLoadedSuccessState:
            final successState = state as JobProfileLoadedSuccessState;
            var jobProfileModel = successState.jobProfile;
            return Scaffold(
              extendBody: true,
              drawer: const MyDrawer(),
              appBar: AppBar(
                title: const Text(AppStrings.appTitle),
              ),
              body: Card(
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${jobProfileModel.firstName.toUpperCase()} ${jobProfileModel.lastName.toUpperCase()}",
                        style: const TextStyle(
                          fontSize: FontSize.s18,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.clip,
                      ),
                      IconButton(
                        onPressed: () {
                          jobProfileBloc.add(JobProfileEditButtonClickedEvent(jobProfileModel));
                        },
                        icon: Icon(
                          Icons.edit,
                          color: ColorManager.primary,
                        ),
                      ),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Text(
                        jobProfileModel.city,
                        style: TextStyle(
                          fontSize: FontSize.s14,
                          color: ColorManager.black,
                        ),
                      ),
                      Text(
                        jobProfileModel.state,
                        style: TextStyle(
                          fontSize: FontSize.s14,
                          color: ColorManager.black,
                        ),
                      ),
                      Text(
                        jobProfileModel.country,
                        style: TextStyle(
                          fontSize: FontSize.s14,
                          color: ColorManager.black,
                        ),
                      ),
                      Text(
                        jobProfileModel.workAuthorization,
                        style: TextStyle(
                          fontSize: FontSize.s14,
                          color: ColorManager.black,
                        ),
                      ),
                      Text(
                        jobProfileModel.employmentType,
                        style: TextStyle(
                          fontSize: FontSize.s14,
                          color: ColorManager.black,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                    ],
                  ),
                ),
              ),
            );

          default:
            return const Scaffold(body: SizedBox());
        }
      },
    );
  }
}
