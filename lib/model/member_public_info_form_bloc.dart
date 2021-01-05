/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 member_public_info_form_bloc.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import 'package:eliud_core/tools/enums.dart';
import 'package:eliud_core/tools/common_tools.dart';

import 'package:eliud_core/model/rgb_model.dart';

import 'package:eliud_core/tools/string_validator.dart';

import 'package:eliud_core/model/repository_export.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';
import 'package:eliud_pkg_membership/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_membership/model/repository_export.dart';
import 'package:eliud_core/model/model_export.dart';
import '../tools/bespoke_models.dart';
import 'package:eliud_pkg_membership/model/model_export.dart';
import 'package:eliud_core/model/entity_export.dart';
import '../tools/bespoke_entities.dart';
import 'package:eliud_pkg_membership/model/entity_export.dart';

import 'package:eliud_pkg_membership/model/member_public_info_form_event.dart';
import 'package:eliud_pkg_membership/model/member_public_info_form_state.dart';
import 'package:eliud_pkg_membership/model/member_public_info_repository.dart';

class MemberPublicInfoFormBloc extends Bloc<MemberPublicInfoFormEvent, MemberPublicInfoFormState> {
  final FormAction formAction;
  final String appId;

  MemberPublicInfoFormBloc(this.appId, { this.formAction }): super(MemberPublicInfoFormUninitialized());
  @override
  Stream<MemberPublicInfoFormState> mapEventToState(MemberPublicInfoFormEvent event) async* {
    final currentState = state;
    if (currentState is MemberPublicInfoFormUninitialized) {
      if (event is InitialiseNewMemberPublicInfoFormEvent) {
        MemberPublicInfoFormLoaded loaded = MemberPublicInfoFormLoaded(value: MemberPublicInfoModel(
                                               documentID: "",
                                 name: "",
                                 photoURL: "",
                                 subscriptions: [],

        ));
        yield loaded;
        return;

      }


      if (event is InitialiseMemberPublicInfoFormEvent) {
        // Need to re-retrieve the document from the repository so that I get all associated types
        MemberPublicInfoFormLoaded loaded = MemberPublicInfoFormLoaded(value: await memberPublicInfoRepository(appId: appId).get(event.value.documentID));
        yield loaded;
        return;
      } else if (event is InitialiseMemberPublicInfoFormNoLoadEvent) {
        MemberPublicInfoFormLoaded loaded = MemberPublicInfoFormLoaded(value: event.value);
        yield loaded;
        return;
      }
    } else if (currentState is MemberPublicInfoFormInitialized) {
      MemberPublicInfoModel newValue = null;
      if (event is ChangedMemberPublicInfoDocumentID) {
        newValue = currentState.value.copyWith(documentID: event.value);
        if (formAction == FormAction.AddAction) {
          yield* _isDocumentIDValid(event.value, newValue).asStream();
        } else {
          yield SubmittableMemberPublicInfoForm(value: newValue);
        }

        return;
      }
      if (event is ChangedMemberPublicInfoName) {
        newValue = currentState.value.copyWith(name: event.value);
        yield SubmittableMemberPublicInfoForm(value: newValue);

        return;
      }
      if (event is ChangedMemberPublicInfoSubscriptions) {
        newValue = currentState.value.copyWith(subscriptions: event.value);
        yield SubmittableMemberPublicInfoForm(value: newValue);

        return;
      }
    }
  }


  DocumentIDMemberPublicInfoFormError error(String message, MemberPublicInfoModel newValue) => DocumentIDMemberPublicInfoFormError(message: message, value: newValue);

  Future<MemberPublicInfoFormState> _isDocumentIDValid(String value, MemberPublicInfoModel newValue) async {
    if (value == null) return Future.value(error("Provide value for documentID", newValue));
    if (value.length == 0) return Future.value(error("Provide value for documentID", newValue));
    Future<MemberPublicInfoModel> findDocument = memberPublicInfoRepository(appId: appId).get(value);
    return await findDocument.then((documentFound) {
      if (documentFound == null) {
        return SubmittableMemberPublicInfoForm(value: newValue);
      } else {
        return error("Invalid documentID: already exists", newValue);
      }
    });
  }


}

