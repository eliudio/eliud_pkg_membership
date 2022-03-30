import 'package:eliud_core/core/blocs/access/access_bloc.dart';
import 'package:eliud_core/decoration/decoration.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/app_policy_item_model.dart';
import 'package:eliud_core/model/platform_medium_model.dart';
import 'package:eliud_core/model/public_medium_model.dart';
import 'package:eliud_core/style/frontend/has_button.dart';
import 'package:eliud_core/style/frontend/has_container.dart';
import 'package:eliud_core/style/frontend/has_dialog.dart';
import 'package:eliud_core/style/frontend/has_dialog_field.dart';
import 'package:eliud_core/style/frontend/has_divider.dart';
import 'package:eliud_core/style/frontend/has_list_tile.dart';
import 'package:eliud_core/style/frontend/has_progress_indicator.dart';
import 'package:eliud_core/style/frontend/has_text.dart';
import 'package:eliud_core/tools/random.dart';
import 'package:eliud_core/tools/screen_size.dart';
import 'package:eliud_core/tools/storage/public_medium_helper.dart';
import 'package:eliud_core/tools/widgets/editor/select_action_widget.dart';
import 'package:eliud_core/tools/widgets/header_widget.dart';
import 'package:eliud_core/tools/widgets/pos_size_widget.dart';
import 'package:eliud_pkg_etc/model/member_action_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';

typedef void MemberActionModelCallback(MemberActionModel memberActionModel);

class MemberActionModelWidget extends StatefulWidget {
  final bool create;
  final double widgetWidth;
  final double widgetHeight;
  final AppModel app;
  final MemberActionModel memberActionModel;
  final MemberActionModelCallback memberActionModelCallback;
  final int containerPrivilege;

  MemberActionModelWidget._({
    Key? key,
    required this.app,
    required this.create,
    required this.widgetWidth,
    required this.widgetHeight,
    required this.memberActionModel,
    required this.memberActionModelCallback,
    required this.containerPrivilege,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MemberActionModelWidgetState();
  }

  static Widget getIt(
      BuildContext context,
      AppModel app,
      bool create,
      double widgetWidth,
      double widgetHeight,
      MemberActionModel memberActionModel,
      MemberActionModelCallback memberActionModelCallback,
      int containerPrivilege) {
    var copyOf = memberActionModel.copyWith();
    return MemberActionModelWidget._(
      app: app,
      create: create,
      widgetWidth: widgetWidth,
      widgetHeight: widgetHeight,
      memberActionModel: copyOf,
      memberActionModelCallback: memberActionModelCallback,
      containerPrivilege: containerPrivilege,
    );
  }
}

class _MemberActionModelWidgetState extends State<MemberActionModelWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView(shrinkWrap: true, physics: ScrollPhysics(), children: [
      HeaderWidget(
        app: widget.app,
        cancelAction: () async {
          return true;
        },
        okAction: () async {
          widget.memberActionModelCallback(widget.memberActionModel);
          return true;
        },
        title: 'Membership action details',
      ),
      divider(widget.app, context),
      topicContainer(widget.app, context,
          title: 'General',
          collapsible: true,
          collapsed: true,
          children: [
            getListTile(context, widget.app,
                leading: Icon(Icons.vpn_key),
                title: text(
                    widget.app, context, widget.memberActionModel.documentID!)),
            getListTile(context, widget.app,
                leading: Icon(Icons.description),
                title: dialogField(
                  widget.app,
                  context,
                  initialValue: widget.memberActionModel.description,
                  valueChanged: (value) {
                    widget.memberActionModel.description = value;
                  },
                  maxLines: 1,
                  decoration: const InputDecoration(
                    hintText: 'Description',
                    labelText: 'Description',
                  ),
                )),
          ]),
      SelectActionWidget(app: widget.app, action: widget.memberActionModel.action,
          containerPrivilege: widget.containerPrivilege,
          label: 'action',
          actionSelected: (action) {
        setState(() {
          widget.memberActionModel.action = action;
        });
      }),
    ]);
  }
}
