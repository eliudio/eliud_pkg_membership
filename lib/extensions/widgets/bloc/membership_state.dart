import 'package:eliud_core_main/model/member_public_info_model.dart';
import 'package:eliud_core_model/model/access_model.dart';
import 'package:equatable/equatable.dart';

abstract class MembershipState extends Equatable {
  const MembershipState();
}

class UnitializedMembership extends MembershipState {
  UnitializedMembership();

  @override
  List<Object> get props => [];

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is MembershipLoaded;

  @override
  int get hashCode => 0;
}

class MembershipLoaded extends MembershipState {
  final AccessModel? accessModel;
  final String appId;
  final MemberPublicInfoModel? member;

  MembershipLoaded(this.accessModel, this.appId, this.member);

  @override
  List<Object> get props => [accessModel!, appId, member!];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MembershipLoaded &&
          runtimeType == other.runtimeType &&
          accessModel == other.accessModel &&
          appId == other.appId &&
          member == other.member;

  @override
  int get hashCode => accessModel.hashCode ^ appId.hashCode ^ member.hashCode;
}
