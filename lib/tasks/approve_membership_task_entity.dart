import 'approve_membership_task_model.dart';
import 'membership_task_entity.dart';

class ApproveMembershipTaskEntity extends MembershipEntity {
  ApproveMembershipTaskEntity(
      {required super.description, required super.executeInstantly})
      : super(identifier: ApproveMembershipTaskModel.label);

  @override
  Map<String, Object> toDocument() {
    return {
      'identifier': identifier,
      'description': description,
      'executeInstantly': executeInstantly,
    };
  }
}
