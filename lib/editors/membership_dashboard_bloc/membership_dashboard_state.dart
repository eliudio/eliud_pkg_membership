import 'package:eliud_core/model/public_medium_model.dart';
import 'package:eliud_pkg_etc/model/member_action_model.dart';
import 'package:eliud_pkg_membership/model/membership_dashboard_model.dart';
import 'package:equatable/equatable.dart';
import 'package:collection/collection.dart';

abstract class MembershipDashboardState extends Equatable {
  const MembershipDashboardState();

  @override
  List<Object?> get props => [];
}

class MembershipDashboardUninitialised extends MembershipDashboardState {
  @override
  List<Object?> get props => [];

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is MembershipDashboardUninitialised;
}

class MembershipDashboardInitialised extends MembershipDashboardState {
  final MembershipDashboardModel model;
  final MemberActionModel? currentEdit;

  const MembershipDashboardInitialised(
      {required this.model, this.currentEdit});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MembershipDashboardInitialised &&
          model == other.model &&
          currentEdit == other.currentEdit;

  @override
  List<Object?> get props => [model, currentEdit];
}

class MembershipDashboardLoaded extends MembershipDashboardInitialised {
  const MembershipDashboardLoaded(
      {required MembershipDashboardModel model, MemberActionModel? currentEdit})
      : super(model: model, currentEdit: currentEdit);
}

class MembershipDashboardError extends MembershipDashboardInitialised {
  final String error;

  const MembershipDashboardError({
    required this.error,
    required MembershipDashboardModel model,
    MemberActionModel? currentEdit
  }) : super(
          model: model,
      currentEdit: currentEdit,
        );
}
