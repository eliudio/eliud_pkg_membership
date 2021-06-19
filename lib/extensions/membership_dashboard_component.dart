import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:eliud_core/core/access/bloc/access_state.dart';
import 'package:eliud_core/core/widgets/alert_widget.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/model/background_model.dart';
import 'package:eliud_core/model/member_public_info_list.dart';
import 'package:eliud_core/model/member_public_info_list_bloc.dart';
import 'package:eliud_core/model/member_public_info_list_event.dart';
import 'package:eliud_core/model/member_public_info_model.dart';
import 'package:eliud_core/style/style_registry.dart';
import 'package:eliud_core/tools/component_constructor.dart';
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
  Widget createNew({String? id, Map<String, dynamic>? parameters}) {
    return MembershipDashboard(id: id);
  }
}

class MembershipDashboard extends AbstractMembershipDashboardComponent {
  MembershipDashboard({String? id}) : super(membershipDashboardID: id);

  @override
  Widget alertWidget({title = String, content = String}) {
    return AlertWidget(title: title, content: content);
  }

  static EliudQuery getSubscribedMembers(String appId) {
    return EliudQuery(theConditions: [
      EliudQueryCondition('subscriptionsAsString', arrayContains: appId),
    ]);
  }

  @override
  Widget yourWidget(
      BuildContext context, MembershipDashboardModel? dashboardModel) {
    var state = AccessBloc.getState(context);
    if (state is AppLoaded) {
      var appId = state.app.documentID;
      return BlocProvider<MemberPublicInfoListBloc>(
        create: (context) => MemberPublicInfoListBloc(
          eliudQuery: getSubscribedMembers(state.app.documentID!),
          memberPublicInfoRepository:
              memberPublicInfoRepository(appId: AccessBloc.appId(context))!,
        )..add(LoadMemberPublicInfoList()),
        child: StyleRegistry.registry().styleWithContext(context).frontEndStyle().simpleTopicContainer(context, children: [MemberPublicInfoListWidget(
            readOnly: true,
            widgetProvider: (value) => widgetProvider(appId, value),
            listBackground: BackgroundModel(documentID: "`transparent"))]),
      );
    } else {
      return StyleRegistry.registry().styleWithContext(context).frontEndStyle().progressIndicator(context);
    }
  }

  Widget widgetProvider(String? appId, MemberPublicInfoModel? value) {
    return MembershipDashboardItem(appId: appId, value: value);
  }

  @override
  MembershipDashboardRepository getMembershipDashboardRepository(
      BuildContext context) {
    return membershipDashboardRepository(appId: AccessBloc.appId(context))!;
  }
}
