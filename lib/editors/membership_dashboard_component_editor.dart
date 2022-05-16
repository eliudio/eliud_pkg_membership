import 'package:eliud_core/core/blocs/access/state/access_determined.dart';
import 'package:eliud_core/core/blocs/access/state/access_state.dart';
import 'package:eliud_core/core/editor/ext_editor_base_bloc/ext_editor_base_event.dart';
import 'package:eliud_core/core/editor/ext_editor_base_bloc/ext_editor_base_state.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/storage_conditions_model.dart';
import 'package:eliud_core/style/frontend/has_button.dart';
import 'package:eliud_core/style/frontend/has_container.dart';
import 'package:eliud_core/style/frontend/has_dialog.dart';
import 'package:eliud_core/style/frontend/has_dialog_field.dart';
import 'package:eliud_core/style/frontend/has_divider.dart';
import 'package:eliud_core/style/frontend/has_list_tile.dart';
import 'package:eliud_core/style/frontend/has_progress_indicator.dart';
import 'package:eliud_core/style/frontend/has_text.dart';
import 'package:eliud_core/tools/component/component_spec.dart';
import 'package:eliud_core/tools/random.dart';
import 'package:eliud_core/tools/screen_size.dart';
import 'package:eliud_core/tools/widgets/condition_simple_widget.dart';
import 'package:eliud_core/tools/widgets/header_widget.dart';
import 'package:eliud_pkg_etc/model/member_action_model.dart';
import 'package:eliud_pkg_etc/editors/widgets/member_action_model_widget.dart';
import 'package:eliud_pkg_membership/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_membership/model/membership_dashboard_model.dart';
import 'package:flutter/material.dart';
import 'package:eliud_core/core/blocs/access/access_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'membership_dashboard_bloc/membership_dashboard_bloc.dart';

class MembershipDashboardComponentEditorConstructor
    extends ComponentEditorConstructor {
  @override
  void updateComponent(
      AppModel app, BuildContext context, model, EditorFeedback feedback) {
    _openIt(app, context, false, model.copyWith(), feedback);
  }

  @override
  void createNewComponent(
      AppModel app, BuildContext context, EditorFeedback feedback) {
    _openIt(
        app,
        context,
        true,
        MembershipDashboardModel(
          appId: app.documentID,
          documentID: newRandomKey(),
          description: 'New membership dashboard',
          conditions: StorageConditionsModel(
              privilegeLevelRequired:
                  PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple),
        ),
        feedback);
  }

  @override
  void updateComponentWithID(AppModel app, BuildContext context, String id,
      EditorFeedback feedback) async {
    var membershipDashboard =
        await membershipDashboardRepository(appId: app.documentID!)!.get(id);
    if (membershipDashboard != null) {
      _openIt(app, context, false, membershipDashboard, feedback);
    } else {
      openErrorDialog(app, context, app.documentID! + '/_error',
          title: 'Error',
          errorMessage: 'Cannot find membership dashboard with id $id');
    }
  }

  void _openIt(AppModel app, BuildContext context, bool create,
      MembershipDashboardModel model, EditorFeedback feedback) {
    openComplexDialog(
      app,
      context,
      app.documentID! + '/membershipdashboard',
      title: create
          ? 'Create Membership Dashboard'
          : 'Update Membership Dashboard',
      includeHeading: false,
      widthFraction: .9,
      child: BlocProvider<MembershipDashboardBloc>(
          create: (context) => MembershipDashboardBloc(
                app.documentID!,
                /*create,
            */
                feedback,
              )..add(ExtEditorBaseInitialise<MembershipDashboardModel>(model)),
          child: MembershipDashboardComponentEditor(
            app: app,
          )),
    );
  }
}

class MembershipDashboardComponentEditor extends StatefulWidget {
  final AppModel app;

