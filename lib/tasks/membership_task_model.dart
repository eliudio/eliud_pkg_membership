import 'package:eliud_pkg_workflow/tools/task/task_model.dart';

abstract class MembershipTaskModel extends TaskModel {
  MembershipTaskModel({
    required super.identifier,
    required super.description,
    required super.executeInstantly,
  });
}
