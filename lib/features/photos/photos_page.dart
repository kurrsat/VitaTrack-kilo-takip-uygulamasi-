import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:weightvault/core/constants/app_constants.dart';
import 'package:weightvault/core/providers/app_init_provider.dart';
import 'package:weightvault/core/providers/providers.dart';
import 'package:weightvault/core/ui/widgets.dart';
import 'package:weightvault/core/utils/local_image.dart';
import 'package:weightvault/core/utils/photo_storage.dart';
import 'package:weightvault/data/repositories/repository_providers.dart';
import 'package:weightvault/domain/models/models.dart';
import 'package:weightvault/features/photos/photo_compare_page.dart';
import 'package:weightvault/features/photos/photo_providers.dart';
import 'package:weightvault/features/premium/premium_paywall_page.dart';
import 'package:weightvault/l10n/app_localizations.dart';



class PhotosPage extends ConsumerStatefulWidget {
  const PhotosPage({super.key});

  @override
  ConsumerState<PhotosPage> createState() => _PhotosPageState();
}

class _PhotosPageState extends ConsumerState<PhotosPage> {
  final _picker = ImagePicker();
  bool _loading = false;

  Future<void> _addPhoto(ImageSource source) async {
    final uid = ref.read(currentUserIdProvider);
    if (uid == null) {
      return;
    }
    
    // Check premium limits
    final photos = ref.read(photoEntriesProvider).value ?? [];
    final isPremium = ref.read(premiumServiceProvider).isPremium();
    if (!isPremium && photos.length >= AppConstants.maxFreePhotos) {
      if (mounted) {
        await Navigator.of(context).push<void>(
          MaterialPageRoute<void>(builder: (_) => const PremiumPaywallPage()),
        );
      }
      return;
    }

    setState(() => _loading = true);
    try {
      final picked = await _picker.pickImage(
        source: source,
        imageQuality: 85,
      );
      if (picked == null) {
        return;
      }
      final entryId = const Uuid().v4();
      final localPath = await persistPhoto(picked, entryId);
      final isDemo = ref.read(appInitProvider).value?.demoMode ?? false;
      
      // 1. Create entry with local path immediately
      var entry = PhotoEntry(
        id: entryId,
        uid: uid,
        date: DateTime.now().toUtc(),
        type: PhotoType.front, // Defaulting to front as requested
        storageUrl: null,
        localPath: localPath,
        lastUpdatedAt: DateTime.now().toUtc(),
      );

      // 2. Save to local DB first (Offline-first)
      await ref.read(photoRepositoryProvider).upsert(entry);
      
      // 3. Upload in background if not demo
      if (!isDemo) {
        _uploadInBackground(uid, picked, entry);
      }
      
      // Drift stream will automatically update the UI
    } catch (e) {
      debugPrint('Error adding photo: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Fotoğraf eklenirken hata: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  Future<void> _uploadInBackground(String uid, XFile file, PhotoEntry entry) async {
    try {
      final storageUrl = await ref
          .read(storageServiceProvider)
          .uploadPhoto(file: file, uid: uid, entryId: entry.id);
      
      // Update entry with storage URL
      final updatedEntry = entry.copyWith(storageUrl: storageUrl);
      await ref.read(photoRepositoryProvider).upsert(updatedEntry);
    } catch (e) {
      debugPrint('Photo upload failed (will retry later via sync): $e');
      // Ignore upload error, local data is safe
    }
  }


  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final entriesAsync = ref.watch(photoEntriesProvider);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(strings.progressPhotosTitle),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.compare),
            onPressed: () {
              final entries = entriesAsync.value ?? [];
              if (entries.length >= 2) {
                Navigator.of(context).push<void>(
                  MaterialPageRoute<void>(
                    builder: (_) => PhotoComparePage(
                      before: entries[1],
                      after: entries[0],
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      
      // Floating Action Buttons for direct access (Camera & Gallery)
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: entriesAsync.hasValue && entriesAsync.value!.isNotEmpty 
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton.extended(
                    heroTag: 'camera_fab',
                    onPressed: _loading ? null : () => _addPhoto(ImageSource.camera),
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Kamera'),
                    backgroundColor: const Color(0xFFff9966),
                    foregroundColor: Colors.white,
                  ),
                  const SizedBox(width: 16),
                  FloatingActionButton.extended(
                    heroTag: 'gallery_fab',
                    onPressed: _loading ? null : () => _addPhoto(ImageSource.gallery),
                    icon: const Icon(Icons.photo_library),
                    label: const Text('Galeri'),
                    backgroundColor: const Color(0xFF2CD8D5),
                    foregroundColor: Colors.white,
                  ),
                ],
              ),
            )
          : null, // Hide FABs if empty state (buttons are inline)

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE0F7FA), // Light blue
              Color(0xFFFFF3E0), // Light peach
            ],
          ),
        ),
        child: SafeArea(
          child: AsyncValueView<List<PhotoEntry>>(
            value: entriesAsync,
            data: (entries) {
              if (entries.isEmpty) {
                return Center(
                  child: SingleChildScrollView(
                    child: Container(
                      margin: const EdgeInsets.all(16),
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 25,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Icon
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(
                              Icons.photo_camera_back,
                              size: 60,
                              color: Colors.blue.shade300,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'Henüz fotoğraf yok',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF0D1F3C),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Gelişimini takip etmek için ilk fotoğrafını ekle.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 14,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 32),
                          
                          if (_loading)
                            const CircularProgressIndicator()
                          else
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: () => _addPhoto(ImageSource.camera),
                                    icon: const Icon(Icons.camera_alt, color: Colors.white),
                                    label: const Text('Kamera', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFFff9966),
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: () => _addPhoto(ImageSource.gallery),
                                    icon: const Icon(Icons.photo_library, color: Colors.white),
                                    label: const Text('Galeri', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF2CD8D5),
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              return GridView.builder(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 100), // More bottom padding for FABs
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.9,
                ),
                itemCount: entries.length,
                itemBuilder: (context, index) {
                  final entry = entries[index];
                  return AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _PhotoThumb(entry: entry)),
                        const SizedBox(height: 8),
                         // Since we don't ask for type anymore, we can maybe just show date or hide label
                        Text(
                          entry.date.toLocal().toString().split(' ').first,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  String _photoTypeLabel(AppLocalizations strings, PhotoType type) {
    switch (type) {
      case PhotoType.front:
        return strings.photoTypeFront;
      case PhotoType.side:
        return strings.photoTypeSide;
      case PhotoType.back:
        return strings.photoTypeBack;
    }
  }
}

class _PhotoThumb extends StatelessWidget {
  const _PhotoThumb({required this.entry});

  final PhotoEntry entry;

  @override
  Widget build(BuildContext context) {
    const size = 72.0;
    if (entry.localPath != null && localFileExists(entry.localPath!)) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: buildLocalImage(
          entry.localPath!,
          width: size,
          height: size,
          fit: BoxFit.cover,
        ),
      );
    }
    if (entry.storageUrl != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(entry.storageUrl!, width: size, height: size, fit: BoxFit.cover),
      );
    }
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Icon(Icons.photo),
    );
  }
}
