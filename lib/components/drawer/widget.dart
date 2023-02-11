import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notify/bloc/app_bloc.dart';
import 'package:notify/utils/colors.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColor.bgColor,
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          final user = state.redmineUser.user;
          final image = user?.avatar;
          return ListView(
            children: [
              DrawerHeader(
                padding: EdgeInsets.zero,
                child: Container(
                  padding: const EdgeInsets.only(left: 20, bottom: 20),
                  decoration: BoxDecoration(color: AppColor.blueColor),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (image != null)
                        CircleAvatar(
                          maxRadius: 36,
                          backgroundImage: NetworkImage(image),
                        ),
                      const SizedBox(height: 5),
                      Text(
                        '${user?.login}',
                        maxLines: 1,
                        style: TextStyle(
                          color: AppColor.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              NavigationTile(
                icon: Icons.person,
                title: '${user?.firstname}',
              ),
              NavigationTile(
                icon: Icons.mail_outline_outlined,
                title: "${user?.mail}",
              ),
              ...(user?.customFields ?? [])
                  .where((e) => e.id != 8)
                  .map((field) {
                return NavigationTile(
                  icon: Icons.work_outline_outlined,
                  title: "${field.name}\t:-\t\t${field.value}",
                );
              }),
              NavigationTile(
                icon: Icons.watch_later_outlined,
                title: "${user?.lastLoginOn}",
              ),
              NavigationTile(
                icon: Icons.logout_outlined,
                title: "Logout",
                onTap: () {},
              ),
            ],
          );
        },
      ),
    );
  }
}

class NavigationTile extends StatelessWidget {
  final IconData? icon;
  final String title;
  final bool isIcon;
  final GestureTapCallback? onTap;
  const NavigationTile({
    Key? key,
    this.icon,
    this.title = "",
    this.isIcon = true,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          visualDensity: const VisualDensity(
            horizontal: VisualDensity.minimumDensity,
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
          leading: isIcon
              ? Icon(
                  icon,
                  size: 28,
                  color: AppColor.inputActiveBorder,
                )
              : null,
          title: Text(
            title,
            style: TextStyle(fontSize: 14, color: AppColor.white),
          ),
        ),
        Divider(
          height: 0.1,
          color: AppColor.inputHintColor,
          thickness: 0.5,
        ),
      ],
    );
  }
}
