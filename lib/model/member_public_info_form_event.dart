/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 member_public_info_form_event.dart
                       
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
abstract class MemberPublicInfoFormEvent extends Equatable {
  const MemberPublicInfoFormEvent();

  @override
  List<Object> get props => [];
}

class InitialiseNewMemberPublicInfoFormEvent extends MemberPublicInfoFormEvent {
}


class InitialiseMemberPublicInfoFormEvent extends MemberPublicInfoFormEvent {
  final MemberPublicInfoModel value;

  @override
  List<Object> get props => [ value ];

  InitialiseMemberPublicInfoFormEvent({this.value});
}

class InitialiseMemberPublicInfoFormNoLoadEvent extends MemberPublicInfoFormEvent {
  final MemberPublicInfoModel value;

  @override
  List<Object> get props => [ value ];

  InitialiseMemberPublicInfoFormNoLoadEvent({this.value});
}

class ChangedMemberPublicInfoDocumentID extends MemberPublicInfoFormEvent {
  final String value;

  ChangedMemberPublicInfoDocumentID({this.value});

  @override
  List<Object> get props => [ value ];

  @override
  String toString() => 'ChangedMemberPublicInfoDocumentID{ value: $value }';
}

class ChangedMemberPublicInfoName extends MemberPublicInfoFormEvent {
  final String value;

  ChangedMemberPublicInfoName({this.value});

  @override
  List<Object> get props => [ value ];

  @override
  String toString() => 'ChangedMemberPublicInfoName{ value: $value }';
}

class ChangedMemberPublicInfoPhotoURL extends MemberPublicInfoFormEvent {
  final String value;

  ChangedMemberPublicInfoPhotoURL({this.value});

  @override
  List<Object> get props => [ value ];

  @override
  String toString() => 'ChangedMemberPublicInfoPhotoURL{ value: $value }';
}

class ChangedMemberPublicInfoSubscriptions extends MemberPublicInfoFormEvent {
  final List<MemberSubscriptionModel> value;

  ChangedMemberPublicInfoSubscriptions({this.value});

  @override
  List<Object> get props => [ value ];

  @override
  String toString() => 'ChangedMemberPublicInfoSubscriptions{ value: $value }';
}

