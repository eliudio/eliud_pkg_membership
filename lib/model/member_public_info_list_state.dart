/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 member_public_info_list_state.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:equatable/equatable.dart';
import 'package:eliud_pkg_membership/model/member_public_info_model.dart';

abstract class MemberPublicInfoListState extends Equatable {
  const MemberPublicInfoListState();

  @override
  List<Object> get props => [];
}

class MemberPublicInfoListLoading extends MemberPublicInfoListState {}

class MemberPublicInfoListLoaded extends MemberPublicInfoListState {
  final List<MemberPublicInfoModel> values;

  const MemberPublicInfoListLoaded({this.values = const []});

  @override
  List<Object> get props => [ values ];

  @override
  String toString() => 'MemberPublicInfoListLoaded { values: $values }';
}

class MemberPublicInfoNotLoaded extends MemberPublicInfoListState {}

