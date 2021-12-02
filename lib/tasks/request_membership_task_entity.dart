import 'package:eliud_pkg_membership/tasks/request_membership_task_model.dart';

import 'approve_membership_task_model.dart';
import 'membership_task_entity.dart';

class RequestMembershipTaskEntity extends MembershipEntity {
  RequestMembershipTaskEntity(
      {required String description, required bool executeInstantly})
      : super(
            identifier: RequestMembershipTaskModel.label,
            description: description,
            executeInstantly: executeInstantly);

  @override
  Map<String, Object> toDocument() {
    return {
      'identifier': identifier,
      'description': description,
      'executeInstantly': executeInstantly,
    };
  }
}