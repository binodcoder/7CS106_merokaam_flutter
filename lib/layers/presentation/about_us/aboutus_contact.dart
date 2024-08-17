import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/styles_manager.dart';
import '../../../resources/values_manager.dart';

class AboutUsContact extends StatelessWidget {
  const AboutUsContact({
    Key? key,
    required this.onTap,
    required this.icon,
    required this.contactName,
    required this.iconColor,
  }) : super(key: key);

  final VoidCallback onTap;
  final IconData icon;
  final String contactName;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Container(
          margin: EdgeInsets.only(
            left: size.width * 0.05,
            right: size.width * 0.05,
            top: size.height * 0.02,
            bottom: size.height * 0.02,
          ),
          height: size.height * 0.08,
          width: size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              AppRadius.r30,
            ),
            color: Colors.pink[50],
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 0.5),
                blurRadius: 0.5,
              ),
            ],
          ),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: AppWidth.w20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: FaIcon(
                  icon,
                  size: FontSize.s25,
                  color: iconColor,
                ),
              ),
              SizedBox(
                width: size.width * 0.07,
              ),
              Text(
                contactName,
                style: getSemiBoldStyle(
                  fontSize: FontSize.s14,
                  color: Colors.teal.shade900,
                ),
              ),
              const Spacer(),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
