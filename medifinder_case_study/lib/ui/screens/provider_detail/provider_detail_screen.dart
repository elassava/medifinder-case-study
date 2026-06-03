import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/_detail_header.dart';
import 'widgets/_detail_contact.dart';
import 'widgets/_detail_about.dart';
import 'widgets/_detail_info_list.dart';
import 'package:medifinder_case_study/core/extensions/context_extensions.dart';
import 'package:medifinder_case_study/core/models/provider_model.dart';
import 'package:medifinder_case_study/blocs/provider_detail/provider_detail_bloc.dart';
import 'package:medifinder_case_study/ui/widgets/state_widgets.dart';

/// Provider detail — white cards on clinical canvas.
class ProviderDetailScreen extends StatelessWidget {
  const ProviderDetailScreen({super.key});

  String _titleForType(ProviderType type, BuildContext context) {
    switch (type) {
      case ProviderType.doctor:
        return context.l10n.doctorDetailTitle;
      case ProviderType.clinic:
        return context.l10n.clinicDetailTitle;
      case ProviderType.hospital:
        return context.l10n.hospitalDetailTitle;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      body: BlocBuilder<ProviderDetailBloc, ProviderDetailState>(
        builder: (context, state) {
          if (state.status == ProviderDetailStatus.loading) {
            return const Center(child: CupertinoActivityIndicator());
          }

          if (state.status == ProviderDetailStatus.failure) {
            return ErrorView(
              message: state.errorMessage ?? context.l10n.errorMessage,
              onRetry: state.providerId == null
                  ? null
                  : () => context.read<ProviderDetailBloc>().add(
                        ProviderDetailFetched(state.providerId!),
                      ),
            );
          }

          final provider = state.provider;
          if (provider == null) {
            return const EmptyView();
          }

          return CustomScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: [
              SliverAppBar(
                pinned: true,
                backgroundColor: context.colorScheme.surface,
                surfaceTintColor: Colors.transparent,
                elevation: 0,
                scrolledUnderElevation: 0,
                centerTitle: true,
                title: Text(
                  _titleForType(provider.type, context),
                  style: context.textTheme.titleSmall,
                ),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DetailHeader(provider: provider),
                    const SizedBox(height: 12),
                    DetailContact(provider: provider),
                    const SizedBox(height: 12),
                    DetailAbout(provider: provider),
                    const SizedBox(height: 12),
                    DetailInfoList(provider: provider),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
