class SyncResolver {
  const SyncResolver();

  bool shouldUseRemote(DateTime localUpdatedAt, DateTime remoteUpdatedAt) {
    return remoteUpdatedAt.isAfter(localUpdatedAt);
  }
}
