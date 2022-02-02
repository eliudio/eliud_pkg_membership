import 'package:eliud_core/core/blocs/access/access_bloc.dart';
import 'package:eliud_core/core/blocs/access/state/access_determined.dart';
import 'package:eliud_core/core/blocs/access/state/access_state.dart';
import 'package:eliud_core/core/widgets/alert_widget.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/background_model.dart';
import 'package:eliud_core/model/member_public_info_list.dart';
import 'package:eliud_core/model/member_public_info_list_bloc.dart';
import 'package:eliud_core/model/member_public_info_list_event.dart';
import 'package:eliud_core/model/member_public_info_model.dart';
import 'package:eliud_core/style/frontend/has_container.dart';
import 'package:eliud_core/style/frontend/has_progress_indicator.dart';
import 'package:eliud_core/tools/component/component_constructor.dart';
import 'package:eliud_core/tools/query/query_tools.dart';
import 'package:eliud_pkg_membership/extensions/widgets/membership_dashboard_item.dart';
import 'package:eliud_pkg_membership/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_membership/model/membership_dashboard_component.dart';
import 'package:eliud_pkg_membership/model/membership_dashboard_model.dart';
import 'package:eliud_pkg_membership/model/membership_dashboard_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MembershipDashboardComponentConstructorDefault
    implements ComponentConstructor {
  @override
  Widget createNew({Key? key, required AppModel app, required String id, Map<String, dynamic>? parameters}) {
    return MembershipDashboard(key: key, app: app, id: id);
  }

  @override
  Future<dynamic> getModel({required AppModel app, required String id}) async => await membershipDashboardRepository(appId: app.documentID!)!.get(id);
}

class MembershipDashboard extends AbstractMembershipDashboardComponent {
  MembershipDashboard({Key? key, required AppModel app, required String id}) : super(key: key, app: app, membershipDashboardId: id);

  @override
  Widget alertWidget({title = String, content = String}) {
    return AlertWidget(app: app, title: title, content: content);
  }

  static EliudQuery getSubscribedMembers(String appId) {
    return EliudQuery(theConditions: [
      EliudQueryCondition('subscriptionsAsStrArr', arrayContains: appId),
    ]);
  }

  @override
  Widget yourWidget(
      BuildContext context, MembershipDashboardModel? dashboardModel) {
    return BlocBuilder<AccessBloc, AccessState>(
        builder: (context, accessState) {
          if (accessState is AccessDetermined) {
            var appId = app.documentID!;
            return topicContainer(app, context, children: [
              BlocProvider<MemberPublicInfoListBloc>(
                create: (context) => MemberPublicInfoListBloc(
                  eliudQuery: getSubscribedMembers(appId),
                  memberPublicInfoRepository:
                  memberPublicInfoRepository(appId: appId)!,
                )..add(LoadMemberPublicInfoList()),
                child: simpleTopicContainer(app, context, children: [MemberPublicInfoListWidget(app: app,
                    readOnly: true,
                    widgetProvider: (value) => widgetProvider(app, value, dashboardModel!),
                    listBackground: BackgroundModel())]),
              )]);
          } else {
            return progressIndicator(app, context);
          }
        });
  }

  Widget widgetProvider(AppModel app, MemberPublicInfoModel? value, MembershipDashboardModel dashboardModel) {
    return MembershipDashboardItem(app: app, value: value, dashboardModel: dashboardModel);
  }

  @override
  MembershipDashboardRepository getMembershipDashboardRepository(
      BuildContext context) {
    return membershipDashboardRepository(appId: app.documentID!)!;
  }
}
