import 'package:bloc/bloc.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/model/pos_size_model.dart';
import 'package:eliud_core/model/public_medium_model.dart';
import 'package:eliud_core/model/storage_conditions_model.dart';
import 'package:eliud_core/tools/component/component_spec.dart';
import 'package:eliud_core/tools/random.dart';
import 'package:eliud_pkg_etc/model/member_action_model.dart';
import 'package:eliud_pkg_membership/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_membership/model/membership_dashboard_model.dart';

import 'membership_dashboard_state.dart';
import 'membership_dashoard_event.dart';

class MembershipDashboardBloc
    extends Bloc<MembershipDashboardEvent, MembershipDashboardState> {
  final String appId;
//  final bool create; // don't think I need this!!!
  final EditorFeedback feedback;

  MembershipDashboardBloc(this.appId, /*this.create, */ this.feedback)
      : super(MembershipDashboardUninitialised());

  @override
  Stream<MembershipDashboardState> mapEventToState(
      MembershipDashboardEvent event) async* {
    if (event is MembershipDashboardInitialise) {
      List<PublicMediumModel>? media = [];
      // retrieve the model, as it was retrieved without links
      var modelWithLinks = await membershipDashboardRepository(appId: appId)!
          .get(event.model.documentID);
      if (modelWithLinks == null) {
        modelWithLinks = MembershipDashboardModel(
          documentID: newRandomKey(),
          conditions: StorageConditionsModel(
              privilegeLevelRequired:
                  PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple),
        );
      } else {
        modelWithLinks = modelWithLinks.copyWith(
          conditions: modelWithLinks.conditions ??
              StorageConditionsModel(
                  privilegeLevelRequired:
                      PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple),
        );
      }
      yield MembershipDashboardInitialised(
        model: modelWithLinks,
      );
    } else if (state is MembershipDashboardInitialised) {
      var theState = state as MembershipDashboardInitialised;
      if (event is SelectForEditEvent) {
        yield MembershipDashboardInitialised(
            model: theState.model, currentEdit: theState.currentEdit);
      } else if (event is AddItemEvent) {
        List<MemberActionModel> newItems = theState.model.memberActions == null
            ? []
            : theState.model.memberActions!;
        newItems.add(event.itemModel);
        yield MembershipDashboardInitialised(
            model: theState.model.copyWith(memberActions: newItems),
            currentEdit: theState.currentEdit);
      } else if (event is UpdateItemEvent) {
        List<MemberActionModel> currentItems = theState.model.memberActions == null
            ? []
            : theState.model.memberActions!;
        var index = currentItems.indexOf(event.oldItem);
        if (index != -1) {
          var newItems = currentItems.map((e) => e).toList();
          newItems[index] = event.newItem;
          yield MembershipDashboardInitialised(
              model: theState.model.copyWith(memberActions: newItems),
              currentEdit: event.newItem);
        }
      } else if (event is DeleteItemEvent) {
        var deleteItem = event.itemModel;
        var newItems = <MemberActionModel>[];
        for (var item in theState.model.memberActions!) {
          if (item != deleteItem) {
            newItems.add(item);
          }
        }
        yield MembershipDashboardInitialised(
            model: theState.model.copyWith(memberActions: newItems));
      }
    }
  }

  Future<void> save(MembershipDashboardApplyChanges event) async {
    if (state is MembershipDashboardInitialised) {
      var theState = state as MembershipDashboardInitialised;
      var newModel = theState.model;
      if (await membershipDashboardRepository(appId: appId)!
              .get(newModel.documentID!) ==
          null) {
        await membershipDashboardRepository(appId: appId)!.add(newModel);
      } else {
        await membershipDashboardRepository(appId: appId)!.update(newModel);
      }
      feedback(true);
    }
  }
}
