import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:eliud_core/model/access_model.dart';
import 'package:eliud_core/tools/common_tools.dart';

import 'package:eliud_pkg_membership/model/abstract_repository_singleton.dart';
import 'package:eliud_core/model/member_public_info_model.dart';

import 'membership_event.dart';
import 'membership_state.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart';

class MembershipBloc extends Bloc<MembershipEvent, MembershipState> {
  MembershipBloc(): super(UnitializedMembership());

  PrivilegeLevelBeforeBlocked PLToPLBL(PrivilegeLevel privilegeLevel) {
    switch (privilegeLevel) {
      case PrivilegeLevel.NoPrivilege: return PrivilegeLevelBeforeBlocked.NoPrivilege;
      case PrivilegeLevel.Level1Privilege: return PrivilegeLevelBeforeBlocked.Level1Privilege;
      case PrivilegeLevel.Level2Privilege: return PrivilegeLevelBeforeBlocked.Level2Privilege;
      case PrivilegeLevel.OwnerPrivilege: return PrivilegeLevelBeforeBlocked.OwnerPrivilege;
      case PrivilegeLevel.Unknown: return PrivilegeLevelBeforeBlocked.NoPrivilege;
    }
    return PrivilegeLevelBeforeBlocked.NoPrivilege;
  }

  PrivilegeLevel PLBLToPL(PrivilegeLevelBeforeBlocked privilegeLevelBeforeBlocked) {
    switch (privilegeLevelBeforeBlocked) {
      case PrivilegeLevelBeforeBlocked.NoPrivilege: return PrivilegeLevel.NoPrivilege;
      case PrivilegeLevelBeforeBlocked.Level1Privilege: return PrivilegeLevel.Level1Privilege;
      case PrivilegeLevelBeforeBlocked.Level2Privilege: return PrivilegeLevel.Level2Privilege;
      case PrivilegeLevelBeforeBlocked.OwnerPrivilege: return PrivilegeLevel.OwnerPrivilege;
      case PrivilegeLevelBeforeBlocked.Unknown: return PrivilegeLevel.NoPrivilege;
    }
    return PrivilegeLevel.NoPrivilege;
  }

  PrivilegeLevel intToPL(int level) {
    switch (level) {
      case 0: return PrivilegeLevel.NoPrivilege;
      case 1: return PrivilegeLevel.Level1Privilege;
      case 2: return PrivilegeLevel.Level2Privilege;
      case 3: return PrivilegeLevel.OwnerPrivilege;
    }
    return PrivilegeLevel.NoPrivilege;
  }

  @override
  Stream<MembershipState> mapEventToState(MembershipEvent event) async* {
    if (event is FetchMembershipEvent) {
      var accessModel = await accessRepository(appId: event.appId)!.get(event.memberId);
      var member = await memberPublicInfoRepository(appId: event.appId)!.get(event.memberId);
      yield MembershipLoaded(accessModel, event.appId, member);
    } else if (state is MembershipLoaded) {
      MembershipLoaded theState = state as MembershipLoaded;
      if (event is BlockMember) {
        yield await _update(theState.appId, theState.accessModel, AccessModel(
          documentID: theState.member!.documentID,
          privilegeLevel: PrivilegeLevel.NoPrivilege,
          privilegeLevelBeforeBlocked: PLToPLBL(theState.accessModel!.privilegeLevel!),
          blocked: true,
        ), theState.member);
      } else if (event is UnblockMember) {
          yield await _update(theState.appId, theState.accessModel, AccessModel(
            documentID: theState.member!.documentID!,
            privilegeLevel: PLBLToPL(theState.accessModel!.privilegeLevelBeforeBlocked!),
            privilegeLevelBeforeBlocked: null,
            blocked: false,
          ), theState.member);
      } else if (event is PromoteMember) {
        if (theState.accessModel!.privilegeLevel!.index <= PrivilegeLevel.OwnerPrivilege.index) {
          yield await _update(theState.appId, theState.accessModel, AccessModel(
            documentID: theState.member!.documentID,
            privilegeLevel: intToPL(theState.accessModel!.privilegeLevel!.index + 1),
          ), theState.member);
        }
      } else if (event is DemoteMember) {
        if (theState.accessModel!.privilegeLevel!.index > PrivilegeLevel.NoPrivilege.index) {
          yield await _update(
              theState.appId, theState.accessModel, AccessModel(
            documentID: theState.member!.documentID,
            privilegeLevel: intToPL(theState.accessModel!.privilegeLevel!.index - 1),
          ), theState.member);
        }
      }
    }
  }

  Future<MembershipLoaded> _update(String? appId, AccessModel? oldAccessModel, AccessModel? newAccessModel, MemberPublicInfoModel? member) async {
    if (oldAccessModel == null) {
      await accessRepository(appId: appId)!.add(newAccessModel!);
    } else {
      await accessRepository(appId: appId)!.update(newAccessModel!);
    }
    return MembershipLoaded(newAccessModel, appId, member);
  }


}


