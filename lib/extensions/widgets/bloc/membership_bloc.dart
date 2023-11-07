import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/model/access_model.dart';
import 'package:eliud_core/model/member_public_info_model.dart';

import 'membership_event.dart';
import 'membership_state.dart';

class MembershipBloc extends Bloc<MembershipEvent, MembershipState> {
  PrivilegeLevelBeforeBlocked plToPlbb(PrivilegeLevel privilegeLevel) {
    switch (privilegeLevel) {
      case PrivilegeLevel.noPrivilege:
        return PrivilegeLevelBeforeBlocked.noPrivilege;
      case PrivilegeLevel.level1Privilege:
        return PrivilegeLevelBeforeBlocked.level1Privilege;
      case PrivilegeLevel.level2Privilege:
        return PrivilegeLevelBeforeBlocked.level2Privilege;
      case PrivilegeLevel.ownerPrivilege:
        return PrivilegeLevelBeforeBlocked.ownerPrivilege;
      case PrivilegeLevel.unknown:
        return PrivilegeLevelBeforeBlocked.noPrivilege;
    }
  }

  PrivilegeLevel plbbToPl(
      PrivilegeLevelBeforeBlocked privilegeLevelBeforeBlocked) {
    switch (privilegeLevelBeforeBlocked) {
      case PrivilegeLevelBeforeBlocked.noPrivilege:
        return PrivilegeLevel.noPrivilege;
      case PrivilegeLevelBeforeBlocked.level1Privilege:
        return PrivilegeLevel.level1Privilege;
      case PrivilegeLevelBeforeBlocked.level2Privilege:
        return PrivilegeLevel.level2Privilege;
      case PrivilegeLevelBeforeBlocked.ownerPrivilege:
        return PrivilegeLevel.ownerPrivilege;
      case PrivilegeLevelBeforeBlocked.unknown:
        return PrivilegeLevel.noPrivilege;
    }
  }

  PrivilegeLevel intToPL(int level) {
    switch (level) {
      case 0:
        return PrivilegeLevel.noPrivilege;
      case 1:
        return PrivilegeLevel.level1Privilege;
      case 2:
        return PrivilegeLevel.level2Privilege;
      case 3:
        return PrivilegeLevel.ownerPrivilege;
    }
    return PrivilegeLevel.noPrivilege;
  }

  MembershipBloc() : super(UnitializedMembership()) {
    on<FetchMembershipEvent>((event, emit) async {
      var accessModel = await accessRepository(appId: event.app.documentID)!
          .get(event.memberId);
      //??   AccessModel(documentID: event.memberId, appId: event.app.documentID, privilegeLevel: PrivilegeLevel.NoPrivilege, points: 0, blocked: false, ) ;
      var member =
          await memberPublicInfoRepository(appId: event.app.documentID)!
              .get(event.memberId);
      emit(MembershipLoaded(accessModel, event.app.documentID, member));
    });

    on<BlockMember>((event, emit) async {
      if (state is MembershipLoaded) {
        MembershipLoaded theState = state as MembershipLoaded;

        emit(await _update(
            theState.appId,
            theState.accessModel,
            AccessModel(
              appId: theState.appId,
              documentID: theState.member!.documentID,
              privilegeLevel: PrivilegeLevel.noPrivilege,
              privilegeLevelBeforeBlocked: theState.accessModel == null
                  ? PrivilegeLevelBeforeBlocked.noPrivilege
                  : plToPlbb(theState.accessModel!.privilegeLevel!),
              blocked: true,
            ),
            theState.member));
      }
    });

    on<UnblockMember>((event, emit) async {
      if (state is MembershipLoaded) {
        MembershipLoaded theState = state as MembershipLoaded;
        emit(await _update(
            theState.appId,
            theState.accessModel,
            AccessModel(
              appId: theState.appId,
              documentID: theState.member!.documentID,
              privilegeLevel:
                  plbbToPl(theState.accessModel!.privilegeLevelBeforeBlocked!),
              privilegeLevelBeforeBlocked: null,
              blocked: false,
            ),
            theState.member));
      }
    });

    on<PromoteMember>((event, emit) async {
      if (state is MembershipLoaded) {
        MembershipLoaded theState = state as MembershipLoaded;

        if ((theState.accessModel == null) ||
            (theState.accessModel!.privilegeLevel!.index <=
                PrivilegeLevel.ownerPrivilege.index)) {
          emit(await _update(
              theState.appId,
              theState.accessModel,
              AccessModel(
                appId: theState.appId,
                documentID: theState.member!.documentID,
                privilegeLevel: theState.accessModel == null
                    ? PrivilegeLevel.level1Privilege
                    : intToPL(theState.accessModel!.privilegeLevel!.index + 1),
              ),
              theState.member));
        }
      }
    });

    on<DemoteMember>((event, emit) async {
      if (state is MembershipLoaded) {
        MembershipLoaded theState = state as MembershipLoaded;

        if (theState.accessModel!.privilegeLevel!.index >
            PrivilegeLevel.noPrivilege.index) {
          emit(await _update(
              theState.appId,
              theState.accessModel,
              AccessModel(
                appId: theState.appId,
                documentID: theState.member!.documentID,
                privilegeLevel:
                    intToPL(theState.accessModel!.privilegeLevel!.index - 1),
              ),
              theState.member));
        }
      }
    });
  }

  Future<MembershipLoaded> _update(String appId, AccessModel? oldAccessModel,
      AccessModel? newAccessModel, MemberPublicInfoModel? member) async {
    if (oldAccessModel == null) {
      await accessRepository(appId: appId)!.add(newAccessModel!);
    } else {
      await accessRepository(appId: appId)!.update(newAccessModel!);
    }
    return MembershipLoaded(newAccessModel, appId, member);
  }
}
