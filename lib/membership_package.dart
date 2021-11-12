import 'dart:async';

import 'package:eliud_core/model/abstract_repository_singleton.dart'
    as corerepo;
import 'package:eliud_core/model/access_model.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/member_model.dart';
import 'package:eliud_core/package/package.dart';
import 'package:eliud_core/tools/query/query_tools.dart';
import 'package:eliud_pkg_membership/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_membership/model/component_registry.dart';
import 'package:eliud_pkg_membership/tasks/approve_membership_task_model.dart';
import 'package:eliud_pkg_membership/tasks/approve_membership_task_model_mapper.dart';
import 'package:eliud_pkg_membership/tasks/request_membership_task_model.dart';
import 'package:eliud_pkg_membership/tasks/request_membership_task_model_mapper.dart';
import 'package:eliud_pkg_workflow/tools/task/task_model.dart';
import 'package:eliud_pkg_workflow/tools/task/task_model_registry.dart';

import 'model/repository_singleton.dart';

abstract class MembershipPackage extends Package {
  MembershipPackage() : super('eliud_pkg_membership');

  static final String MEMBER_HAS_NO_MEMBERSHIP_YET = 'MemberHasNoMembershipYet';
  AccessModel? stateAccesModel;
  late StreamSubscription<List<AccessModel?>> subscription;

  void _setState(AccessModel? currentAccess, {MemberModel? currentMember}) {
    if (stateAccesModel != currentAccess) {
      // force the member's screen to update when blocked state is different
      var refresh = (stateAccesModel != null) &&
          (currentAccess != null) &&
          (stateAccesModel!.blocked != currentAccess.blocked);
      stateAccesModel = currentAccess;
    }
  }

  @override
  void resubscribe(AppModel? app, MemberModel? currentMember) {
    var appId = app!.documentID;
    if (currentMember != null) {
      subscription = corerepo.accessRepository(appId: appId)!.listen((list) {
        if (list.isNotEmpty) {
          _setState(list.first, currentMember: currentMember);
        } else {
          _setState(null, currentMember: currentMember);
        }
      }, eliudQuery: getAccessQuery(appId, currentMember.documentID));
    } else {
      _setState(null);
    }
  }

  static EliudQuery getAccessQuery(String? appId, String? memberId) {
    return EliudQuery(theConditions: [
      EliudQueryCondition(DocumentIdField(), isEqualTo: memberId)
    ]);
  }

  @override
  Future<bool?> isConditionOk(
      String? packageCondition,
      AppModel? app,
      MemberModel? member,
      bool? isOwner,
      bool? isBlocked,
      PrivilegeLevel? privilegeLevel) async {
    if (member == null) return false;
    if (packageCondition == MEMBER_HAS_NO_MEMBERSHIP_YET) {
      return (privilegeLevel == PrivilegeLevel.NoPrivilege);
    }
    return null;
  }

  @override
  List<String> retrieveAllPackageConditions() {
    return [MEMBER_HAS_NO_MEMBERSHIP_YET];
  }

  @override
  void init() {
    ComponentRegistry().init();

    // Initialise repository singleton
    AbstractRepositorySingleton.singleton = RepositorySingleton();

    // Register mappers for extra tasks
    TaskModelRegistry.registry()!.addTask(
        identifier: RequestMembershipTaskModel.label,
        definition: RequestMembershipTaskModel.definition,
        mapper: RequestMembershipTaskModelMapper(),
        createNewInstance: () => RequestMembershipTaskModel(
            identifier: RequestMembershipTaskModel.label,
            description: 'Request membership',
            executeInstantly: true));
    TaskModelRegistry.registry()!.addTask(
        identifier: ApproveMembershipTaskModel.label,
        definition: ApproveMembershipTaskModel.definition,
        mapper: ApproveMembershipTaskModelMapper(),
        createNewInstance: () => ApproveMembershipTaskModel(
            identifier: ApproveMembershipTaskModel.label,
            description: 'Approve membership',
            executeInstantly: true));
  }

  @override
  List<MemberCollectionInfo> getMemberCollectionInfo() =>
      AbstractRepositorySingleton.collections;
}
