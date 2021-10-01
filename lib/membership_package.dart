import 'package:eliud_core/core/access/bloc/access_event.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart' as corerepo;
import 'package:eliud_core/model/access_model.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/member_model.dart';
import 'package:eliud_core/package/package.dart';
import 'package:eliud_core/package/package_with_subscription.dart';
import 'package:eliud_core/tools/query/query_tools.dart';
import 'package:eliud_pkg_membership/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_membership/model/component_registry.dart';
import 'package:eliud_pkg_membership/tools/task/membership_task_entity.dart';
import 'package:eliud_pkg_membership/tools/task/membership_task_model.dart';
import 'package:eliud_pkg_workflow/tools/task/task_model.dart';

import 'model/repository_singleton.dart';

abstract class MembershipPackage extends PackageWithSubscription {
  MembershipPackage() : super('eliud_pkg_membership');

  static final String MEMBER_HAS_NO_MEMBERSHIP_YET = 'MemberHasNoMembershipYet';
  AccessModel? stateAccesModel;

  void _setState(AccessModel? currentAccess, {MemberModel? currentMember}) {
    if (stateAccesModel != currentAccess) {
      // force the member's screen to update when blocked state is different
      var refresh = (stateAccesModel != null) && (currentAccess != null) && (stateAccesModel!.blocked != currentAccess.blocked);
      accessBloc!.add(MemberUpdated(currentMember, refresh: refresh));
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
      }, eliudQuery: getAccessQuery(
          appId, currentMember.documentID));
    } else {
      _setState(null);
    }
  }

  void unsubscribe() {
    super.unsubscribe();
    _setState(null);
  }

  static EliudQuery getAccessQuery(String? appId, String? memberId) {
    return EliudQuery(
        theConditions: [EliudQueryCondition(
            DocumentIdField(),
            isEqualTo: memberId
        )]
    );
  }

  @override
  Future<bool?> isConditionOk(String? packageCondition, AppModel? app, MemberModel? member, bool? isOwner, bool? isBlocked, PrivilegeLevel? privilegeLevel) async {
    if (member == null) return false;
    if (packageCondition == MEMBER_HAS_NO_MEMBERSHIP_YET) {
      return (privilegeLevel == PrivilegeLevel.NoPrivilege);
    }
    return null;
  }

  @override
  List<String> retrieveAllPackageConditions() {
    return [ MEMBER_HAS_NO_MEMBERSHIP_YET ];
  }

  @override
  void init() {
    ComponentRegistry().init();

    // Initialise repository singleton
    AbstractRepositorySingleton.singleton = RepositorySingleton();

    // Register mappers for extra tasks
    TaskModelRegistry.registry()!.addMapper(RequestMembershipTaskEntity.label, RequestMembershipTaskModelMapper());
    TaskModelRegistry.registry()!.addMapper(ApproveMembershipTaskEntity.label, ApproveMembershipTaskModelMapper());
  }

  @override
  List<MemberCollectionInfo> getMemberCollectionInfo() => AbstractRepositorySingleton.collections;
}
