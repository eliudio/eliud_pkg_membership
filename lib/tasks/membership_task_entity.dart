import 'package:eliud_pkg_workflow/tools/task/task_entity.dart';

abstract class MembershipEntity extends TaskEntity {
  const MembershipEntity(
      {required String identifier,
      required String description,
      required bool executeInstantly})
      : super(
            identifier: identifier,
            description: description,
            executeInstantly: executeInstantly);
}
