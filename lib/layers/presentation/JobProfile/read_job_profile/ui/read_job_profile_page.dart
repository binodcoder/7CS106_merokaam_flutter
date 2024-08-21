import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
import 'job_profile_details_page.dart';

class ReadJobProfilePage extends StatefulWidget {
  const ReadJobProfilePage({super.key});

  @override
  State<ReadJobProfilePage> createState() => _ReadJobProfilePageState();
}

class _ReadJobProfilePageState extends State<ReadJobProfilePage> {
  TextEditingController searchMenuController = TextEditingController();

  @override
  void initState() {
    jobProfileBloc.add(JobProfileInitialEvent());
    super.initState();
  }

  void refreshPage() {
    jobProfileBloc.add(JobProfileInitialEvent());
  }

  ReadJobProfileBloc jobProfileBloc = sl<ReadJobProfileBloc>();
  SharedPreferences sharedPreferences = sl<SharedPreferences>();

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
        } else if (state is JobProfileNavigateToDetailPageActionState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => CreateJobProfilePage(
                jobProfile: state.jobProfile,
              ),
              fullscreenDialog: true,
            ),
          ).then((value) => refreshPage());
        } else if (state is JobProfileNavigateToUpdatePageActionState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => CreateJobProfilePage(jobProfile: state.jobProfile),
              fullscreenDialog: true,
            ),
          ).then((value) => refreshPage());
        } else if (state is JobProfileItemSelectedActionState) {
        } else if (state is JobProfileItemDeletedActionState) {
          jobProfileBloc.add(JobProfileInitialEvent());
        } else if (state is JobProfileItemsDeletedActionState) {
          jobProfileBloc.add(JobProfileInitialEvent());
        } else if (state is JobProfileItemsUpdatedState) {
          jobProfileBloc.add(JobProfileInitialEvent());
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
            return Scaffold(
              backgroundColor: Colors.transparent,
              extendBodyBehindAppBar: true,
              extendBody: true,
              drawer: const MyDrawer(),
              floatingActionButton: sharedPreferences.getString("role") == "admin"
                  ? FloatingActionButton(
                      child: const Icon(Icons.add),
                      onPressed: () {
                        jobProfileBloc.add(JobProfileAddButtonClickedEvent());
                      },
                    )
                  : null,
              appBar: AppBar(
                title: Text("Merokaam"),
              ),
              body: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 185, 223, 254),
                      Color(0xFF90CAF9),
                      Color(0xFFBBDEFB),
                      Color(0xFFE3F2FD),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.1, 0.4, 0.7, 1.0],
                  ),
                ),
                child: ListView.builder(
                  itemCount: successState.jobProfileList.length,
                  itemBuilder: (context, index) {
                    var jobProfileModel = successState.jobProfileList[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      margin: const EdgeInsets.all(15),
                      elevation: 5,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: ColorManager.white,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        margin: const EdgeInsets.all(15),
                        child: Slidable(
                          enabled: sharedPreferences.getString("role") == "admin" ? true : false,
                          endActionPane: ActionPane(
                            extentRatio: 0.60,
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) {
                                  jobProfileBloc.add(JobProfileEditButtonClickedEvent(jobProfileModel));
                                },
                                backgroundColor: const Color.fromARGB(255, 113, 205, 217),
                                foregroundColor: Colors.white,
                                icon: Icons.edit,
                                label: AppStrings.edit,
                              ),
                              SlidableAction(
                                onPressed: (context) {
                                  jobProfileBloc.add(JobProfileDeleteButtonClickedEvent(jobProfileModel));
                                },
                                backgroundColor: const Color.fromARGB(255, 201, 32, 46),
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: AppStrings.delete,
                              )
                            ],
                          ),
                          child: ListTile(
                            onTap: () {
                              //  Navigator.pushNamed(context, Routes.JobProfileDetailRoute)
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => JobProfileDetailsPage(
                                    jobProfile: jobProfileModel,
                                  ),
                                ),
                              );
                            },
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    jobProfileModel.firstName.toUpperCase(),
                                    style: const TextStyle(
                                      fontSize: FontSize.s18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.clip,
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
                                  jobProfileModel.lastName,
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
                      ),
                    );
                  },
                ),
              ),
            );
          case JobProfileErrorState:
            return const Scaffold(body: Center(child: Text(AppStrings.error)));
          default:
            return const SizedBox();
        }
      },
    );
  }
}
