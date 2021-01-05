import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:eliud_core/platform/platform.dart';
import 'package:eliud_core/tools/formatting.dart';
import 'package:eliud_pkg_membership/model/member_public_info_model.dart';
import 'package:eliud_pkg_notifications/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_notifications/model/notification_list_bloc.dart';
import 'package:eliud_pkg_notifications/model/notification_list_event.dart';
import 'package:eliud_pkg_notifications/model/notification_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyMemberPublicInfoListItem extends StatelessWidget {
  final MemberPublicInfoModel value;

  MyMemberPublicInfoListItem({
    Key key,
    @required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var app = AccessBloc.app(context);
    Widget profilePhoto;
    if (value.photoURL != null) {
      profilePhoto = AbstractPlatform.platform
          .getImageFromURL(url: value.photoURL);
    }
    profilePhoto ??= Icon(Icons.person_outline);
    return Dismissible(
      key: Key('__Notification_item_${value.documentID}'),
      onDismissed: (_) {
/*
        BlocProvider.of<NotificationListBloc>(context)
            .add(UpdateNotificationList(value: value.copyWith(status: NotificationStatus.Closed)));
*/
      },
      child: ListTile(
        onTap: () {},
        trailing: profilePhoto,
        title: Text(value.name, /*style: style,*/))
      );
  }
}
