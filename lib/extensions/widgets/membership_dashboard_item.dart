import 'package:eliud_core/core/widgets/progress_indicator.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/model/access_model.dart';
import 'package:eliud_core/platform/platform.dart';
import 'package:eliud_core/tools/common_tools.dart';
import 'package:eliud_core/tools/widgets/dialog_helper.dart';
import 'package:eliud_pkg_membership/model/member_public_info_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyMemberPublicInfoListItem extends StatelessWidget {
  final MemberPublicInfoModel value;
  final String appId;

  MyMemberPublicInfoListItem({
    Key key,
    @required this.value,
    this.appId,
  }) : super(key: key);

  static Widget getStatus(String appId, MemberPublicInfoModel value) {
    return FutureBuilder<AccessModel>(
        future: accessRepository(appId: appId).get(value.documentID),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            AccessModel data = snapshot.data;
            return statusAvatar(data.privilegeLevel);
          } else {
            return DelayedCircularProgressIndicator();
          }
        });
  }

  static String stringValue(int status) {
    switch (status) {
      case BLOCKED_MEMBERSHIP:
        return "banned";
      case NO_PRIVILEGE:
        return "subscribed";
      case LEVEL1_PRIVILEGE:
        return "member";
      case LEVEL2_PRIVILEGE:
        return "vip member";
      case OWNER_PRIVILEGES:
        return "owner";
    }
    return null;
  }

  static String assetImageString(int status) {
    switch (status) {
      case BLOCKED_MEMBERSHIP:
        return "banned.png";
      case NO_PRIVILEGE:
        return "basic.png";
      case LEVEL1_PRIVILEGE:
        return "golden_member.png";
      case LEVEL2_PRIVILEGE:
        return "vip.png";
      case OWNER_PRIVILEGES:
        return "elephant.png";
    }
    return null;
  }

  static Widget statusAvatar(int status) {
    var imageName = assetImageString(status);
    if (imageName != null) {
      return Image(image: AssetImage("assets/images/findicons.com/$imageName",
              package: "eliud_pkg_membership"));
    } else {
      return Image(image: AssetImage("assets/images/findicons.com/basic.png",
              package: "eliud_pkg_membership"));
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget profilePhoto;
    if (value.photoURL != null) {
      profilePhoto =
          AbstractPlatform.platform.getImageFromURL(url: value.photoURL);
    }
    profilePhoto ??= Icon(Icons.person_outline);
    return Dismissible(
        key: Key('__Notification_item_${value.documentID}'),
/*
        onDismissed: (_) {
        },
*/
        child: ListTile(
            onTap: () {
              // popup, allow to select the options "block", "promote", "demote", "send message", "task"
              openOptions(context, profilePhoto);
            },
            leading: getStatus(appId, value),
            trailing: profilePhoto,
            title: Text(
              value.name, /*style: style,*/
            )));
  }

  void openOptions(BuildContext context, Widget profilePhoto) {
    DialogStatefulWidgetHelper.openIt(
        context,
        MemberOperations(
            appId: appId, member: value, profilePhoto: profilePhoto),
      widthValue: 200,
      heightValue: 200,
    );
  }
}

class MemberOperations extends StatefulWidget {
  final String appId;
  final MemberPublicInfoModel member;
  final Widget profilePhoto;

  MemberOperations({
    Key key,
    this.member,
    this.appId,
    this.profilePhoto,
  }) : super(key: key);

  @override
  _MemberOperationstate createState() => _MemberOperationstate();
}

class _MemberOperationstate extends State<MemberOperations> {
  final DialogStateHelper dialogHelper = DialogStateHelper();

  Widget getFieldsWidget(BuildContext context) {
    return dialogHelper.fieldsWidget(context, <Widget>[
      dialogHelper.getListTile(
        title: Center(child: Text(widget.member.name)),
      ),
      dialogHelper.getListTile(
        title: Container(height: 100, child: widget.profilePhoto),
      ),
    ], height: 200, width: 200);
  }

  @override
  Widget build(BuildContext context) {
    return dialogHelper.build(title: 'Member profile',
        contents: getFieldsWidget(context),
        buttons: <FlatButton>[
          FlatButton(
              onPressed: () {}, child: Text('Block this member / unblock')),
          FlatButton(onPressed: () {}, child: Text('Promote / demote')),
          FlatButton(onPressed: () {}, child: Text('Send message')),
          FlatButton(onPressed: () {}, child: Text('Assign Task')),
        ]);
  }
}
