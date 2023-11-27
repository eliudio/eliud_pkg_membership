import 'package:eliud_core_main/editor/ext_editor_base_bloc/ext_editor_base_bloc.dart';
import 'package:eliud_core_main/model/storage_conditions_model.dart';
import 'package:eliud_core_main/apis/registryapi/component/component_spec.dart';
import 'package:eliud_core_helpers/etc/random.dart';
import 'package:eliud_pkg_etc_model/model/member_action_model.dart';
import 'package:eliud_pkg_membership_model/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_membership_model/model/membership_dashboard_entity.dart';
import 'package:eliud_pkg_membership_model/model/membership_dashboard_model.dart';

class MembershipDashboardBloc extends ExtEditorBaseBloc<
    MembershipDashboardModel, MemberActionModel, MembershipDashboardEntity> {
  MembershipDashboardBloc(String appId, EditorFeedback feedback)
      : super(appId, membershipDashboardRepository(appId: appId)!, feedback);

  @override
  MembershipDashboardModel addItem(
      MembershipDashboardModel model, MemberActionModel newItem) {
    List<MemberActionModel> newItems =
        model.memberActions == null ? [] : List.from(model.memberActions!);
    newItems.add(newItem);
    var newModel = model.copyWith(memberActions: newItems);
    return newModel;
  }

  @override
  MembershipDashboardModel deleteItem(
      MembershipDashboardModel model, MemberActionModel deleteItem) {
    var newItems = <MemberActionModel>[];
    for (var item in model.memberActions!) {
      if (item != deleteItem) {
        newItems.add(item);
      }
    }
    var newModel = model.copyWith(memberActions: newItems);
    return newModel;
  }

  @override
  MembershipDashboardModel newInstance(StorageConditionsModel conditions) {
    return MembershipDashboardModel(
      appId: appId,
      documentID: newRandomKey(),
      description: 'New membership dashboard',
      conditions: conditions,
    );
  }

  @override
  MembershipDashboardModel setDefaultValues(
      MembershipDashboardModel t, StorageConditionsModel conditions) {
    return t.copyWith(conditions: t.conditions ?? conditions);
  }

  @override
  MembershipDashboardModel updateItem(MembershipDashboardModel model,
      MemberActionModel oldItem, MemberActionModel newItem) {
    List<MemberActionModel> currentItems =
        model.memberActions == null ? [] : model.memberActions!;
    var index = currentItems.indexOf(oldItem);
    if (index != -1) {
      var newItems = currentItems.map((e) => e).toList();
      newItems[index] = newItem;
      var newModel = model.copyWith(memberActions: newItems);
      return newModel;
    } else {
      throw Exception("Could not find $oldItem");
    }
  }

  @override
  List<MemberActionModel> copyOf(List<MemberActionModel> ts) {
    return ts.map((e) => e).toList();
  }
}
