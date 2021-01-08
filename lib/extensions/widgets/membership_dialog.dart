import 'package:eliud_core/core/widgets/progress_indicator.dart';
import 'package:eliud_core/tools/tool_set.dart';
import 'package:eliud_pkg_notifications/platform/platform.dart';
import 'package:eliud_core/model/access_model.dart';
import 'package:eliud_core/tools/common_tools.dart';
import 'package:eliud_core/tools/widgets/dialog_helper.dart';
import 'package:eliud_pkg_membership/model/member_public_info_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flushbar/flushbar.dart';
import 'bloc/membership_bloc.dart';
import 'bloc/membership_event.dart';
import 'bloc/membership_state.dart';

class MembershipDialog extends StatefulWidget {
  MembershipDialog({
    Key key,
  }) : super(key: key);

  @override
  _MembershipDialogState createState() => _MembershipDialogState();
}

class _MembershipDialogState extends State<MembershipDialog> {
  final DialogStateHelper dialogHelper = DialogStateHelper();

  Widget getFieldsWidget(BuildContext context, String appId,
      AccessModel oldAccessModel, MemberPublicInfoModel member) {
    return dialogHelper.fieldsWidget(
        context, <Widget>[buttons(appId, oldAccessModel, member)],
        height: 200, width: 200);
  }

  Widget buttons(
      String appId, AccessModel oldAccessModel, MemberPublicInfoModel member) {
    var privilegeLevel;
    if (oldAccessModel != null) {
      privilegeLevel = oldAccessModel.privilegeLevel;
    } else {
      privilegeLevel = PrivilegeLevel.NoPrivilege;
    }
    List<Widget> _buttons = [];
    if (oldAccessModel.blocked) {
      _buttons.add(RaisedButton(
          onPressed: () =>
              _askUnblock(appId, oldAccessModel, member, privilegeLevel),
          child: Text('Unblock member')));
    } else if (privilegeLevel != PrivilegeLevel.OwnerPrivilege) {
      _buttons.add(RaisedButton(
          onPressed: () => _askBlock(appId, oldAccessModel, member),
          child: Text('Block member')));
    }
    if ((privilegeLevel.index >= PrivilegeLevel.NoPrivilege.index) &&
        (privilegeLevel.index < PrivilegeLevel.Level2Privilege.index)) {
      _buttons.add(RaisedButton(
          onPressed: () =>
              _askPromote(appId, oldAccessModel, member, privilegeLevel),
          child: Text('Promote member')));
    }
    if ((privilegeLevel.index > PrivilegeLevel.NoPrivilege.index) &&
        (privilegeLevel.index <= PrivilegeLevel.Level2Privilege.index)) {
      _buttons.add(RaisedButton(
          onPressed: () =>
              _askDemote(appId, oldAccessModel, member, privilegeLevel),
          child: Text('Demote member')));
    }
    _buttons.add(RaisedButton(
        onPressed: () => _askSendMessage(member), child: Text('Send message')));
    return ListView(
        shrinkWrap: true, physics: ScrollPhysics(), children: _buttons);
  }

  void _askBlock(
      String appId, AccessModel oldAccessModel, MemberPublicInfoModel member) {
    DialogStatefulWidgetHelper.openIt(
        context,
        YesNoDialog(
            title: 'Block',
            message: 'Do you want to block this member from the app?',
            yesFunction: () {
              _block(appId, oldAccessModel, member);
              Navigator.pop(context);
            },
            noFunction: () => Navigator.pop(context)));
  }

  void _askPromote(String appId, AccessModel oldAccessModel,
      MemberPublicInfoModel member, PrivilegeLevel privilegeLevel) {
    DialogStatefulWidgetHelper.openIt(
        context,
        YesNoDialog(
            title: 'Promote',
            message: 'Do you want to promote this member? Current level is ' +
                privilegeLevelToMemberRoleString(privilegeLevel),
            yesFunction: () {
              _promote(appId, oldAccessModel, member, privilegeLevel);
              Navigator.pop(context);
            },
            noFunction: () => Navigator.pop(context)));
  }

  Future<void> _askDemote(String appId, AccessModel oldAccessModel,
      MemberPublicInfoModel member, PrivilegeLevel privilegeLevel) async {
    DialogStatefulWidgetHelper.openIt(
        context,
        YesNoDialog(
            title: 'Promote',
            message: 'Do you want to demote this member? Current level is ' +
                privilegeLevelToPrivilegeString(privilegeLevel),
            yesFunction: () {
              _demote(appId, oldAccessModel, member, privilegeLevel);
              Navigator.pop(context);
            },
            noFunction: () => Navigator.pop(context)));
  }

  void _askUnblock(String appId, AccessModel oldAccessModel,
      MemberPublicInfoModel member, int privilegeLevel) {
    DialogStatefulWidgetHelper.openIt(
        context,
        YesNoDialog(
            title: 'Unblock',
            message: 'Do you want to unblock this member from the app?',
            yesFunction: () {
              _unblock(appId, oldAccessModel, member, privilegeLevel);
              Navigator.pop(context);
            },
            noFunction: () => Navigator.pop(context)));
  }

  void _askSendMessage(MemberPublicInfoModel member) {
    DialogStatefulWidgetHelper.openIt(
      context,
      RequestValueDialog(
          title: 'Send Message to Member',
          yesButtonText: 'Send message',
          noButtonText: 'Discard',
          hintText: 'Message',
          yesFunction: (msg) {
            _sendMessage(msg, member);
            Navigator.pop(context);
          },
          noFunction: () => Navigator.pop(context)),
    );
  }

  Future<void> _block(String appId, AccessModel oldAccessModel,
      MemberPublicInfoModel member) async {
    context.bloc<MembershipBloc>().add(BlockMember());
  }

  Future<void> _promote(String appId, AccessModel oldAccessModel,
      MemberPublicInfoModel member, PrivilegeLevel privilegeLevel) async {
    context.bloc<MembershipBloc>().add(PromoteMember());
  }

  Future<void> _demote(String appId, AccessModel oldAccessModel,
      MemberPublicInfoModel member, PrivilegeLevel privilegeLevel) async {
    context.bloc<MembershipBloc>().add(DemoteMember());
  }

  Future<void> _unblock(String appId, AccessModel oldAccessModel,
      MemberPublicInfoModel member, int privilegeLevel) async {
    context.bloc<MembershipBloc>().add(UnblockMember());
  }

  void _sendMessage(
    String message,
    MemberPublicInfoModel member,
  ) {
    AbstractNotificationPlatform.platform.sendMessage(
        context, member.documentID, message,
        postSendAction: (value) {
          Flushbar(
            title:  "Message",
            message:  "Yay! Message sent!",
            duration:  Duration(seconds: 3),
          )..show(context);
        });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MembershipBloc, MembershipState>(
        builder: (context, state) {
      if (state is MembershipLoaded) {
        return dialogHelper.build(
            title: state.member.name +
                ' - ' +
                privilegeLevelToMemberRoleString(state.accessModel.privilegeLevel),
            contents: getFieldsWidget(
                context, state.appId, state.accessModel, state.member),
            buttons: <FlatButton>[
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Close'))
            ]);
      } else {
        return DelayedCircularProgressIndicator();
      }
    });
  }
}
