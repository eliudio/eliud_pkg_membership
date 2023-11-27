import 'package:eliud_pkg_workflow_model/tools/task/task_entity.dart';
import 'package:eliud_pkg_workflow_model/tools/task/task_model.dart';
import 'package:eliud_pkg_workflow_model/tools/task/task_model_mapper.dart';

import 'approve_membership_task_entity.dart';
import 'approve_membership_task_model.dart';

class ApproveMembershipTaskModelMapper implements TaskModelMapper {
  @override
  TaskModel fromEntity(TaskEntity entity) =>
      ApproveMembershipTaskModel.fromEntity(
          entity as ApproveMembershipTaskEntity);

  @override
  TaskModel fromEntityPlus(TaskEntity entity) => fromEntity(entity);

  @override
  TaskEntity fromMap(Map map) => ApproveMembershipTaskModel.fromMap(map);
}
