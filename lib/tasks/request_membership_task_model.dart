import 'package:eliud_core/core/blocs/access/access_bloc.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/style/frontend/has_dialog.dart';
import 'package:eliud_pkg_membership/tasks/request_membership_task_entity.dart';
import 'package:eliud_pkg_workflow/model/assignment_model.dart';
import 'package:eliud_pkg_workflow/tools/task/execution_results.dart';
import 'package:eliud_pkg_workflow/tools/task/task_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'membership_task_model.dart';

class RequestMembershipTaskModel extends MembershipTaskModel {
  static String label = 'MEMBERSHIP_TASK_REQUEST_MEMBERSHIP';
  static String definition = "Request membership";

  RequestMembershipTaskModel({required String identifier, required String description, required bool executeInstantly})
      : super(identifier: identifier, description: description, executeInstantly: executeInstantly);

  @override
  Future<void> startTask(AppModel app,
      BuildContext context, String? memberId, AssignmentModel? assignmentModel) {
    if ((context == null) || (assignmentModel == null))
      return Future.value(null);

    openAckNackDialog(app, context,
        app.documentID! + '/membershipreq',
        title: 'Join',
        message: 'Do you want to request membership?', onSelection: (value) {
      if (value == 0) {
        confirmMembershipRequest(app,
          context,
          assignmentModel,
        );
      }
    });
    return Future.value(null);
  }

  void confirmMembershipRequest(AppModel app,
      BuildContext context, AssignmentModel assignmentModel) {
/*
This is the wrong place to send this message
    AbstractNotificationPlatform.platform
        .sendMessage(context, assignmentModel.assigneeId, "You have requested membership for app " + assignmentModel.appId);
*/
    finishTask(app,
        context,
        assignmentModel,
        ExecutionResults(
          ExecutionStatus.success,
        ),
        null);
  }

  @override
  TaskEntity toEntity({String? appId}) => RequestMembershipTaskEntity(
        description: description,
        executeInstantly: executeInstantly,
      );

  static RequestMembershipTaskModel fromEntity(
          RequestMembershipTaskEntity entity) =>
      RequestMembershipTaskModel(
          identifier: entity.identifier,
          description: entity.description,
          executeInstantly: entity.executeInstantly);

  static RequestMembershipTaskEntity fromMap(Map snap) =>
      RequestMembershipTaskEntity(
        description: snap['description'],
        executeInstantly: snap['executeInstantly'],
      );
}
