library mirror_world_universe;

import 'dart:async';
import 'package:mirror_world_universe/mirror_world_universe.dart';

class MirrorWorldUniverse {
  /// private constructor to not allow the object creation from outside.
  MirrorWorldUniverse._();

  static final MirrorWorldUniverse _instance = MirrorWorldUniverse._();

  /// get the instance of the [MirrorWorldUniverse].
  static MirrorWorldUniverse get instance => _instance;

  /// Function to initialize the Intercom SDK.
  ///
  /// First, you'll need to get your Intercom [apiKey].
  /// [mirrorEnv] is required if you want to use Intercom in Android.
  /// [useDebugMode] is required if you want to use Intercom in iOS.
  ///
  /// You can get these from Intercom settings:
  /// * [Android](https://app.intercom.com/a/apps/_/settings/android)
  /// * [iOS](https://app.intercom.com/a/apps/_/settings/ios)
  ///
  /// Then, initialize Intercom in main method.
  Future<void> initialize({
    required String apiKey,
    MirrorEnv? mirrorEnv,
    bool? useDebugMode,
  }) {
    return MirrorworldUniversePlatform.instance.initialize(
      apiKey: apiKey,
      mirrorEnv: mirrorEnv,
      useDebugMode: useDebugMode,
    );
  }

  Future<void> startLogin() {
    return MirrorworldUniversePlatform.instance.startLogin();
  }

  Future<void> loginWithEmail({
    required String email,
    required String password,
  }) {
    return MirrorworldUniversePlatform.instance.loginWithEmail(
      email: email,
      password: password,
    );
  }

  Future<void> guestLogin() {
    return MirrorworldUniversePlatform.instance.guestLogin();
  }

  Future<void> logOut() {
    return MirrorworldUniversePlatform.instance.logOut();
  }

  Future<void> openMarket({
    required String marketUrl,
  }) {
    return MirrorworldUniversePlatform.instance.openMarket(
      marketUrl: marketUrl,
    );
  }

  Future<void> openUrl({
    required String url,
  }) {
    return MirrorworldUniversePlatform.instance.openUrl(
      url: url,
    );
  }

  Future<void> openWallet({
    String? walletUrl,
  }) {
    return MirrorworldUniversePlatform.instance.openWallet(
      walletUrl: walletUrl,
    );
  }

  Future<void> fetchUser() {
    return MirrorworldUniversePlatform.instance.fetchUser();
  }

  Future<void> queryUser({
    required String email,
  }) {
    return MirrorworldUniversePlatform.instance.queryUser(
      email: email,
    );
  }

  Future<void> getTokens() {
    return MirrorworldUniversePlatform.instance.getTokens();
  }

