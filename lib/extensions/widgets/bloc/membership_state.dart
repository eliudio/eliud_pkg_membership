import 'package:eliud_core/model/access_model.dart';
import 'package:eliud_core/model/member_public_info_model.dart';
import 'package:equatable/equatable.dart';

abstract class MembershipState extends Equatable {
  const MembershipState();
}

class UnitializedMembership extends MembershipState {
  UnitializedMembership();

  @override
  List<Object> get props => [];

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
          other is MembershipLoaded;
}

class MembershipLoaded extends MembershipState {
  final AccessModel? accessModel;
  final String? appId;
  final MemberPublicInfoModel? member;

  MembershipLoaded(this.accessModel, this.appId, this.member);

  @override
  List<Object> get props => [ accessModel!, appId!, member!];

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
          other is MembershipLoaded &&
              runtimeType == other.runtimeType &&
              accessModel == other.accessModel &&
              appId == other.appId &&
              member == other.member;
}
