import 'package:mirror_world_flutter/mirror_world_flutter.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

abstract class MirrorWorldFlutterPlatform extends PlatformInterface {
  /// Constructs a MirrorWorldFlutterPlatform.
  MirrorWorldFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static MirrorWorldFlutterPlatform _instance =
      MethodChannelMirrorWorldFlutter();

  /// The default instance of [MirrorWorldFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelMirrorWorldFlutter].
  static MirrorWorldFlutterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MirrorWorldFlutterPlatform] when
  /// they register themselves.
  static set instance(MirrorWorldFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> initialize({
    required String apiKey,
    MirrorEnv? mirrorEnv,
    bool? useDebugMode,
  }) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<void> listen() {
    throw UnimplementedError('listen() has not been implemented.');
  }

  Future<void> openWallet({
    String? walletUrl,
  }) {
    throw UnimplementedError('openWallet() has not been implemented.');
  }

  Future<void> startLogin() {
    throw UnimplementedError('startLogin() has not been implemented.');
  }

  Future<void> loginWithEmail({
    required String email,
    required String password,
  }) {
    throw UnimplementedError('loginWithEmail() has not been implemented.');
  }

  Future<void> guestLogin() {
    throw UnimplementedError('guestLogin() has not been implemented.');
  }

  Future<bool> isLoggedIn() {
    throw UnimplementedError('isLoggedIn() has not been implemented.');
  }

  Future<void> logOut() {
    throw UnimplementedError('logOut() has not been implemented.');
  }

  Future<void> openMarket({
    required String marketUrl,
  }) {
    throw UnimplementedError('openMarket() has not been implemented.');
  }

  Future<void> openUrl({
    required String url,
  }) {
    throw UnimplementedError('openUrl() has not been implemented.');
  }

  Future<void> fetchUser() {
    throw UnimplementedError('fetchUser() has not been implemented.');
  }

  Future<void> queryUser({
    required String email,
  }) {
    throw UnimplementedError('queryUser() has not been implemented.');
  }

  Future<void> getTokens() {
    throw UnimplementedError('getTokens() has not been implemented.');
  }

  Future<void> getTransactions({
    required String before,
    int? limit,
  }) {
    throw UnimplementedError('getTransactions() has not been implemented.');
  }

  Future<void> getTransaction({
    required String signature,
  }) {
    throw UnimplementedError('getTransaction() has not been implemented.');
  }

  Future<void> getNFTDetails({
    required String mintAddress,
  }) {
    throw UnimplementedError('getNFTDetails() has not been implemented.');
  }

  Future<void> getNFTsOwnedByAddress({
    required String ownerWalletAddress,
  }) {
    throw UnimplementedError(
        'getNFTsOwnedByAddress() has not been implemented.');
  }

  Future<void> transferSOL({
    required String toPublicKey,
    required double amount,
  }) {
    throw UnimplementedError('transferSOL() has not been implemented.');
  }

  Future<void> transferSPLToken({
    required String toPublicKey,
    required String tokenMint,
    required double amount,
    required double decimals,
  }) {
    throw UnimplementedError('transferSPLToken() has not been implemented.');
  }

  Future<void> createVerifiedCollection({
    required String name,
    required String symbol,
    required String detailUrl,
    String? confirmation,
  }) {
    throw UnimplementedError(
        'createVerifiedCollection() has not been implemented.');
  }

  Future<void> mintNFT({
    required String name,
    required String collectionMint,
    required String symbol,
    required String detailUrl,
    String? confirmation,
  }) {
    throw UnimplementedError('mintNFT() has not been implemented.');
  }

  Future<void> checkStatusOfMinting({
    required List<String> mintAddresses,
  }) {
    throw UnimplementedError(
        'checkStatusOfMinting() has not been implemented.');
  }

  Future<void> listNFT({
    required double price,
    required String mintAddress,
    String? auctionHouse,
    String? confirmation,
  }) {
    throw UnimplementedError('listNFT() has not been implemented.');
  }

  Future<void> buyNFT({
    required double price,
    required String mintAddress,
  }) {
    throw UnimplementedError('buyNFT() has not been implemented.');
  }

  Future<void> updateNFTListing({
    required double price,
    required String mintAddress,
    required String confirmation,
  }) {
    throw UnimplementedError('updateNFTListing() has not been implemented.');
  }

  Future<void> updateNFTProperties({
    required String mintAddress,
    required String name,
    required double updateAuthority,
    required double nftJsonUrl,
    required String symbol,
    required int sellerFeeBasisPoints,
    required String detailUrl,
    String? confirmation,
  }) {
    throw UnimplementedError('updateNFTProperties() has not been implemented.');
  }

  Future<void> cancelNFTListing({
    required double price,
    required String mintAddress,
    required String confirmation,
  }) {
    throw UnimplementedError('cancelNFTListing() has not been implemented.');
  }

  Future<void> transferNFT({
    required String mintAddress,
    required String toWalletAddress,
  }) {
    throw UnimplementedError('transferNFT() has not been implemented.');
  }

  Future<void> fetchNFTsByMintAddresses({
    required List<String> mintAddresses,
  }) {
    throw UnimplementedError(
        'fetchNFTsByMintAddresses() has not been implemented.');
  }

  Future<void> fetchNFTsByCreatorAddresses({
    required List<String> creators,
    int? limit,
    int? offset,
  }) {
    throw UnimplementedError(
        'fetchNFTsByCreatorAddresses() has not been implemented.');
  }

  Future<void> fetchNFTsByUpdateAuthorities({
    required List<String> updateAuthorities,
    int? limit,
    int? offset,
  }) {
    throw UnimplementedError(
        'fetchNFTsByUpdateAuthorities() has not been implemented.');
  }

  Future<void> fetchNFTsByOwnerAddresses({
    required List<String> owners,
    int? limit,
    int? offset,
  }) {
    throw UnimplementedError(
        'fetchNFTsByOwnerAddresses() has not been implemented.');
  }

  Future<void> fetchNFTMarketplaceActivity({
    required String mintAddress,
  }) {
    throw UnimplementedError(
        'fetchNFTMarketplaceActivity() has not been implemented.');
  }
}
