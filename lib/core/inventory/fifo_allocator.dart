class SpoolStock {
  const SpoolStock({
    required this.id,
    required this.materialProfileId,
    required this.remainingMassMg,
    required this.createdAt,
    this.openedAt,
  });

  final String id;
  final String materialProfileId;
  final int remainingMassMg;
  final DateTime createdAt;
  final DateTime? openedAt;
}

class SpoolAllocation {
  const SpoolAllocation({required this.spoolId, required this.massMg});

  final String spoolId;
  final int massMg;
}

class AllocationPlan {
  const AllocationPlan({
    required this.allocations,
    required this.requestedMassMg,
    required this.shortfallMassMg,
  });

  final List<SpoolAllocation> allocations;
  final int requestedMassMg;
  final int shortfallMassMg;

  bool get isFullyAllocated => shortfallMassMg == 0;
}

class FifoSpoolAllocator {
  const FifoSpoolAllocator();

  AllocationPlan allocate({
    required String materialProfileId,
    required int requestedMassMg,
    required Iterable<SpoolStock> spools,
  }) {
    if (requestedMassMg < 0) {
      throw const FormatException('Requested filament cannot be negative.');
    }
    final candidates =
        spools
            .where(
              (spool) =>
                  spool.materialProfileId == materialProfileId &&
                  spool.remainingMassMg > 0,
            )
            .toList()
          ..sort((left, right) {
            final leftIsOpen = left.openedAt != null;
            final rightIsOpen = right.openedAt != null;
            if (leftIsOpen != rightIsOpen) {
              return leftIsOpen ? -1 : 1;
            }
            final leftDate = left.openedAt ?? left.createdAt;
            final rightDate = right.openedAt ?? right.createdAt;
            final dateOrder = leftDate.compareTo(rightDate);
            return dateOrder == 0 ? left.id.compareTo(right.id) : dateOrder;
          });

    var remaining = requestedMassMg;
    final allocations = <SpoolAllocation>[];
    for (final spool in candidates) {
      if (remaining == 0) break;
      final amount = remaining < spool.remainingMassMg
          ? remaining
          : spool.remainingMassMg;
      allocations.add(SpoolAllocation(spoolId: spool.id, massMg: amount));
      remaining -= amount;
    }
    return AllocationPlan(
      allocations: List.unmodifiable(allocations),
      requestedMassMg: requestedMassMg,
      shortfallMassMg: remaining,
    );
  }
}
