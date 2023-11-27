import 'package:eliud_pkg_membership/tasks/request_membership_task_entity.dart';
import 'package:eliud_pkg_membership/tasks/request_membership_task_model.dart';
import 'package:eliud_pkg_workflow_model/tools/task/task_entity.dart';
import 'package:eliud_pkg_workflow_model/tools/task/task_model.dart';
import 'package:eliud_pkg_workflow_model/tools/task/task_model_mapper.dart';

class RequestMembershipTaskModelMapper implements TaskModelMapper {
  @override
  TaskModel fromEntity(TaskEntity entity) =>
      RequestMembershipTaskModel.fromEntity(
          entity as RequestMembershipTaskEntity);

  @override
  TaskModel fromEntityPlus(TaskEntity entity) => fromEntity(entity);

  @override
  TaskEntity fromMap(Map map) => RequestMembershipTaskModel.fromMap(map);
}
