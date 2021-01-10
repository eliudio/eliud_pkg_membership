import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/model/access_model.dart';
import 'package:eliud_core/tools/widgets/dialog_helper.dart';
import 'package:eliud_pkg_workflow/model/assignment_model.dart';
import 'package:eliud_pkg_workflow/tools/task/task_entity.dart';
import 'package:eliud_pkg_workflow/tools/task/task_model.dart';
import 'package:eliud_pkg_notifications/platform/platform.dart';
import 'package:eliud_pkg_workflow/tools/widgets/workflow_dialog_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'membership_task_entity.dart';

// ***** MembershipTaskModel *****

abstract class MembershipTaskModel extends TaskModel {
  MembershipTaskModel({
    String description,
    bool executeInstantly,
  }) : super(description: description, executeInstantly: executeInstantly);
}

// ***** RequestMembershipTaskModel *****

class RequestMembershipTaskModel extends MembershipTaskModel {
  RequestMembershipTaskModel({String description, bool executeInstantly})
      : super(
          description: description,
      executeInstantly: executeInstantly
        );

  @override
  Future<void> startTask(
      BuildContext context, AssignmentModel assignmentModel) {
    DialogStatefulWidgetHelper.openIt(
        context,
        YesNoDialog(
            title: 'Join',
            message: 'Do you want to request membership?',
            yesFunction: () => confirmMembershipRequest(
                  context,
                  assignmentModel,
                ),
            noFunction: () => Navigator.pop(context)));
    return null;
  }

  void confirmMembershipRequest(
      BuildContext context, AssignmentModel assignmentModel) {
/*
This is the wrong place to send this message
    AbstractNotificationPlatform.platform
        .sendMessage(context, assignmentModel.assigneeId, "You have requested membership for app " + assignmentModel.appId);
*/
    Navigator.pop(context);
    finishTask(
        context,
        assignmentModel,
        ExecutionResults(
          ExecutionStatus.success,
        ), null);
  }

  @override
  TaskEntity toEntity({String appId}) => RequestMembershipTaskEntity(
        description: description,
      executeInstantly: executeInstantly,
      );

  static RequestMembershipTaskModel fromEntity(
          RequestMembershipTaskEntity entity) =>
      RequestMembershipTaskModel(
        description: entity.description,
          executeInstantly: entity.executeInstantly
      );

  static RequestMembershipTaskEntity fromMap(Map snap) =>
      RequestMembershipTaskEntity(
        description: snap['description'],
          executeInstantly: snap['executeInstantly'],
      );
}

class RequestMembershipTaskModelMapper implements TaskModelMapper {
  @override
  TaskModel fromEntity(TaskEntity entity) =>
      RequestMembershipTaskModel.fromEntity(entity);

  @override
  TaskModel fromEntityPlus(TaskEntity entity) => fromEntity(entity);

  @override
  TaskEntity fromMap(Map map) => RequestMembershipTaskModel.fromMap(map);
}

// ***** ApproveMembershipTaskModel *****

class ApproveMembershipTaskModel extends MembershipTaskModel {
  static String label = 'MEMBERSHIP_TASK_APPROVE_MEMBERSHIP';

  ApproveMembershipTaskModel({String description, bool executeInstantly})
      : super(
    description: description,
      executeInstantly: executeInstantly,
  );

  @override
  Future<void> startTask(
      BuildContext context, AssignmentModel assignmentModel) {
    String feedback = null;
    DialogStatefulWidgetHelper.openIt(
      context,
      YesNoIgnoreDialogWithAssignmentResults(
          title: 'Membership request',
          message:
          'Below the payment details. Please review and confirm or decline and provide feedback.',
          yesLabel: 'Confirm membership',
          noLabel: 'Decline membership',
          resultsPrevious: assignmentModel.resultsPrevious,
          yesFunction: () => _approveMembershipRequest(context, assignmentModel,
              feedback),
          noFunction: () => _disapproveMembershipRequest(context, assignmentModel,
              feedback),
          extraFields: [
            DialogStateHelper().getListTile(
                leading: Icon(Icons.payment),
                title: DialogField(
                  valueChanged: (value) => feedback = value,
                  decoration: const InputDecoration(
                    hintText: 'Feedback to the member',
                    labelText: 'Feedback to the member',
                  ),
                ))
          ]),
    );
    return null;
  }

  Future<void> _approveMembershipRequest(
      BuildContext context, AssignmentModel assignmentModel, String comment) async {
    _sendMessage(context, assignmentModel, "Your membership request has been approved", comment);
    Navigator.pop(context);
    var accessModel = await accessRepository(appId: assignmentModel.appId).get(assignmentModel.reporter.documentID);
    if (accessModel != null) {
      accessModel.privilegeLevel = PrivilegeLevel.Level1Privilege;
      await accessRepository(appId: assignmentModel.appId).update(accessModel);
    }
    finishTask(
        context,
        assignmentModel,
        ExecutionResults(
          ExecutionStatus.success,
        ), null);
  }

  void _disapproveMembershipRequest(
      BuildContext context, AssignmentModel assignmentModel, String comment) {
    _sendMessage(context, assignmentModel, "Your membership request has been disapproved", comment);
    Navigator.pop(context);
    finishTask(
        context,
        assignmentModel,
        ExecutionResults(
          ExecutionStatus.success,  // declining the membership request is also a successful end of the task, from a task perspective
        ), null);
  }

  void _sendMessage(BuildContext context, AssignmentModel assignmentModel, String message, String comment) {
    if (!((comment == null) || (comment.length == 0))) {
      message = message + " with these comments: " + comment;
    }
    AbstractNotificationPlatform.platform.sendMessage(context, assignmentModel.assigneeId, message);
  }

  @override
  TaskEntity toEntity({String appId}) => ApproveMembershipTaskEntity(
    description: description,
      executeInstantly: executeInstantly,
  );

  static ApproveMembershipTaskModel fromEntity(
      ApproveMembershipTaskEntity entity) =>
      ApproveMembershipTaskModel(
        description: entity.description,
          executeInstantly: entity.executeInstantly,
      );

  static ApproveMembershipTaskEntity fromMap(Map snap) =>
      ApproveMembershipTaskEntity(
        description: snap['description'],
          executeInstantly: snap['executeInstantly'],
      );
}

class ApproveMembershipTaskModelMapper implements TaskModelMapper {
  @override
  TaskModel fromEntity(TaskEntity entity) =>
      ApproveMembershipTaskModel.fromEntity(entity);

  @override
  TaskModel fromEntityPlus(TaskEntity entity) => fromEntity(entity);

  @override
  TaskEntity fromMap(Map map) => ApproveMembershipTaskModel.fromMap(map);
}
