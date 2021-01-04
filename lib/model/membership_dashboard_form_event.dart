/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 membership_dashboard_form_event.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:eliud_core/tools/common_tools.dart';
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


@immutable
abstract class MembershipDashboardFormEvent extends Equatable {
  const MembershipDashboardFormEvent();

  @override
  List<Object> get props => [];
}

class InitialiseNewMembershipDashboardFormEvent extends MembershipDashboardFormEvent {
}


class InitialiseMembershipDashboardFormEvent extends MembershipDashboardFormEvent {
  final MembershipDashboardModel value;

  @override
  List<Object> get props => [ value ];

  InitialiseMembershipDashboardFormEvent({this.value});
}

class InitialiseMembershipDashboardFormNoLoadEvent extends MembershipDashboardFormEvent {
  final MembershipDashboardModel value;

  @override
  List<Object> get props => [ value ];

  InitialiseMembershipDashboardFormNoLoadEvent({this.value});
}

class ChangedMembershipDashboardDocumentID extends MembershipDashboardFormEvent {
  final String value;

  ChangedMembershipDashboardDocumentID({this.value});

  @override
  List<Object> get props => [ value ];

  @override
  String toString() => 'ChangedMembershipDashboardDocumentID{ value: $value }';
}

class ChangedMembershipDashboardAppId extends MembershipDashboardFormEvent {
  final String value;

  ChangedMembershipDashboardAppId({this.value});

  @override
  List<Object> get props => [ value ];

  @override
  String toString() => 'ChangedMembershipDashboardAppId{ value: $value }';
}

class ChangedMembershipDashboardDescription extends MembershipDashboardFormEvent {
  final String value;

  ChangedMembershipDashboardDescription({this.value});

  @override
  List<Object> get props => [ value ];

  @override
  String toString() => 'ChangedMembershipDashboardDescription{ value: $value }';
}

