import 'package:eliud_pkg_workflow_model/tools/task/task_entity.dart';

abstract class MembershipEntity extends TaskEntity {
  const MembershipEntity(
      {required super.identifier,
      required super.description,
      required super.executeInstantly});
}
