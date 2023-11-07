import 'package:flutter/foundation.dart';

import 'membership_package.dart';

MembershipPackage getMembershipPackage() => MembershipMobilePackage();

class MembershipMobilePackage extends MembershipPackage {
  @override
  List<Object?> get props => [stateMemberHasNoMembershipYet];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MembershipMobilePackage &&
          runtimeType == other.runtimeType &&
          mapEquals(stateMemberHasNoMembershipYet,
              other.stateMemberHasNoMembershipYet);

  @override
  int get hashCode => stateMemberHasNoMembershipYet.hashCode;
}
