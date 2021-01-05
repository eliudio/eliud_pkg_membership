/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 member_public_info_list_event.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:equatable/equatable.dart';
import 'package:eliud_pkg_membership/model/member_public_info_model.dart';

abstract class MemberPublicInfoListEvent extends Equatable {
  const MemberPublicInfoListEvent();
  @override
  List<Object> get props => [];
}

class LoadMemberPublicInfoList extends MemberPublicInfoListEvent {
  final String orderBy;
  final bool descending;

  LoadMemberPublicInfoList({this.orderBy, this.descending});

  @override
  List<Object> get props => [orderBy, descending];

}

class LoadMemberPublicInfoListWithDetails extends MemberPublicInfoListEvent {}

class AddMemberPublicInfoList extends MemberPublicInfoListEvent {
  final MemberPublicInfoModel value;

  const AddMemberPublicInfoList({ this.value });

  @override
  List<Object> get props => [ value ];

  @override
  String toString() => 'AddMemberPublicInfoList{ value: $value }';
}

class UpdateMemberPublicInfoList extends MemberPublicInfoListEvent {
  final MemberPublicInfoModel value;

  const UpdateMemberPublicInfoList({ this.value });

  @override
  List<Object> get props => [ value ];

  @override
  String toString() => 'UpdateMemberPublicInfoList{ value: $value }';
}

class DeleteMemberPublicInfoList extends MemberPublicInfoListEvent {
  final MemberPublicInfoModel value;

  const DeleteMemberPublicInfoList({ this.value });

  @override
  List<Object> get props => [ value ];

  @override
  String toString() => 'DeleteMemberPublicInfoList{ value: $value }';
}

class MemberPublicInfoListUpdated extends MemberPublicInfoListEvent {
  final List<MemberPublicInfoModel> value;

  const MemberPublicInfoListUpdated({ this.value });

  @override
  List<Object> get props => [ value ];

  @override
  String toString() => 'MemberPublicInfoListUpdated{ value: $value }';
}

