import 'package:eliud_pkg_membership/tasks/request_membership_task_model.dart';

import 'membership_task_entity.dart';

class RequestMembershipTaskEntity extends MembershipEntity {
  RequestMembershipTaskEntity(
      {required super.description, required super.executeInstantly})
      : super(identifier: RequestMembershipTaskModel.label);

  @override
  Map<String, Object> toDocument() {
    return {
      'identifier': identifier,
      'description': description,
      'executeInstantly': executeInstantly,
    };
  }
}
