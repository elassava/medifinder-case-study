import 'package:flutter/material.dart';
import 'package:medifinder_case_study/core/extensions/context_extensions.dart';
import 'package:medifinder_case_study/core/models/provider_model.dart';
import 'package:medifinder_case_study/core/theme/app_colors.dart';

/// Website-style card header: cover image, overlapping avatar, action buttons.
class ProviderCardHero extends StatelessWidget {
  const ProviderCardHero({
    super.key,
    required this.provider,
    this.compact = false,
    this.showActions = true,
  });

  static const double defaultAvatarSize = 64;
  static const double compactAvatarSize = 38;
  static const double defaultHeaderHeight = 112;
  static const double compactHeaderHeight = 48;

  final ProviderModel provider;
  final bool compact;
  final bool showActions;

  double get _headerHeight =>
      compact ? compactHeaderHeight : defaultHeaderHeight;

  double get _avatarSize => compact ? compactAvatarSize : defaultAvatarSize;

  double get _contentInset => compact ? 7 : 16;

  static String coverUrlFor(ProviderModel provider) =>
      'https://picsum.photos/seed/${provider.id}/600/240';

  @override
  Widget build(BuildContext context) {
    final radius = context.styles.cardRadius;
    final topRadius = BorderRadius.only(
      topLeft: radius.topLeft,
      topRight: radius.topRight,
    );
    final avatarOverlap = _avatarSize * 0.35;

    return SizedBox(
      height: _headerHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: topRadius,
              child: _CoverImage(provider: provider),
            ),
          ),
          Positioned(
            left: _contentInset,
            bottom: -avatarOverlap,
            child: _ProviderAvatar(
              imageUrl: provider.imageUrl,
              size: _avatarSize,
            ),
          ),
          if (showActions && !compact)
            Positioned(
              right: _contentInset,
              bottom: -avatarOverlap + (_avatarSize - 36) / 2,
              child: const _CardActionButtons(),
            ),
        ],
      ),
    );
  }

  double get avatarOverlap => _avatarSize * 0.35;
}

class _CoverImage extends StatelessWidget {
  const _CoverImage({required this.provider});

  final ProviderModel provider;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      ProviderCardHero.coverUrlFor(provider),
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (_, _, _) => _CoverFallback(type: provider.type),
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return _CoverFallback(type: provider.type);
      },
    );
  }
}

class _CoverFallback extends StatelessWidget {
  const _CoverFallback({required this.type});

  final ProviderType type;

  @override
  Widget build(BuildContext context) {
    final color = switch (type) {
      ProviderType.doctor => AppColors.tealAccent.withValues(alpha: 0.15),
      ProviderType.clinic => AppColors.primaryBlue.withValues(alpha: 0.12),
      ProviderType.hospital => AppColors.hospitalColor.withValues(alpha: 0.12),
    };

    return Container(
      color: color,
      alignment: Alignment.center,
      child: Icon(
        switch (type) {
          ProviderType.doctor => Icons.medical_services_outlined,
          ProviderType.clinic => Icons.local_hospital_outlined,
          ProviderType.hospital => Icons.domain_outlined,
        },
        size: 28,
        color: AppColors.textTertiary(context.colorScheme),
      ),
    );
  }
}

class _ProviderAvatar extends StatelessWidget {
  const _ProviderAvatar({this.imageUrl, required this.size});

  final String? imageUrl;
  final double size;

  @override
  Widget build(BuildContext context) {
    final surface = context.colorScheme.surface;
    final shadow = context.colorScheme.shadow.withValues(alpha: 0.08);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: surface,
        border: Border.all(color: surface, width: 2.5),
        boxShadow: [
          BoxShadow(
            color: shadow,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        image: imageUrl != null
            ? DecorationImage(
                image: NetworkImage(imageUrl!),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: imageUrl == null
          ? Icon(
              Icons.person_outline_rounded,
              size: size * 0.45,
              color: AppColors.textTertiary(context.colorScheme),
            )
          : null,
    );
  }
}

class _CardActionButtons extends StatelessWidget {
  const _CardActionButtons();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _CircleActionButton(icon: Icons.bookmark_border_rounded),
        const SizedBox(width: 8),
        _CircleActionButton(icon: Icons.mail_outline_rounded),
      ],
    );
  }
}

class _CircleActionButton extends StatelessWidget {
  const _CircleActionButton({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.colorScheme.surface,
      elevation: 2,
      shadowColor: context.colorScheme.shadow.withValues(alpha: 0.2),
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {},
        child: SizedBox(
          width: 36,
          height: 36,
          child: Icon(
            icon,
            size: 18,
            color: context.colorScheme.onSurface.withValues(alpha: 0.55),
          ),
        ),
      ),
    );
  }
}
