/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 membership_dashboard_form_bloc.dart
                       
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

import 'package:eliud_pkg_membership/model/membership_dashboard_form_event.dart';
import 'package:eliud_pkg_membership/model/membership_dashboard_form_state.dart';
import 'package:eliud_pkg_membership/model/membership_dashboard_repository.dart';

class MembershipDashboardFormBloc extends Bloc<MembershipDashboardFormEvent, MembershipDashboardFormState> {
  final FormAction formAction;
  final String appId;

  MembershipDashboardFormBloc(this.appId, { this.formAction }): super(MembershipDashboardFormUninitialized());
  @override
  Stream<MembershipDashboardFormState> mapEventToState(MembershipDashboardFormEvent event) async* {
    final currentState = state;
    if (currentState is MembershipDashboardFormUninitialized) {
      if (event is InitialiseNewMembershipDashboardFormEvent) {
        MembershipDashboardFormLoaded loaded = MembershipDashboardFormLoaded(value: MembershipDashboardModel(
                                               documentID: "",
                                 appId: "",
                                 description: "",

        ));
        yield loaded;
        return;

      }


      if (event is InitialiseMembershipDashboardFormEvent) {
        // Need to re-retrieve the document from the repository so that I get all associated types
        MembershipDashboardFormLoaded loaded = MembershipDashboardFormLoaded(value: await membershipDashboardRepository(appId: appId).get(event.value.documentID));
        yield loaded;
        return;
      } else if (event is InitialiseMembershipDashboardFormNoLoadEvent) {
        MembershipDashboardFormLoaded loaded = MembershipDashboardFormLoaded(value: event.value);
        yield loaded;
        return;
      }
    } else if (currentState is MembershipDashboardFormInitialized) {
      MembershipDashboardModel newValue = null;
      if (event is ChangedMembershipDashboardDocumentID) {
        newValue = currentState.value.copyWith(documentID: event.value);
        if (formAction == FormAction.AddAction) {
          yield* _isDocumentIDValid(event.value, newValue).asStream();
        } else {
          yield SubmittableMembershipDashboardForm(value: newValue);
        }

        return;
      }
      if (event is ChangedMembershipDashboardAppId) {
        newValue = currentState.value.copyWith(appId: event.value);
        yield SubmittableMembershipDashboardForm(value: newValue);

        return;
      }
      if (event is ChangedMembershipDashboardDescription) {
        newValue = currentState.value.copyWith(description: event.value);
        yield SubmittableMembershipDashboardForm(value: newValue);

        return;
      }
    }
  }


  DocumentIDMembershipDashboardFormError error(String message, MembershipDashboardModel newValue) => DocumentIDMembershipDashboardFormError(message: message, value: newValue);

  Future<MembershipDashboardFormState> _isDocumentIDValid(String value, MembershipDashboardModel newValue) async {
    if (value == null) return Future.value(error("Provide value for documentID", newValue));
    if (value.length == 0) return Future.value(error("Provide value for documentID", newValue));
    Future<MembershipDashboardModel> findDocument = membershipDashboardRepository(appId: appId).get(value);
    return await findDocument.then((documentFound) {
      if (documentFound == null) {
        return SubmittableMembershipDashboardForm(value: newValue);
      } else {
        return error("Invalid documentID: already exists", newValue);
      }
    });
  }


}

