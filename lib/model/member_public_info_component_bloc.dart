/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 member_public_info_component_bloc.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'dart:async';
import 'package:bloc/bloc.dart';

import 'package:eliud_pkg_membership/model/member_public_info_model.dart';
import 'package:eliud_pkg_membership/model/member_public_info_component_event.dart';
import 'package:eliud_pkg_membership/model/member_public_info_component_state.dart';
import 'package:eliud_pkg_membership/model/member_public_info_repository.dart';
import 'package:flutter/services.dart';

class MemberPublicInfoComponentBloc extends Bloc<MemberPublicInfoComponentEvent, MemberPublicInfoComponentState> {
  final MemberPublicInfoRepository memberPublicInfoRepository;

  MemberPublicInfoComponentBloc({ this.memberPublicInfoRepository }): super(MemberPublicInfoComponentUninitialized());
  @override
  Stream<MemberPublicInfoComponentState> mapEventToState(MemberPublicInfoComponentEvent event) async* {
    final currentState = state;
    if (event is FetchMemberPublicInfoComponent) {
      try {
        if (currentState is MemberPublicInfoComponentUninitialized) {
          bool permissionDenied = false;
          final model = await memberPublicInfoRepository.get(event.id, onError: (error) {
            // Unfortunatly the below is currently the only way we know how to identify if a document is read protected
            if ((error is PlatformException) &&  (error.message.startsWith("PERMISSION_DENIED"))) {
              permissionDenied = true;
            }
          });
          if (permissionDenied) {
            yield MemberPublicInfoComponentPermissionDenied();
          } else {
            if (model != null) {
              yield MemberPublicInfoComponentLoaded(value: model);
            } else {
              String id = event.id;
              yield MemberPublicInfoComponentError(
                  message: "MemberPublicInfo with id = '$id' not found");
            }
          }
          return;
        }
      } catch (_) {
        yield MemberPublicInfoComponentError(message: "Unknown error whilst retrieving MemberPublicInfo");
      }
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }

}

