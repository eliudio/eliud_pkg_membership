import 'package:eliud_core/model/app_bar_model.dart';
import 'package:eliud_core/model/dialog_model.dart';
import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/menu_def_model.dart';
import 'package:eliud_core/model/menu_item_model.dart';
import 'package:eliud_core/model/page_model.dart';
import 'package:eliud_core/model/platform_medium_model.dart';
import 'package:eliud_core/model/public_medium_model.dart';
import 'package:eliud_pkg_etc/model/member_action_model.dart';
import 'package:eliud_pkg_membership/model/membership_dashboard_model.dart';
import 'package:equatable/equatable.dart';
import 'package:collection/collection.dart';

abstract class MembershipDashboardEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class MembershipDashboardInitialise extends MembershipDashboardEvent {
  final MembershipDashboardModel model;

  MembershipDashboardInitialise(this.model);

  @override
  List<Object?> get props => [model];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MembershipDashboardInitialise && model == other.model;
}

class SelectForEditEvent extends MembershipDashboardEvent {
  final MemberActionModel item;

  SelectForEditEvent({required this.item});

  @override
  List<Object?> get props => [item];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is SelectForEditEvent && item == other.item;
}

class MembershipDashboardApplyChanges extends MembershipDashboardEvent {
  final MembershipDashboardModel model;

  MembershipDashboardApplyChanges({required this.model});

  @override
  List<Object?> get props => [
        model,
      ];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MembershipDashboardApplyChanges && model == other.model;
}


class UpdateItemEvent extends MembershipDashboardEvent {
  final MemberActionModel oldItem;
  final MemberActionModel newItem;

  UpdateItemEvent({required this.oldItem, required this.newItem});

  @override
  List<Object?> get props => [oldItem, newItem];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is UpdateItemEvent &&
              oldItem == other.oldItem &&
              newItem == other.newItem;
}

class AddItemEvent extends MembershipDashboardEvent {
  final MemberActionModel itemModel;

  AddItemEvent({required this.itemModel});

  @override
  List<Object?> get props => [itemModel];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AddItemEvent &&
              itemModel == other.itemModel;
}

class DeleteItemEvent extends MembershipDashboardEvent {
  final MemberActionModel itemModel;

  DeleteItemEvent({required this.itemModel});

  @override
  List<Object?> get props => [itemModel];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is DeleteItemEvent &&
              itemModel == other.itemModel;
}