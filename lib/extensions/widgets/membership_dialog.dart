import 'package:eliud_core/core/registry.dart';
import 'package:eliud_core/model/access_model.dart';
import 'package:eliud_core/model/member_public_info_model.dart';
import 'package:eliud_core/style/style_registry.dart';
import 'package:eliud_core/tools/tool_set.dart';
import 'package:eliud_pkg_notifications/platform/platform.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/membership_bloc.dart';
import 'bloc/membership_event.dart';
import 'bloc/membership_state.dart';

class MembershipDialog extends StatefulWidget {
  MembershipDialog({
    Key? key,
  }) : super(key: key);

  @override
  _MembershipDialogState createState() => _MembershipDialogState();
}

class _MembershipDialogState extends State<MembershipDialog> {
  Widget getFieldsWidget(BuildContext context, String appId,
      AccessModel oldAccessModel, MemberPublicInfoModel member) {

    return StyleRegistry.registry().styleWithContext(context).frontEndStyle().simpleTopicContainer(context, children: <Widget>[buttons(appId, oldAccessModel, member)],
        height: 200, width: 200);
  }

  Widget buttons(
      String appId, AccessModel oldAccessModel, MemberPublicInfoModel member) {
    var privilegeLevel;
    var blocked;
    if (oldAccessModel != null) {
      privilegeLevel = oldAccessModel.privilegeLevel;
      blocked = oldAccessModel.blocked;
    } else {
      privilegeLevel = PrivilegeLevel.NoPrivilege;
      blocked = false;
    }
    List<Widget> _buttons = [];
    if ((oldAccessModel.blocked != null) && (oldAccessModel.blocked!)) {
      _buttons.add(StyleRegistry.registry().styleWithContext(context).frontEndStyle().button(context, label: 'Unblock member',
          onPressed: () => _askUnblock()));
    } else {
      if (privilegeLevel != PrivilegeLevel.OwnerPrivilege) {
        _buttons.add(StyleRegistry.registry().styleWithContext(context).frontEndStyle().button(context, label: 'Block member',
            onPressed: () => _askBlock(appId, oldAccessModel, member)));
      }
      if ((privilegeLevel.index >= PrivilegeLevel.NoPrivilege.index) &&
          (privilegeLevel.index < PrivilegeLevel.Level2Privilege.index)) {
        _buttons.add(StyleRegistry.registry().styleWithContext(context).frontEndStyle().button(context, label: 'Promote member',
            onPressed: () => _askPromote(privilegeLevel, blocked)));
      }
      if ((privilegeLevel.index > PrivilegeLevel.NoPrivilege.index) &&
          (privilegeLevel.index <= PrivilegeLevel.Level2Privilege.index)) {
        _buttons.add(StyleRegistry.registry().styleWithContext(context).frontEndStyle().button(context, label: 'Demote member',
            onPressed: () => _askDemote(privilegeLevel, blocked)));
      }
    }
    _buttons.add(StyleRegistry.registry().styleWithContext(context).frontEndStyle().button(context, label: 'Send message',
        onPressed: () => _askSendMessage(member)));
    return ListView(
        shrinkWrap: true, physics: ScrollPhysics(), children: _buttons);
  }

  void _askBlock(
      String appId, AccessModel oldAccessModel, MemberPublicInfoModel member) {
    StyleRegistry.registry().styleWithContext(context).frontEndStyle().openAckNackDialog(context,
        title: 'Block',
        message: 'Do you want to block this member from the app?',
        onSelection: (value) {
      if (value == 0) {
        _block();
      }
    });
  }

  void _askPromote(PrivilegeLevel privilegeLevel, bool blocked) {
    StyleRegistry.registry().styleWithContext(context).frontEndStyle().openAckNackDialog(context,
        title: 'Promote',
        message: 'Do you want to promote this member? Current level is ' +
            privilegeLevelToMemberRoleString(privilegeLevel, blocked),
        onSelection: (value) {
      if (value == 0) {
        _promote();
      }
    });
  }

  Future<void> _askDemote(PrivilegeLevel privilegeLevel, bool blocked) async {
    StyleRegistry.registry().styleWithContext(context).frontEndStyle().openAckNackDialog(context,
        title: 'Demote',
        message: 'Do you want to demote this member? Current level is ' +
            privilegeLevelToPrivilegeString(privilegeLevel, blocked),
        onSelection: (value) {
      if (value == 0) {
        _demote();
      }
    });
  }

  void _askUnblock() {
    StyleRegistry.registry().styleWithContext(context).frontEndStyle().openAckNackDialog(
      context,
      title: 'Unblock',
      message: 'Do you want to unblock this member from the app?',
      onSelection: (value) {
        if (value == 0) {
          _unblock();
        }
      },
    );
  }

  void _askSendMessage(MemberPublicInfoModel member) {
    StyleRegistry.registry().styleWithContext(context).frontEndStyle().openEntryDialog(context,
        title: 'Send Message to Member',
        hintText: 'Message',
        ackButtonLabel: 'Send message',
        nackButtonLabel: 'Discard', onPressed: (value) {
      if (value != null) {
        _sendMessage(value, member);
      }
    });
  }

  Future<void> _block() async {
    BlocProvider.of<MembershipBloc>(context).add(BlockMember());
  }

  Future<void> _promote() async {
    BlocProvider.of<MembershipBloc>(context).add(PromoteMember());
  }

  Future<void> _demote() async {
    BlocProvider.of<MembershipBloc>(context).add(DemoteMember());
  }

  Future<void> _unblock() async {
    BlocProvider.of<MembershipBloc>(context).add(UnblockMember());
  }

  void _sendMessage(
    String message,
    MemberPublicInfoModel member,
  ) {
    if (message == null) return;
    if (message.length == 0) return;
    AbstractNotificationPlatform.platform!.sendMessage(
        context, member.documentID!, message, postSendAction: (value) {
      Registry.registry()!.snackbar("Yay! Message sent!");
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MembershipBloc, MembershipState>(
        builder: (context, state) {
      if (state is MembershipLoaded) {
        var name;
        if (state.member!.name == null) {
          name = state.member!.name;
        } else {
          name = "No name";
        }

        return StyleRegistry.registry().styleWithContext(context).frontEndStyle().complexDialog(context, title: name +
            ' - ' +
            privilegeLevelToMemberRoleString(
                state.accessModel!.privilegeLevel,
                state.accessModel!.blocked), child: getFieldsWidget(
            context, state.appId!, state.accessModel!, state.member!));
      } else {
        return StyleRegistry.registry()
            .styleWithContext(context)
            .frontEndStyle()
            .progressIndicator(context);
      }
    });
  }
}
