import 'package:eliud_pkg_workflow/tools/task/task_entity.dart';

// ***** MembershipEntity *****

abstract class MembershipEntity extends TaskEntity {
  const MembershipEntity( { String? taskString, String? description, bool? executeInstantly }) : super(taskString: taskString, description: description, executeInstantly: executeInstantly);
}

class RequestMembershipTaskEntity extends MembershipEntity {
  static String label = 'MEMBERSHIP_TASK_REQUEST_MEMBERSHIP';

  RequestMembershipTaskEntity({String? description, bool? executeInstantly}) : super(description: description, taskString: label, executeInstantly: executeInstantly);

  @override
  Map<String, Object> toDocument() {
    return {
      'taskString': taskString == null ? '' : taskString!,
      'description': description == null ? '' : description!,
      'executeInstantly': executeInstantly == null ? '' : executeInstantly!,
    };
  }
}

class ApproveMembershipTaskEntity extends MembershipEntity {
  static String label = 'MEMBERSHIP_TASK_APPROVE_MEMBERSHIP';

  ApproveMembershipTaskEntity({String? description, bool? executeInstantly}) : super(description: description, taskString: label, executeInstantly: executeInstantly);

  @override
  Map<String, Object> toDocument() {
    return {
      'taskString': taskString == null ? '' : taskString!,
      'description': description == null ? '' : description!,
      'executeInstantly': executeInstantly == null ? '' : executeInstantly!,
    };
  }
}

