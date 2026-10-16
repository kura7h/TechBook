enum RecordType {
  maintenance('ТО'),
  repair('Ремонт'),
  diagnostics('Діагностика');

  const RecordType(this.label);

  final String label;
}
