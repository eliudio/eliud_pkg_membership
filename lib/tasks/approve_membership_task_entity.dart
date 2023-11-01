
import 'approve_membership_task_model.dart';
import 'membership_task_entity.dart';

class ApproveMembershipTaskEntity extends MembershipEntity {
  ApproveMembershipTaskEntity(
      {required String description, required bool executeInstantly})
      : super(
        identifier: ApproveMembershipTaskModel.label,
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
