import 'package:flutter/foundation.dart';

import 'membership_package.dart';

MembershipPackage getMembershipPackage() => MembershipMobilePackage();

class MembershipMobilePackage extends MembershipPackage {

  @override
  List<Object?> get props => [
    stateMEMBER_HAS_NO_MEMBERSHIP_YET
  ];

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
          other is MembershipMobilePackage &&
          runtimeType == other.runtimeType &&
          mapEquals(stateMEMBER_HAS_NO_MEMBERSHIP_YET, other.stateMEMBER_HAS_NO_MEMBERSHIP_YET);
}
