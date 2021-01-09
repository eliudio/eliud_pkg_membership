/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 member_public_info_component_state.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:equatable/equatable.dart';
import 'package:eliud_pkg_membership/model/member_public_info_model.dart';

abstract class MemberPublicInfoComponentState extends Equatable {
  const MemberPublicInfoComponentState();

  @override
  List<Object> get props => [];
}

class MemberPublicInfoComponentUninitialized extends MemberPublicInfoComponentState {}

class MemberPublicInfoComponentError extends MemberPublicInfoComponentState {
  final String message;
  MemberPublicInfoComponentError({ this.message });
}

class MemberPublicInfoComponentPermissionDenied extends MemberPublicInfoComponentState {
  MemberPublicInfoComponentPermissionDenied();
}

class MemberPublicInfoComponentLoaded extends MemberPublicInfoComponentState {
  final MemberPublicInfoModel value;

  const MemberPublicInfoComponentLoaded({ this.value });

  MemberPublicInfoComponentLoaded copyWith({ MemberPublicInfoModel copyThis }) {
    return MemberPublicInfoComponentLoaded(value: copyThis ?? this.value);
  }

  @override
  List<Object> get props => [value];

  @override
  String toString() => 'MemberPublicInfoComponentLoaded { value: $value }';
}