  const MembershipDashboardComponentEditor({
    Key? key,
    required this.app,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      _MembershipDashboardComponentEditorState();
}

class _MembershipDashboardComponentEditorState
    extends State<MembershipDashboardComponentEditor> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccessBloc, AccessState>(
        builder: (aContext, accessState) {
      if (accessState is AccessDetermined) {
        return BlocBuilder<MembershipDashboardBloc,
                ExtEditorBaseState<MembershipDashboardModel>>(
            builder: (ppContext, membershipDashboardState) {
          if (membershipDashboardState
              is ExtEditorBaseInitialised<MembershipDashboardModel, dynamic>) {
            return ListView(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                children: [
                  HeaderWidget(
                    app: widget.app,
                    title: 'MembershipDashboard',
                    okAction: () async {
                      await BlocProvider.of<MembershipDashboardBloc>(context)
                          .save(ExtEditorBaseApplyChanges<
                                  MembershipDashboardModel>(
                              model: membershipDashboardState.model));
                      return true;
                    },
                    cancelAction: () async {
                      return true;
                    },
                  ),
                  topicContainer(widget.app, context,
                      title: 'General',
                      collapsible: true,
                      collapsed: true,
                      children: [
                        getListTile(context, widget.app,
                            leading: Icon(Icons.vpn_key),
                            title: text(widget.app, context,
                                membershipDashboardState.model.documentID!)),
                        getListTile(context, widget.app,
                            leading: Icon(Icons.description),
                            title: dialogField(
                              widget.app,
                              context,
                              initialValue:
                                  membershipDashboardState.model.description,
                              valueChanged: (value) {
                                membershipDashboardState.model.description =
                                    value;
                              },
                              maxLines: 1,
                              decoration: const InputDecoration(
                                hintText: 'Description',
                                labelText: 'Description',
                              ),
                            )),
                      ]),
                  topicContainer(widget.app, context,
                      title: 'Member actions',
                      collapsible: true,
                      collapsed: true,
                      children: [
                        _actions(membershipDashboardState),
                      ]),
                  topicContainer(widget.app, context,
                      title: 'Condition',
                      collapsible: true,
                      collapsed: true,
                      children: [
                        getListTile(context, widget.app,
                            leading: Icon(Icons.security),
                            title: ConditionsSimpleWidget(
                              app: widget.app,
                              value: membershipDashboardState.model.conditions!,
                            )),
                      ]),
                ]);
          } else {
            return progressIndicator(widget.app, context);
          }
        });
      } else {
        return progressIndicator(widget.app, context);
      }
    });
  }

  Widget _actions(
      ExtEditorBaseInitialised<MembershipDashboardModel, dynamic> state) {
    List<MemberActionModel> items =
        state.model.memberActions != null ? state.model.memberActions! : [];
    return Container(
      height: 150,
      child: ListView(shrinkWrap: true, physics: ScrollPhysics(), children: [
        Container(
            height: 100,
            child: ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                //separatorBuilder: (context, index) => divider(widget.app, context),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final value = items[index];
                  return getListTile(
                    context,
                    widget.app,
                    title: text(widget.app, context,
                        (value.text ?? '?') + ' ' + (value.description ?? '?')),
                    trailing: popupMenuButton<int>(
                        widget.app, context,
                        child: Icon(Icons.more_vert),
                        itemBuilder: (context) => [
                              popupMenuItem(
                                widget.app, context,
                                value: 1,
                                label: 'Update',
                              ),
                              popupMenuItem(
                                widget.app, context,
                                value: 2,
                                label: 'Delete',
                              ),
                            ],
                        onSelected: (selectedValue) {
                          if (selectedValue == 1) {
                            open(
                                value,
                                (newItem) =>
                                    BlocProvider.of<MembershipDashboardBloc>(
                                            context)
                                        .add(UpdateItemEvent<
                                                MembershipDashboardModel,
                                                MemberActionModel>(
                                            oldItem: value, newItem: newItem)),
                                ((state.model.conditions == null) ||
                                        (state.model.conditions!
                                                .privilegeLevelRequired ==
                                            null))
                                    ? 0
                                    : state.model.conditions!
                                        .privilegeLevelRequired!.index);
                          } else if (selectedValue == 2) {
                            BlocProvider.of<MembershipDashboardBloc>(context)
                                .add(DeleteItemEvent<MembershipDashboardModel,
                                    MemberActionModel>(itemModel: value));
                          }
                        }),
                  );
                })),
        divider(
          widget.app,
          context,
        ),
        Row(children: [
          Spacer(),
          button(
            widget.app,
            context,
            icon: Icon(
              Icons.add,
            ),
            label: 'Add',
            onPressed: () {
              open(
                  MemberActionModel(
                    documentID: newRandomKey(),
                    text: 'new action',
                    description: 'new action',
                    action: null,
                  ),
                  (newItem) => BlocProvider.of<MembershipDashboardBloc>(context)
                      .add(AddItemEvent(itemModel: newItem)),
                  ((state.model.conditions == null) ||
                          (state.model.conditions!.privilegeLevelRequired ==
                              null))
                      ? 0
                      : state.model.conditions!.privilegeLevelRequired!.index);
            },
          ),
          Spacer(),
        ])
      ]),
    );
  }

  void open(
      MemberActionModel value,
      MemberActionModelCallback memberActionModelCallback,
      int privilegeContainer) {
    openFlexibleDialog(
      widget.app,
      context,
      widget.app.documentID! + '/_memberaction',
      includeHeading: false,
      widthFraction: .8,
      child: MemberActionModelWidget.getIt(
          context,
          widget.app,
          false,
          fullScreenWidth(context) * .8,
          fullScreenHeight(context) - 100,
          value,
          memberActionModelCallback,
          privilegeContainer),
    );
  }
}
