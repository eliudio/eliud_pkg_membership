import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/member_public_info_model.dart';
import 'package:eliud_core/style/frontend/has_dialog.dart';
import 'package:eliud_pkg_etc/tools/member_popup_menu.dart';
import 'package:eliud_pkg_membership/model/membership_dashboard_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transparent_image/transparent_image.dart';

import 'bloc/membership_bloc.dart';
import 'bloc/membership_event.dart';
import 'membership_dialog.dart';

class MembershipDashboardItem extends StatelessWidget {
  final AppModel app;
  final MembershipDashboardModel dashboardModel;
  final MemberPublicInfoModel? value;

  MembershipDashboardItem(
      {Key? key, required this.app, required this.value, required this.dashboardModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget profilePhoto;
    if ((value == null) || (value!.photoURL == null)) {
      profilePhoto = Icon(Icons.person_outline);
    } else {
      profilePhoto = FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: value!.photoURL!,
      );
    }
    var title;
    if (value!.name != null) {
      title = Text(value!.name!);
    } else {
      title = Text("No name");
    }

    return Dismissible(
        key: Key('__Membership_item_${value!.documentID}'),
        child: GestureDetector(
            onTap: () {
              MemberPopupMenu.showPopupMenuWithAllActions(app,
                  context, 'Member dashboard', () => openOptions(app, context, profilePhoto), dashboardModel.memberActions, value!.documentID, );
            },
            child: ListTile(
                trailing:
                    Container(height: 100, width: 100, child: profilePhoto),
                title: title)));
  }

  Future<void> openOptions(AppModel app, BuildContext context, Widget profilePhoto) async {
/*
    var accessModel =
        await accessRepository(appId: appId)!.get(value!.documentID);
*/
    openWidgetDialog(app, context, app.documentID + '/_membershipoptions', child: _widget(app));
  }

  Widget _widget(AppModel app) {
    return BlocProvider<MembershipBloc>(
        create: (context) => MembershipBloc()
          ..add(
              FetchMembershipEvent(memberId: value!.documentID, app: app)),
        child: MembershipDialog(app: app));
  }
}
