import 'package:auto_route/auto_route.dart';
import 'package:connectinno_case/ui/pages/main_page/pages/home_page/viewmodel/home_cubit.dart';
import 'package:connectinno_case/ui/shared/base_page.dart';
import 'package:connectinno_case/ui/shared/custom_appbar.dart';
import 'package:connectinno_case/ui/shared/styles/colors.dart';
import 'package:connectinno_case/ui/shared/styles/text_styles.dart';
import 'package:flutter/material.dart';
import '../../../core/models/note_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'viewmodel/note_details_cubit.dart';

@RoutePage()
class NoteDetailsPage extends StatefulWidget {
  final NoteModel? note;
  const NoteDetailsPage({Key? key, this.note}) : super(key: key);

  @override
  State<NoteDetailsPage> createState() => _NoteDetailsPageState();
}

class _NoteDetailsPageState extends State<NoteDetailsPage> {
  late final TextEditingController _titleController;
  late final TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note?.title ?? '');
    _contentController = TextEditingController(text: widget.note?.content ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoteDetailsCubit, NoteDetailsState>(
      listener: (context, state) {
        if (state is NoteDetailsSuccess) {
          context.maybePop();
        } else if (state is NoteDetailsError) {
          debugPrint('Hata: ${state.message}');
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        return BasePage(
          appBar: CustomAppBar(
            titleText: widget.note == null ? 'Yeni Not' : 'Not Detayları',
            centerTitle: true,
            actions:
                widget.note != null
                    ? [
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        tooltip: 'Notu Sil',
                        onPressed: () async {
                          final confirm = await showDialog<bool>(
                            context: context,
                            builder:
                                (ctx) => AlertDialog(
                                  title: const Text('Notu Sil'),
                                  content: const Text('Bu notu silmek istediğinize emin misiniz?'),
                                  actions: [
                                    TextButton(child: const Text('Vazgeç'), onPressed: () => Navigator.of(ctx).pop(false)),
                                    TextButton(child: const Text('Evet'), onPressed: () => Navigator.of(ctx).pop(true)),
                                  ],
                                ),
                          );
                          if (confirm == true && widget.note?.id != null) {
                            try {
                              await context.read<HomeCubit>().deleteNote(widget.note!.id!);
                              context.maybePop();
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                            }
                          }
                        },
                      ),
                    ]
                    : null,
          ),
          child: SingleChildScrollView(
            child: Card(
              elevation: 4,
              color: AppColors.inputFillColor,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      onTapOutside: (event) {
                        FocusScope.of(context).unfocus();
                      },
                      controller: _titleController,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      decoration: InputDecoration(
                        labelText: 'Başlık',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.black)),
                        filled: true,
                        fillColor: Colors.grey[100],
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      onTapOutside: (event) {
                        FocusScope.of(context).unfocus();
                      },
                      controller: _contentController,
                      decoration: InputDecoration(
                        labelText: 'İçerik',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        filled: true,
                        fillColor: Colors.grey[100],
                      ),
                      minLines: 8,
                      maxLines: 20,
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryBlackColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          elevation: 2,
                        ),
                        onPressed:
                            state is NoteDetailsLoading
                                ? null
                                : () async {
                                  if (widget.note == null) {
                                    await context.read<NoteDetailsCubit>().saveOrUpdateNote(
                                      NoteModel(
                                        title: _titleController.text.trim(),
                                        content: _contentController.text.trim(),
                                        createdAt: DateTime.now(),
                                        updatedAt: DateTime.now(),
                                      ),
                                      isUpdate: false,
                                    );
                                  } else {
                                    final updatedNote = widget.note!.copyWith(
                                      title: _titleController.text.trim(),
                                      content: _contentController.text.trim(),
                                      updatedAt: DateTime.now(),
                                    );
                                    await context.read<NoteDetailsCubit>().saveOrUpdateNote(updatedNote, isUpdate: true);
                                  }
                                },
                        child:
                            state is NoteDetailsLoading
                                ? const CircularProgressIndicator(color: Colors.white)
                                : Text(widget.note == null ? 'Oluştur' : 'Güncelle', style: AppTextStyles.p3),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
