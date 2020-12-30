import 'package:eliud_core/tools/widgets/dialog_helper.dart';
import 'package:eliud_pkg_workflow/model/assignment_model.dart';
import 'package:eliud_pkg_workflow/tools/task/task_entity.dart';
import 'package:eliud_pkg_workflow/tools/task/task_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'membership_task_entity.dart';

// ***** MembershipTaskModel *****

abstract class MembershipTaskModel extends TaskModel {
  MembershipTaskModel({
    String description,
  }) : super(description: description);
}

// ***** RequestMembershipTaskModel *****

class RequestMembershipTaskModel extends MembershipTaskModel {
  static String label = 'MEMBERSHIP_TASK_REQUEST_MEMBERSHIP';

  RequestMembershipTaskModel({String description})
      : super(
          description: description,
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
    // first: send message "membership requested"
    Navigator.pop(context);
    finishTask(
        context,
        assignmentModel,
        ExecutionResults(
          ExecutionStatus.success,
        ));
  }

  @override
  TaskEntity toEntity({String appId}) => RequestMembershipTaskEntity(
        description: description,
      );

  static RequestMembershipTaskModel fromEntity(
          RequestMembershipTaskEntity entity) =>
      RequestMembershipTaskModel(
        description: entity.description,
      );

  static RequestMembershipTaskEntity fromMap(Map snap) =>
      RequestMembershipTaskEntity(
        description: snap['description'],
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

  ApproveMembershipTaskModel({String description})
      : super(
    description: description,
  );

  @override
  Future<void> startTask(
      BuildContext context, AssignmentModel assignmentModel) {
    // Present the details from the previous task
    // Then ask if it's ok to approve, if yes >> approveMembershipRequest, if no >> disapproveMembershipRequest
    // Allow Feedback parameter
  }

  void _approveMembershipRequest(
      BuildContext context, AssignmentModel assignmentModel) {
    // todo: send message "membership requested approved". Use feedback parameter
    finishTask(
        context,
        assignmentModel,
        ExecutionResults(
          ExecutionStatus.success,
        ));
  }

  void _disapproveMembershipRequest(
      BuildContext context, AssignmentModel assignmentModel) {
    // todo: send message "membership requested disapproved". Use feedback parameter
    finishTask(
        context,
        assignmentModel,
        ExecutionResults(
          ExecutionStatus.success,  // declining the membership request is also a successful end of the task, from a task perspective
        ));
  }

  @override
  TaskEntity toEntity({String appId}) => ApproveMembershipTaskEntity(
    description: description,
  );

  static ApproveMembershipTaskModel fromEntity(
      ApproveMembershipTaskEntity entity) =>
      ApproveMembershipTaskModel(
        description: entity.description,
      );

  static ApproveMembershipTaskEntity fromMap(Map snap) =>
      ApproveMembershipTaskEntity(
        description: snap['description'],
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
