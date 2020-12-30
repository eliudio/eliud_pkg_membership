import 'package:eliud_pkg_workflow/tools/task/task_entity.dart';

// ***** MembershipEntity *****

abstract class MembershipEntity extends TaskEntity {
  const MembershipEntity( { String taskString, String description }) : super(taskString: taskString, description: description);
}

class RequestMembershipTaskEntity extends MembershipEntity {
  static String label = 'MEMBERSHIP_TASK_REQUEST_MEMBERSHIP';

  RequestMembershipTaskEntity({String description, }) : super(description: description, taskString: label, );

  @override
  Map<String, Object> toDocument() {
    return {
      'taskString': taskString,
      'description': description,
    };
  }
}

class ApproveMembershipTaskEntity extends MembershipEntity {
  static String label = 'MEMBERSHIP_TASK_APPROVE_MEMBERSHIP';

  ApproveMembershipTaskEntity({String description, }) : super(description: description, taskString: label, );

  @override
  Map<String, Object> toDocument() {
    return {
      'taskString': taskString,
      'description': description,
    };
  }
}

