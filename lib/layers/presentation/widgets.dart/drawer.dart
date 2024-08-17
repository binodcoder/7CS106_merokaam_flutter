import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../injection_container.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/colour_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/styles_manager.dart';
import '../about_us/about_us.dart';
import '../login/ui/login_screen.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);
  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final SharedPreferences sharedPreferences = sl<SharedPreferences>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: ColorManager.primary),
              accountEmail: Text(
                sharedPreferences.getString("user_email") ?? '',
                style: getRegularStyle(
                  color: ColorManager.white,
                  fontSize: FontSize.s12,
                ),
              ),
              margin: EdgeInsets.zero,
              accountName: Text(
                sharedPreferences.getString("role") ?? '',
                maxLines: 2,
                style: getBoldStyle(
                  color: ColorManager.white,
                  fontSize: FontSize.s12,
                ),
              ),
              currentAccountPicture: const CircleAvatar(backgroundImage: AssetImage(ImageAssets.drawerHeaderLogo)),
            ),
          ),
          sharedPreferences.getBool("login") == null
              ? ListTile(
                  leading: Icon(
                    Icons.logout_outlined,
                    color: ColorManager.primary,
                  ),
                  title: Text(AppStrings.login,
                      style: getMediumStyle(
                        color: ColorManager.primary,
                        fontSize: FontSize.s14,
                      )),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => const LoginPage(),
                        fullscreenDialog: true,
                      ),
                    );
                  },
                )
              : const SizedBox(),
          sharedPreferences.getBool("login") == true
              ? ListTile(
                  leading: Icon(
                    Icons.logout_outlined,
                    color: ColorManager.primary,
                  ),
                  title: Text(
                    AppStrings.logOut,
                    style: getMediumStyle(
                      color: ColorManager.primary,
                      fontSize: FontSize.s14,
                    ),
                  ),
                  onTap: () {
                    sharedPreferences.clear();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => const LoginPage(),
                        fullscreenDialog: true,
                      ),
                    );
                  },
                )
              : const SizedBox(),
          ListTile(
            leading: Icon(
              CupertinoIcons.building_2_fill,
              color: ColorManager.primary,
            ),
            title: Text(
              AppStrings.aboutUs,
              textScaleFactor: 1.2,
              style: getMediumStyle(
                color: ColorManager.primary,
                fontSize: FontSize.s14,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const About(),
                  fullscreenDialog: true,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