  Future<void> getTransactions({
    required String before,
    int? limit,
  }) async {
    try {
      MirrorworldUniversePlatform.instance.getTransactions(
        before: before,
        limit: limit,
      );
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> getTransaction({
    required String signature,
  }) async {
    try {
      await MirrorworldUniversePlatform.instance.getTransaction(
        signature: signature,
      );
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> getNFTDetails({
    required String mintAddress,
  }) async {
    try {
      MirrorworldUniversePlatform.instance.getNFTDetails(
        mintAddress: mintAddress,
      );
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> getNFTsOwnedByAddress({
    required String ownerWalletAddress,
  }) {
    return MirrorworldUniversePlatform.instance.getNFTsOwnedByAddress(
      ownerWalletAddress: ownerWalletAddress,
    );
  }

  Future<void> transferSOL({
    required String toPublicKey,
    required double amount,
  }) {
    return MirrorworldUniversePlatform.instance.transferSOL(
      toPublicKey: toPublicKey,
      amount: amount,
    );
  }

  Future<void> transferSPLToken({
    required String toPublicKey,
    required String tokenMint,
    required double amount,
    required double decimals,
  }) {
    return MirrorworldUniversePlatform.instance.transferSPLToken(
      toPublicKey: toPublicKey,
      tokenMint: tokenMint,
      amount: amount,
      decimals: decimals,
    );
  }

  Future<void> createVerifiedCollection({
    required String name,
    required String symbol,
    required String detailUrl,
    String? confirmation,
  }) {
    return MirrorworldUniversePlatform.instance.createVerifiedCollection(
      name: name,
      symbol: symbol,
      detailUrl: detailUrl,
      confirmation: confirmation,
    );
  }

  Future<void> mintNFT({
    required String name,
    required String collectionMint,
    required String symbol,
    required String detailUrl,
    String? confirmation,
  }) {
    return MirrorworldUniversePlatform.instance.mintNFT(
      name: name,
      collectionMint: collectionMint,
      symbol: symbol,
      detailUrl: detailUrl,
      confirmation: confirmation,
    );
  }

  Future<void> checkStatusOfMinting({
    required List<String> mintAddresses,
  }) {
    return MirrorworldUniversePlatform.instance.checkStatusOfMinting(
      mintAddresses: mintAddresses,
    );
  }

  Future<void> listNFT({
    required double price,
    required String mintAddress,
    String? auctionHouse,
    String? confirmation,
  }) {
    return MirrorworldUniversePlatform.instance.listNFT(
      price: price,
      mintAddress: mintAddress,
      auctionHouse: auctionHouse,
      confirmation: confirmation,
    );
  }

  Future<void> buyNFT({
    required double price,
    required String mintAddress,
  }) {
    return MirrorworldUniversePlatform.instance.buyNFT(
      price: price,
      mintAddress: mintAddress,
    );
  }

  Future<void> updateNFTListing({
    required double price,
    required String mintAddress,
    required String confirmation,
  }) {
    return MirrorworldUniversePlatform.instance.updateNFTListing(
      price: price,
      mintAddress: mintAddress,
      confirmation: confirmation,
    );
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
    return MirrorworldUniversePlatform.instance.updateNFTProperties(
      mintAddress: mintAddress,
      name: name,
      updateAuthority: updateAuthority,
      nftJsonUrl: nftJsonUrl,
      symbol: symbol,
      sellerFeeBasisPoints: sellerFeeBasisPoints,
      detailUrl: detailUrl,
    );
  }

  Future<void> cancelNFTListing({
    required double price,
    required String mintAddress,
    required String confirmation,
  }) {
    return MirrorworldUniversePlatform.instance.cancelNFTListing(
      price: price,
      mintAddress: mintAddress,
      confirmation: confirmation,
    );
  }

  Future<void> transferNFT({
    required String mintAddress,
    required String toWalletAddress,
  }) {
    return MirrorworldUniversePlatform.instance.transferNFT(
      mintAddress: mintAddress,
      toWalletAddress: toWalletAddress,
    );
  }

  Future<void> fetchNFTsByMintAddresses({
    required List<String> mintAddresses,
  }) {
    return MirrorworldUniversePlatform.instance.fetchNFTsByMintAddresses(
      mintAddresses: mintAddresses,
    );
  }

  Future<void> fetchNFTsByCreatorAddresses({
    required List<String> creators,
    int? limit,
    int? offset,
  }) {
    return MirrorworldUniversePlatform.instance.fetchNFTsByCreatorAddresses(
      creators: creators,
      limit: limit,
      offset: offset,
    );
  }

  Future<void> fetchNFTsByUpdateAuthorities({
    required List<String> updateAuthorities,
    int? limit,
    int? offset,
  }) {
    return MirrorworldUniversePlatform.instance.fetchNFTsByUpdateAuthorities(
      updateAuthorities: updateAuthorities,
      limit: limit,
      offset: offset,
    );
  }

  Future<void> fetchNFTsByOwnerAddresses({
    required List<String> owners,
    int? limit,
    int? offset,
  }) {
    return MirrorworldUniversePlatform.instance.fetchNFTsByOwnerAddresses(
      owners: owners,
      limit: limit,
      offset: offset,
    );
  }

  Future<void> fetchNFTMarketplaceActivity({
    required String mintAddress,
  }) {
    return MirrorworldUniversePlatform.instance.fetchNFTMarketplaceActivity(
      mintAddress: mintAddress,
    );
  }
}
