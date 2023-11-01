import 'package:eliud_pkg_workflow/tools/task/task_model.dart';


abstract class MembershipTaskModel extends TaskModel {
  MembershipTaskModel({
    required String identifier,
    required String description,
    required bool executeInstantly,
  }) : super(identifier: identifier, description: description, executeInstantly: executeInstantly);
}
