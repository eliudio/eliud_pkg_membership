import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:eliud_core/model/access_model.dart';
import 'package:eliud_core/tools/common_tools.dart';

import 'package:eliud_pkg_membership/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_membership/model/member_public_info_model.dart';

import 'membership_event.dart';
import 'membership_state.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart';

class MembershipBloc extends Bloc<MembershipEvent, MembershipState> {
  MembershipBloc(): super(UnitializedMembership());

  @override
  Stream<MembershipState> mapEventToState(MembershipEvent event) async* {
    if (event is FetchMembershipEvent) {
      var accessModel = await accessRepository(appId: event.appId).get(event.memberId);
      var member = await memberPublicInfoRepository(appId: event.appId).get(event.memberId);
      yield MembershipLoaded(accessModel, event.appId, member);
    } else if (state is MembershipLoaded) {
      MembershipLoaded theState = state as MembershipLoaded;
      if (event is BlockMember) {
        yield await _update(theState.appId, theState.accessModel, AccessModel(
          documentID: theState.member.documentID,
          privilegeLevel: BLOCKED_MEMBERSHIP,
        ), theState.member);
      } else if (event is UnblockMember) {
          yield await _update(theState.appId, theState.accessModel, AccessModel(
            documentID: theState.member.documentID,
            privilegeLevel: NO_PRIVILEGE,
          ), theState.member);
      } else if (event is PromoteMember) {
        if (theState.accessModel.privilegeLevel <= LEVEL2_PRIVILEGE) {
          yield await _update(theState.appId, theState.accessModel, AccessModel(
            documentID: theState.member.documentID,
            privilegeLevel: theState.accessModel.privilegeLevel + 1,
          ), theState.member);
        }
      } else if (event is DemoteMember) {
        if (theState.accessModel.privilegeLevel > NO_PRIVILEGE) {
          yield await _update(
              theState.appId, theState.accessModel, AccessModel(
            documentID: theState.member.documentID,
            privilegeLevel: theState.accessModel.privilegeLevel - 1,
          ), theState.member);
        }
      }
    }
  }

  Future<MembershipLoaded> _update(String appId, AccessModel oldAccessModel, AccessModel newAccessModel, MemberPublicInfoModel member) async {
    if (oldAccessModel == null) {
      await accessRepository(appId: appId).add(newAccessModel);
    } else {
      await accessRepository(appId: appId).update(newAccessModel);
    }
    return MembershipLoaded(newAccessModel, appId, member);
  }


}


