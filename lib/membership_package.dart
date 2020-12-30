import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:eliud_core/core/navigate/navigate_bloc.dart';
import 'package:eliud_core/eliud.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/component_registry.dart';
import 'package:eliud_core/model/member_model.dart';
import 'package:eliud_core/tools/common_tools.dart';
import 'package:eliud_pkg_membership/tools/task/membership_task_entity.dart';
import 'package:eliud_pkg_membership/tools/task/membership_task_model.dart';
import 'package:flutter_bloc/src/bloc_provider.dart';
import 'package:eliud_pkg_workflow/tools/task/task_model.dart';

abstract class MembershipPackage extends Package {
  static final String MEMBER_HAS_NO_MEMBERSHIP_YET = 'MemberHasNoMembershipYet';

  @override
  BlocProvider createMainBloc(NavigatorBloc navigatorBloc, AccessBloc accessBloc) => null;

  @override
  Future<bool> isConditionOk(String packageCondition, AppModel app, MemberModel member, bool isOwner, int privilegeLevel) async {
    if (member == null) return false;
    if (packageCondition == MEMBER_HAS_NO_MEMBERSHIP_YET) {
      return (privilegeLevel == NO_PRIVILEGE);
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
    TaskModelRegistry.registry().addMapper(RequestMembershipTaskEntity.label, RequestMembershipTaskModelMapper());
  }
}
