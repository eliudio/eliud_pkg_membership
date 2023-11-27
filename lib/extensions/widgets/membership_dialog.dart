import 'package:eliud_core_main/apis/apis.dart';
import 'package:eliud_core_main/model/member_public_info_model.dart';
import 'package:eliud_core_model/model/access_model.dart';
import 'package:eliud_core_main/model/app_model.dart';
import 'package:eliud_core_main/apis/style/frontend/has_button.dart';
import 'package:eliud_core_main/apis/style/frontend/has_container.dart';
import 'package:eliud_core_main/apis/style/frontend/has_dialog.dart';
import 'package:eliud_core_main/apis/style/frontend/has_dialog_widget.dart';
import 'package:eliud_core_main/apis/style/frontend/has_progress_indicator.dart';
import 'package:eliud_core/tools/tool_set.dart';
import 'package:eliud_pkg_notifications/platform/platform.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/membership_bloc.dart';
import 'bloc/membership_event.dart';
import 'bloc/membership_state.dart';

class MembershipDialog extends StatefulWidget {
  final AppModel app;

  MembershipDialog({
    super.key,
    required this.app,
  });

  @override
  State<MembershipDialog> createState() => _MembershipDialogState();
}

class _MembershipDialogState extends State<MembershipDialog> {
  Widget getFieldsWidget(BuildContext context, String appId,
      AccessModel? oldAccessModel, MemberPublicInfoModel member) {
    return simpleTopicContainer(widget.app, context,
        children: <Widget>[buttons(oldAccessModel, member)],
        height: 200,
        width: 200);
  }

  Widget buttons(AccessModel? oldAccessModel, MemberPublicInfoModel member) {
    PrivilegeLevel privilegeLevel;
    bool blocked;
    if (oldAccessModel != null) {
      privilegeLevel =
          oldAccessModel.privilegeLevel ?? PrivilegeLevel.noPrivilege;
      blocked = oldAccessModel.blocked ?? false;
    } else {
      privilegeLevel = PrivilegeLevel.noPrivilege;
      blocked = false;
    }
    List<Widget> buttons = [];
    if (blocked) {
      buttons.add(button(widget.app, context,
          label: 'Unblock member', onPressed: () => _askUnblock()));
    } else {
      if (privilegeLevel != PrivilegeLevel.ownerPrivilege) {
        buttons.add(button(widget.app, context,
            label: 'Block member', onPressed: () => _askBlock(member)));
      }
      if ((privilegeLevel.index >= PrivilegeLevel.noPrivilege.index) &&
          (privilegeLevel.index < PrivilegeLevel.level2Privilege.index)) {
        buttons.add(button(widget.app, context,
            label: 'Promote member',
            onPressed: () => _askPromote(privilegeLevel, blocked)));
      }
      if ((privilegeLevel.index > PrivilegeLevel.noPrivilege.index) &&
          (privilegeLevel.index <= PrivilegeLevel.level2Privilege.index)) {
        buttons.add(button(widget.app, context,
            label: 'Demote member',
            onPressed: () => _askDemote(privilegeLevel, blocked)));
      }
    }
    buttons.add(button(widget.app, context,
        label: 'Send message', onPressed: () => _askSendMessage(member)));
    return ListView(
        shrinkWrap: true, physics: ScrollPhysics(), children: buttons);
  }

  void _askBlock(MemberPublicInfoModel member) {
    openAckNackDialog(widget.app, context, '${widget.app.documentID}/_block',
        title: 'Block',
        message: 'Do you want to block this member from the app?',
        onSelection: (value) {
      if (value == 0) {
        _block();
      }
    });
  }

  void _askPromote(PrivilegeLevel privilegeLevel, bool blocked) {
    openAckNackDialog(widget.app, context, '${widget.app.documentID}/_promote',
        title: 'Promote',
        message:
            'Do you want to promote this member? Current level is ${privilegeLevelToMemberRoleString(privilegeLevel, blocked)}',
        onSelection: (value) {
      if (value == 0) {
        _promote();
      }
    });
  }

  Future<void> _askDemote(PrivilegeLevel privilegeLevel, bool blocked) async {
    openAckNackDialog(widget.app, context, '${widget.app.documentID}/_demote',
        title: 'Demote',
        message:
            'Do you want to demote this member? Current level is ${privilegeLevelToPrivilegeString(privilegeLevel, blocked)}',
        onSelection: (value) {
      if (value == 0) {
        _demote();
      }
    });
  }

  void _askUnblock() {
    openAckNackDialog(
      widget.app,
      context,
      '${widget.app.documentID}/_unblock',
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
    openEntryDialog(widget.app, context, '${widget.app.documentID}/_sendmsg',
        title: 'Send Message to Member',
        hintText: 'Message',
        ackButtonLabel: 'Send message',
        nackButtonLabel: 'Discard', onPressed: (value) {
      if (value != null) {
        _sendMessage(widget.app, value, member);
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
    AppModel app,
    String message,
    MemberPublicInfoModel member,
  ) {
    if (message.isEmpty) return;
    AbstractNotificationPlatform.platform!
        .sendMessage(app, widget.app.ownerID, member.documentID, message,
            postSendAction: (value) {
      Apis.apis().getRegistryApi().snackbar("Yay! Message sent!");
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MembershipBloc, MembershipState>(
        builder: (context, state) {
      if (state is MembershipLoaded) {
        var name = state.member!.name ?? "No name";

        return complexDialog(widget.app, context,
            title:
                '$name - ${privilegeLevelToMemberRoleString(state.accessModel == null ? PrivilegeLevel.noPrivilege : state.accessModel!.privilegeLevel, state.accessModel == null ? false : state.accessModel!.blocked)}',
            child: getFieldsWidget(
                context, state.appId, state.accessModel, state.member!));
      } else {
        return progressIndicator(widget.app, context);
      }
    });
  }
}
