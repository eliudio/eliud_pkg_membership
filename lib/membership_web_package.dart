import 'membership_package.dart';

class MembershipWebPackage extends MembershipPackage {

  @override
  List<Object?> get props => [
    stateAccesModel
  ];

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
          other is MembershipWebPackage &&
              runtimeType == other.runtimeType &&
              stateAccesModel == other.stateAccesModel;
}
