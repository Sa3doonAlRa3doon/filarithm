import 'package:filarithm/core/inventory/fifo_allocator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const allocator = FifoSpoolAllocator();
  final spools = [
    SpoolStock(
      id: 'new',
      materialProfileId: 'black',
      remainingMassMg: 500000,
      createdAt: DateTime(2026, 2),
    ),
    SpoolStock(
      id: 'old',
      materialProfileId: 'black',
      remainingMassMg: 250000,
      createdAt: DateTime(2026, 1),
      openedAt: DateTime(2026, 1, 3),
    ),
    SpoolStock(
      id: 'pink',
      materialProfileId: 'pink',
      remainingMassMg: 999000,
      createdAt: DateTime(2025),
    ),
  ];

  test('splits a deduction across matching spools in FIFO order', () {
    final plan = allocator.allocate(
      materialProfileId: 'black',
      requestedMassMg: 400000,
      spools: spools,
    );

    expect(plan.isFullyAllocated, isTrue);
    expect(plan.allocations.map((item) => item.spoolId), ['old', 'new']);
    expect(plan.allocations.map((item) => item.massMg), [250000, 150000]);
  });

  test('reports stock shortfall without deducting another material', () {
    final plan = allocator.allocate(
      materialProfileId: 'black',
      requestedMassMg: 900000,
      spools: spools,
    );

    expect(plan.shortfallMassMg, 150000);
    expect(plan.allocations.every((item) => item.spoolId != 'pink'), isTrue);
  });
}
