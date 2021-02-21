import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/tools/widgets/dialog_helper.dart';
import 'package:eliud_pkg_membership/model/member_public_info_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transparent_image/transparent_image.dart';

import 'bloc/membership_bloc.dart';
import 'bloc/membership_event.dart';
import 'membership_dialog.dart';

class MembershipDashboardItem extends StatelessWidget {
  final MemberPublicInfoModel value;
  final String appId;

  MembershipDashboardItem({
    Key key,
    @required this.value,
    this.appId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget profilePhoto;
    if (value.photoURL != null) {
      profilePhoto = FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: value.photoURL,
      );
    }
    profilePhoto ??= Icon(Icons.person_outline);
    return Dismissible(
        key: Key('__Membership_item_${value.documentID}'),
        child: ListTile(
            onTap: () {
              openOptions(context, profilePhoto);
            },
            trailing: Container(height: 100, width: 100, child: profilePhoto),
            title: Text(
              value.name,
            )));
  }

  Future<void> openOptions(BuildContext context, Widget profilePhoto) async {
    var accessModel =
        await accessRepository(appId: appId).get(value.documentID);
    DialogStatefulWidgetHelper.openIt(context, _widget());
  }

  Widget _widget() {
    return BlocProvider<MembershipBloc>(
        create: (context) => MembershipBloc()
          ..add(FetchMembershipEvent(memberId: value.documentID, appId: appId)),
        child: MembershipDialog());
  }
}
