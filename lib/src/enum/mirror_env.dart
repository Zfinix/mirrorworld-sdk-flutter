enum MirrorEnv {
  stagingDevNet('StagingDevNet'),
  stagingMainNet('StagingMainNet'),
  mainNet('MainNet'),
  devNet('DevNet');

  final String value;
  const MirrorEnv(this.value);
}
