import 'dart:async';

import 'package:eliud_core/core/blocs/access/access_bloc.dart';
import 'package:eliud_core/core/blocs/access/access_event.dart';
import 'package:eliud_core/core/wizards/registry/registry.dart';
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
import 'package:eliud_pkg_membership/wizards/membership_dashboard_wizard.dart';
import 'package:eliud_pkg_workflow/tools/task/task_model_registry.dart';

import 'model/repository_singleton.dart';

import 'package:eliud_pkg_membership/membership_package_stub.dart'
if (dart.library.io) 'membership_mobile_package.dart'
if (dart.library.html) 'membership_web_package.dart';

abstract class MembershipPackage extends Package {
  MembershipPackage() : super('eliud_pkg_membership');

  static final String MEMBER_HAS_NO_MEMBERSHIP_YET = 'MemberHasNoMembershipYet';
  Map<String, bool?> stateMEMBER_HAS_NO_MEMBERSHIP_YET = {};
  Map<String, StreamSubscription<List<AccessModel?>>> subscription = {};

  @override
  Future<List<PackageConditionDetails>>? getAndSubscribe(
      AccessBloc accessBloc,
      AppModel app,
      MemberModel? member,
      bool isOwner,
      bool? isBlocked,
      PrivilegeLevel? privilegeLevel) {
    String appId = app.documentID;
    subscription[appId]?.cancel();
    if (member != null) {
      final c = Completer<List<PackageConditionDetails>>();
      subscription[appId] =
          corerepo.accessRepository(appId: appId)!.listen((list) {
          var valueHasNoMembershipYet = list.isEmpty ||
              (list.first == null) ||
              ((list.first!.blocked == null) || (!list.first!.blocked!)) &&
                  ((list.first!.privilegeLevel == null) ||
                      (list.first!.privilegeLevel == PrivilegeLevel.NoPrivilege));

          if (!c.isCompleted) {
            // the first time we get this trigger, it's upon entry of the getAndSubscribe. Now we simply return the value
            stateMEMBER_HAS_NO_MEMBERSHIP_YET[appId] = valueHasNoMembershipYet;
            c.complete([
              PackageConditionDetails(
                  packageName: packageName,
                  conditionName: MEMBER_HAS_NO_MEMBERSHIP_YET,
                  value: valueHasNoMembershipYet)
            ]);
          } else {
            // subsequent calls we get this trigger, it's when the date has changed. Now add the event to the bloc
            if (valueHasNoMembershipYet !=
                stateMEMBER_HAS_NO_MEMBERSHIP_YET[appId]) {
              stateMEMBER_HAS_NO_MEMBERSHIP_YET[appId] =
                  valueHasNoMembershipYet;
              noMembershipYet(accessBloc, app, valueHasNoMembershipYet);
            }
            var first = list.first;
            if (first == null) {
              accessBloc.add(PrivilegeChangedEvent(
                app,
                PrivilegeLevel.NoPrivilege, false,
              ));

            } else {
              accessBloc.add(PrivilegeChangedEvent(
                app,
                first.privilegeLevel ?? PrivilegeLevel.NoPrivilege,
                first.blocked ?? false,
              ));
            }
          }
      }, eliudQuery: getAccessQuery(appId, member.documentID));
      return c.future;
    } else {
      stateMEMBER_HAS_NO_MEMBERSHIP_YET[appId] = false;
      return Future.value([
        PackageConditionDetails(
            packageName: packageName,
            conditionName: MEMBER_HAS_NO_MEMBERSHIP_YET,
            value: false)
      ]);
    }
  }

  void noMembershipYet(
      AccessBloc accessBloc, AppModel app, bool valueHasNoMembershipYet) {
    stateMEMBER_HAS_NO_MEMBERSHIP_YET[app.documentID] =
        valueHasNoMembershipYet;
    accessBloc.add(UpdatePackageConditionEvent(
        app, this, MEMBER_HAS_NO_MEMBERSHIP_YET, valueHasNoMembershipYet));
  }

  static EliudQuery getAccessQuery(String? appId, String? memberId) {
    return EliudQuery(theConditions: [
      EliudQueryCondition(DocumentIdField(), isEqualTo: memberId)
    ]);
  }

  @override
  Future<bool?> isConditionOk(
      AccessBloc accessBloc,
      String pluginCondition,
      AppModel app,
      MemberModel? member,
      bool isOwner,
      bool? isBlocked,
      PrivilegeLevel? privilegeLevel) async {
    if (member == null) return false;
    if (pluginCondition == MEMBER_HAS_NO_MEMBERSHIP_YET) {
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

    // register wizard for membership
    NewAppWizardRegistry.registry().register(MembershipDashboardWizard());

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

  static MembershipPackage instance() => getMembershipPackage();
}
