import 'package:eliud_core/core/blocs/access/access_bloc.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/model/access_model.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/style/frontend/has_dialog.dart';
import 'package:eliud_core/style/frontend/has_dialog_field.dart';
import 'package:eliud_core/style/frontend/has_list_tile.dart';
import 'package:eliud_core/style/style_registry.dart';
import 'package:eliud_pkg_workflow/model/assignment_model.dart';
import 'package:eliud_pkg_workflow/tools/task/execution_results.dart';
import 'package:eliud_pkg_workflow/tools/task/task_entity.dart';
import 'package:eliud_pkg_workflow/tools/task/task_model.dart';
import 'package:eliud_pkg_notifications/platform/platform.dart';
import 'package:eliud_pkg_workflow/tools/widgets/workflow_dialog_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'approve_membership_task_entity.dart';
import 'membership_task_entity.dart';
import 'membership_task_model.dart';

class ApproveMembershipTaskModel extends MembershipTaskModel {
  static String label = 'MEMBERSHIP_TASK_APPROVE_MEMBERSHIP';
  static String definition = "Approve membership";

  ApproveMembershipTaskModel(
      {required String identifier,
      required String description,
      required bool executeInstantly})
      : super(
            identifier: identifier,
            description: description,
            executeInstantly: executeInstantly);

  @override
  Future<void> startTask(AppModel app,
      BuildContext context, String? memberId, AssignmentModel? assignmentModel) {
    if (assignmentModel == null) return Future.value(null);
    if (memberId == null) throw Exception("Can't approve membership when no member");
    String? feedback;
    openWidgetDialog(app,
      context,
      app.documentID! + '/membershipreq',
      child: YesNoIgnoreDialogWithAssignmentResults.get(app, context,
          title: 'Membership request',
          message:
              'Below the payment details. Please review and confirm or decline and provide feedback.',
          yesLabel: 'Confirm membership',
          noLabel: 'Decline membership',
          resultsPrevious: assignmentModel.resultsPrevious, yesFunction: () async {
        await _approveMembershipRequest(app, context, memberId, assignmentModel, feedback);
      }, noFunction: () async {
        await _disapproveMembershipRequest(app, context, memberId, assignmentModel, feedback);
      }, extraFields: [
        getListTile(context, app,
            leading: Icon(Icons.payment),
            title: dialogField(app,
              context,
              valueChanged: (value) => feedback = value,
              decoration: const InputDecoration(
                hintText: 'Feedback to the member',
                labelText: 'Feedback to the member',
              ),
            )),
      ]),
    );
    return Future.value(null);
  }

  Future<void> _approveMembershipRequest(AppModel app, BuildContext context, String memberId,
      AssignmentModel assignmentModel, String? comment) async {
    _sendMessage(app, memberId, assignmentModel,
        "Your membership request has been approved", comment);
    if (assignmentModel.reporterId == null) {
      print("assignmentModel.reporterId is null");
      return Future.value(null);
    }
    var accessModel = await accessRepository(appId: assignmentModel.appId)!
        .get(assignmentModel.reporterId);
    if (accessModel != null) {
      accessModel.privilegeLevel = PrivilegeLevel.Level1Privilege;
      await accessRepository(appId: assignmentModel.appId)!.update(accessModel);
    } else {
      await accessRepository(appId: assignmentModel.appId)!.add(AccessModel(
        documentID: assignmentModel.reporterId,
        privilegeLevel: PrivilegeLevel.Level1Privilege,
        points: 0,
        blocked: false,
      ));
    }
    await finishTask(app,
        context,
        assignmentModel,
        ExecutionResults(
          ExecutionStatus.success,
        ),
        null);
  }

  Future<void> _disapproveMembershipRequest(AppModel app, BuildContext context, String memberId,
      AssignmentModel assignmentModel, String? comment) async {
    _sendMessage(app, memberId, assignmentModel,
        "Your membership request has been disapproved", comment);
    await finishTask(app,
        context,
        assignmentModel,
        ExecutionResults(
          ExecutionStatus
              .success, // declining the membership request is also a successful end of the task, from a task perspective
        ),
        null);
  }

  void _sendMessage(AppModel app, String memberId, AssignmentModel assignmentModel,
      String message, String? comment) {
    if (!((comment == null) || (comment.length == 0))) {
      message = message + " with these comments: " + comment;
    }
    if (assignmentModel == null) return;
    AbstractNotificationPlatform.platform!
        .sendMessage(app, memberId, assignmentModel.assigneeId!, message);
  }

  @override
  TaskEntity toEntity({String? appId}) => ApproveMembershipTaskEntity(
        description: description,
        executeInstantly: executeInstantly,
      );

  static ApproveMembershipTaskModel fromEntity(
          ApproveMembershipTaskEntity entity) =>
      ApproveMembershipTaskModel(
        identifier: entity.identifier,
        description: entity.description,
        executeInstantly: entity.executeInstantly,
      );

  static ApproveMembershipTaskEntity fromMap(Map snap) =>
      ApproveMembershipTaskEntity(
        description: snap['description'],
        executeInstantly: snap['executeInstantly'],
      );
}
