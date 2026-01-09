import 'package:firebase_auth/firebase_auth.dart';
import 'package:weightvault/core/services/storage_service.dart';
import 'package:weightvault/data/remote/firebase_client.dart';
import 'package:weightvault/domain/repositories/repositories.dart';
class AccountDeletionService {
  AccountDeletionService({
    required this.client,
    required this.auth,
    required this.storage,
    required this.userProfiles,
    required this.weights,
    required this.measurements,
    required this.waters,
    required this.foods,
    required this.customFoods,
    required this.fastings,
    required this.activities,
    required this.photos,
    required this.syncLogs,
  });

  final FirebaseClient client;
  final FirebaseAuth auth;
  final StorageService storage;
  final UserProfileRepository userProfiles;
  final WeightRepository weights;
  final MeasurementRepository measurements;
  final WaterRepository waters;
  final FoodRepository foods;
  final CustomFoodRepository customFoods;
  final FastingRepository fastings;
  final ActivityRepository activities;
  final PhotoRepository photos;
  final SyncLogRepository syncLogs;

  Future<void> deleteAccount(String uid) async {
    await _deleteFirestoreData(uid);
    await _deleteStorage(uid);
    await _deleteLocal(uid);
    await auth.currentUser?.delete();
  }

  Future<void> _deleteFirestoreData(String uid) async {
    final collections = [
      'weights',
      'measurements',
      'water',
      'foods',
      'custom_foods',
      'fasting',
      'activities',
      'photos',
    ];
    for (final collection in collections) {
      final snapshot = await client.userCollection(uid, collection).get();
      for (final doc in snapshot.docs) {
        await doc.reference.delete();
      }
    }
    await client.userDoc(uid).delete();
  }

  Future<void> _deleteStorage(String uid) async {
    final ref = storage.storage.ref('users/$uid/photos');
    final list = await ref.listAll();
    for (final item in list.items) {
      await item.delete();
    }
  }

  Future<void> _deleteLocal(String uid) async {
    await userProfiles.deleteAll(uid);
    await weights.hardDeleteAll(uid);
    await measurements.hardDeleteAll(uid);
    await waters.hardDeleteAll(uid);
    await foods.hardDeleteAll(uid);
    await customFoods.hardDeleteAll(uid);
    await fastings.hardDeleteAll(uid);
    await activities.hardDeleteAll(uid);
    await photos.hardDeleteAll(uid);
    await syncLogs.deleteAll(uid);
  }
}
