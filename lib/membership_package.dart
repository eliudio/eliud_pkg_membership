import 'dart:async';

import 'package:eliud_core/access/access_bloc.dart';
import 'package:eliud_core/access/access_event.dart';
import 'package:eliud_core_helpers/query/query_tools.dart';
import 'package:eliud_core_main/apis/wizard_api/new_app_wizard_info.dart';
import 'package:eliud_core/core_package.dart';
import 'package:eliud_core/eliud.dart';
import 'package:eliud_core_model/model/abstract_repository_singleton.dart'
    as corerepo;
import 'package:eliud_core_main/tools/etc/member_collection_info.dart';
import 'package:eliud_core_model/model/access_model.dart';
import 'package:eliud_core_main/model/app_model.dart';
import 'package:eliud_core_main/model/member_model.dart';
import 'package:eliud_core/package/package.dart';
import 'package:eliud_pkg_etc/etc_package.dart';
import 'package:eliud_pkg_membership/tasks/approve_membership_task_model.dart';
import 'package:eliud_pkg_membership/tasks/approve_membership_task_model_mapper.dart';
import 'package:eliud_pkg_membership/tasks/request_membership_task_model.dart';
import 'package:eliud_pkg_membership/tasks/request_membership_task_model_mapper.dart';
import 'package:eliud_pkg_membership/wizards/membership_dashboard_wizard.dart';
import 'package:eliud_pkg_membership_model/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_membership_model/model/component_registry.dart';
import 'package:eliud_pkg_membership_model/model/repository_singleton.dart';
import 'package:eliud_pkg_notifications/notifications_package.dart';
import 'package:eliud_pkg_workflow/workflow_package.dart';
import 'package:eliud_pkg_workflow_model/tools/task/task_model_registry.dart';

import 'editors/membership_dashboard_component_editor.dart';
import 'extensions/membership_dashboard_component.dart';

import 'package:eliud_pkg_membership/membership_package_stub.dart'
    if (dart.library.io) 'membership_mobile_package.dart'
    if (dart.library.html) 'membership_web_package.dart';

abstract class MembershipPackage extends Package {
  MembershipPackage() : super('eliud_pkg_membership');

  static final String memberHasNoMembershipYet = 'MemberHasNoMembershipYet';
  final Map<String, bool?> stateMemberHasNoMembershipYet = {};
  final Map<String, StreamSubscription<List<AccessModel?>>> subscription = {};

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
                    (list.first!.privilegeLevel == PrivilegeLevel.noPrivilege));

        if (!c.isCompleted) {
          // the first time we get this trigger, it's upon entry of the getAndSubscribe. Now we simply return the value
          stateMemberHasNoMembershipYet[appId] = valueHasNoMembershipYet;
          c.complete([
            PackageConditionDetails(
                packageName: packageName,
                conditionName: memberHasNoMembershipYet,
                value: valueHasNoMembershipYet)
          ]);
        } else {
          // subsequent calls we get this trigger, it's when the date has changed. Now add the event to the bloc
          if (valueHasNoMembershipYet != stateMemberHasNoMembershipYet[appId]) {
            stateMemberHasNoMembershipYet[appId] = valueHasNoMembershipYet;
            noMembershipYet(accessBloc, app, valueHasNoMembershipYet);
          }
          var first = list.first;
          if (first == null) {
            accessBloc.add(PrivilegeChangedEvent(
              app,
              PrivilegeLevel.noPrivilege,
              false,
            ));
          } else {
            accessBloc.add(PrivilegeChangedEvent(
              app,
              first.privilegeLevel ?? PrivilegeLevel.noPrivilege,
              first.blocked ?? false,
            ));
          }
        }
      }, eliudQuery: getAccessQuery(appId, member.documentID));
      return c.future;
    } else {
      stateMemberHasNoMembershipYet[appId] = false;
      return Future.value([
        PackageConditionDetails(
            packageName: packageName,
            conditionName: memberHasNoMembershipYet,
            value: false)
      ]);
    }
  }

  void noMembershipYet(
      AccessBloc accessBloc, AppModel app, bool valueHasNoMembershipYet) {
    stateMemberHasNoMembershipYet[app.documentID] = valueHasNoMembershipYet;
    accessBloc.add(UpdatePackageConditionEvent(
        app, this, memberHasNoMembershipYet, valueHasNoMembershipYet));
  }

  static EliudQuery getAccessQuery(String? appId, String? memberId) {
    return EliudQuery(theConditions: [
      EliudQueryCondition(DocumentIdField(), isEqualTo: memberId)
    ]);
  }

  Future<bool?> isConditionOk(
      AccessBloc accessBloc,
      String pluginCondition,
      AppModel app,
      MemberModel? member,
      bool isOwner,
      bool? isBlocked,
      PrivilegeLevel? privilegeLevel) async {
    if (member == null) return false;
    if (pluginCondition == memberHasNoMembershipYet) {
      return (privilegeLevel == PrivilegeLevel.noPrivilege);
    }
    return null;
  }

  @override
  List<String> retrieveAllPackageConditions() {
    return [memberHasNoMembershipYet];
  }

  @override
  void init() {
    ComponentRegistry().init(
      MembershipDashboardComponentConstructorDefault(),
      MembershipDashboardComponentEditorConstructor(),
    );

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

  /*
   * Register depending packages
   */
  @override
  void registerDependencies(Eliud eliud) {
    eliud.registerPackage(CorePackage.instance());
    eliud.registerPackage(WorkflowPackage.instance());
    eliud.registerPackage(NotificationsPackage.instance());
    eliud.registerPackage(EtcPackage.instance());
  }
}
