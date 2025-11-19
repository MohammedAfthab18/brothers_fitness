import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../data/models/member/member.dart';
import '../../../../data/repositories/members_repository.dart';
import '../../../../shared/widgets/buttons/primary_button.dart';
import '../../../../shared/widgets/cards/base_card.dart';
import '../../providers/member_details_provider.dart';

/// Notes section widget matching React design.
class NotesSection extends ConsumerStatefulWidget {
  const NotesSection({super.key, required this.member});

  final Member member;

  @override
  ConsumerState<NotesSection> createState() => _NotesSectionState();
}

class _NotesSectionState extends ConsumerState<NotesSection> {
  final _controller = TextEditingController();
  bool _isSaving = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notes = widget.member.notes;
    return BaseCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Notes', style: AppTextStyles.titleMedium()),
          const SizedBox(height: AppDimensions.spacing4),
          if (notes.isEmpty)
            Text(
              'No notes yet. Add the first one below.',
              style: AppTextStyles.bodySmall(color: AppColors.textSecondary),
            )
          else
            ...notes.map(
              (note) => Container(
                width: double.infinity,
                margin: const EdgeInsets.only(
                  bottom: AppDimensions.spacing3,
                ),
                padding: const EdgeInsets.all(AppDimensions.spacing3),
                decoration: BoxDecoration(
                  color: AppColors.grey100,
                  borderRadius:
                      BorderRadius.circular(AppDimensions.radiusMedium),
                ),
                child: Text(
                  note.content,
                  style: AppTextStyles.bodySmall(),
                ),
              ),
            ),
          TextField(
            controller: _controller,
            maxLines: 4,
            style: AppTextStyles.bodyMedium(),
            decoration: InputDecoration(
              hintText: 'Add notes about this member...',
              hintStyle: AppTextStyles.bodyMedium(
                color: AppColors.textTertiary,
              ),
              filled: true,
              fillColor: AppColors.surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
                borderSide: BorderSide(color: AppColors.border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
                borderSide: BorderSide(color: AppColors.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
                borderSide: BorderSide(color: AppColors.primary, width: 2),
              ),
              contentPadding: const EdgeInsets.all(AppDimensions.spacing4),
            ),
          ),
          const SizedBox(height: AppDimensions.spacing3),
          SizedBox(
            width: double.infinity,
            child: PrimaryButton(
              label: 'Save Note',
              isFullWidth: true,
              isLoading: _isSaving,
              onPressed: _isSaving ? null : _saveNote,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _saveNote() async {
    final content = _controller.text.trim();
    if (content.isEmpty) return;

    setState(() {
      _isSaving = true;
    });

    final repository = ref.read(membersRepositoryProvider);
    final updatedNotes = [
      ...widget.member.notes,
      MemberNoteBlock(
        id: const Uuid().v4(),
        type: 'text',
        content: content,
        createdAt: DateTime.now(),
      ),
    ];
    final updatedMember = widget.member.copyWith(
      notes: updatedNotes,
      updatedAt: DateTime.now(),
    );

    await repository.updateMember(updatedMember);
    _controller.clear();
    setState(() {
      _isSaving = false;
    });
    ref.invalidate(memberDetailsProvider(widget.member.id));
  }
}
