import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../filter/filter_bottom_sheet.dart';
import 'widgets/_animated_tab_bar.dart';
import 'widgets/_app_bar.dart';
import 'widgets/_provider_list_body.dart';
import 'widgets/_search_section.dart';
import 'package:medifinder_case_study/core/extensions/context_extensions.dart';
import 'package:medifinder_case_study/core/models/provider_model.dart';
import 'package:medifinder_case_study/blocs/provider_list/provider_list_bloc.dart';
import 'package:medifinder_case_study/blocs/provider_filter/provider_filter_bloc.dart';

/// The main provider list screen with tabs for Doctors, Clinics, and Hospitals.
class ProviderListScreen extends StatefulWidget {
  const ProviderListScreen({super.key});

  @override
  State<ProviderListScreen> createState() => _ProviderListScreenState();
}

class _ProviderListScreenState extends State<ProviderListScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _openFilterSheet() {
    final currentFilter = context.read<ProviderListBloc>().state.filter;
    context
        .read<ProviderFilterBloc>()
        .add(FilterInitialized(currentFilter));

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      isDismissible: false,
      showDragHandle: false,
      enableDrag: true,
      builder: (_) => BlocProvider.value(
        value: context.read<ProviderFilterBloc>(),
        child: BlocProvider.value(
          value: context.read<ProviderListBloc>(),
          child: const FilterBottomSheet(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: const ProviderListAppBar(),
        body: Column(
          children: [
            SearchSection(onFilterTap: _openFilterSheet),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 10),
              child: AnimatedSegmentedTabBar(
                controller: _tabController,
                tabs: [
                  context.l10n.providerTypeDoctor,
                  context.l10n.providerTypeClinic,
                  context.l10n.providerTypeHospital,
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                physics: const BouncingScrollPhysics(
                  parent: PageScrollPhysics(),
                ),
                children: [
                  ProviderListBody(
                    key: const PageStorageKey('list-doctor'),
                    activeTab: ProviderType.doctor,
                    tabIndex: 0,
                    tabController: _tabController,
                  ),
                  ProviderListBody(
                    key: const PageStorageKey('list-clinic'),
                    activeTab: ProviderType.clinic,
                    tabIndex: 1,
                    tabController: _tabController,
                  ),
                  ProviderListBody(
                    key: const PageStorageKey('list-hospital'),
                    activeTab: ProviderType.hospital,
                    tabIndex: 2,
                    tabController: _tabController,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
