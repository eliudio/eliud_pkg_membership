import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:eliud_core/core/access/bloc/access_state.dart';
import 'package:eliud_core/core/widgets/alert_widget.dart';
import 'package:eliud_core/core/widgets/progress_indicator.dart';
import 'package:eliud_core/model/background_model.dart';
import 'package:eliud_core/tools/component_constructor.dart';
import 'package:eliud_core/tools/query/query_tools.dart';
import 'package:eliud_pkg_membership/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_membership/model/membership_dashboard_component.dart';
import 'package:eliud_pkg_membership/model/membership_dashboard_model.dart';
import 'package:eliud_pkg_membership/model/membership_dashboard_repository.dart';
import 'package:eliud_pkg_notifications/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_notifications/model/notification_list.dart';
import 'package:eliud_pkg_notifications/model/notification_list_bloc.dart';
import 'package:eliud_pkg_notifications/model/notification_list_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MembershipDashboardComponentConstructorDefault implements ComponentConstructor {
  Widget createNew({String id, Map<String, Object> parameters}) {
    return MembershipDashboard(id: id);
  }
}

class MembershipDashboard extends AbstractMembershipDashboardComponent {
  MembershipDashboard({String id}) : super(membershipDashboardID: id);

  @override
  Widget alertWidget({title = String, content = String}) {
    return AlertWidget(title: title, content: content);
  }

  static EliudQuery getOpenAssignmentsQuery(String appId, String assigneeId) {
    return EliudQuery(
        theConditions: [
          EliudQueryCondition('assigneeId', isEqualTo: assigneeId),
          EliudQueryCondition('appId', isEqualTo: appId),
          EliudQueryCondition('status', isEqualTo: AssignmentStatus.Open.index)
        ]
    );
  }

  @override
  Widget yourWidget(BuildContext context, MembershipDashboardModel DashboardModel) {
    var state = AccessBloc.getState(context);
    if (state is AppLoaded) {
      return BlocProvider<NotificationListBloc>(
        create: (context) => NotificationListBloc(
          AccessBloc.getBloc(context),
          eliudQuery: MembershipPackage.getOpenNotificationsQuery(
              state.app.documentID, state.getMember().documentID),
          notificationRepository:
          notificationRepository(appId: AccessBloc.appId(context)),
        )..add(LoadNotificationList()),
        child: NotificationListWidget(
            readOnly: true,
            listItemWidget: "MembershipDashboardItem",
            listBackground: BackgroundModel(documentID: "`transparent")),
      );
    } else {
      return DelayedCircularProgressIndicator();
    }
  }


  @override
  MembershipDashboardRepository getMembershipDashboardRepository(BuildContext context) {
    return membershipDashboardRepository(appId: AccessBloc.appId(context));
  }
}
