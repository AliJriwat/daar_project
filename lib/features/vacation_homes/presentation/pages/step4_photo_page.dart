// lib/features/vacation_homes/presentation/pages/add_vacation_home/step4_photos_page.dart

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:image_picker/image_picker.dart';
import 'package:daar_project/app/theme/colors.dart';

class Step4PhotosPage extends StatefulWidget {
  final Function(List<String> photoUrls) onNext;
  final VoidCallback onBack;

  const Step4PhotosPage({
    super.key,
    required this.onNext,
    required this.onBack,
  });

  @override
  State<Step4PhotosPage> createState() => _Step4PhotosPageState();
}

class _Step4PhotosPageState extends State<Step4PhotosPage> {
  final ImagePicker _imagePicker = ImagePicker();
  List<String> _photoUrls = [];

  Future<void> _pickImages() async {
    try {
      final List<XFile> images = await _imagePicker.pickMultiImage(
        maxWidth: 1200,
        maxHeight: 1200,
        imageQuality: 80,
      );

      if (images.isNotEmpty) {
        // Qui dovrai implementare l'upload a Supabase Storage
        // Per ora simuliamo gli URLs
        setState(() {
          _photoUrls.addAll(List.generate(images.length, (index) => 'temp_url_${DateTime.now().millisecondsSinceEpoch}_$index'));
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking images: $e')),
      );
    }
  }

  void _removeImage(int index) {
    setState(() {
      _photoUrls.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'photos'.tr(),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'add_photos_description'.tr(),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 24),

          // Bottone per aggiungere foto
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: _pickImages,
              style: OutlinedButton.styleFrom(
                foregroundColor: Theme.of(context).textTheme.bodyLarge?.color,
                side: BorderSide(
                  color: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.grey,
                ),
                padding: const EdgeInsets.symmetric(vertical: 20),
              ),
              child: Column(
                children: [
                  Icon(Icons.add_photo_alternate, size: 40),
                  const SizedBox(height: 8),
                  Text('add_photos'.tr()),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Grid delle foto
          if (_photoUrls.isNotEmpty) ...[
            Text(
              'selected_photos'.tr(),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: _photoUrls.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey[300],
                        ),
                        child: Center(
                          child: Icon(Icons.photo, size: 40, color: Colors.grey[600]),
                        ),
                      ),
                      Positioned(
                        top: 4,
                        right: 4,
                        child: GestureDetector(
                          onTap: () => _removeImage(index),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(4),
                            child: const Icon(Icons.close, size: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ] else ...[
            const Spacer(),
            Column(
              children: [
                Icon(Icons.photo_library, size: 80, color: Colors.grey[400]),
                const SizedBox(height: 16),
                Text(
                  'no_photos_added'.tr(),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const Spacer(),
          ],

          const SizedBox(height: 16),

          // Bottoni
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: widget.onBack,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Theme.of(context).textTheme.bodyLarge?.color,
                    side: BorderSide(
                      color: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.grey,
                    ),
                  ),
                  child: Text('back'.tr()),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: _photoUrls.isNotEmpty ? () {
                    widget.onNext(_photoUrls);
                  } : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).textTheme.bodyLarge?.color,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    'next'.tr(),
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}