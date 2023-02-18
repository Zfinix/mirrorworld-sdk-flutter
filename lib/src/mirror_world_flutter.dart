library mirror_world_flutter;

import 'dart:async';

import 'package:mirror_world_flutter/mirror_world_flutter.dart';

class MirrorWorldFlutter {
  /// private constructor to not allow the object creation from outside.
  MirrorWorldFlutter._();

  static final MirrorWorldFlutter _instance = MirrorWorldFlutter._();

  /// get the instance of the [MirrorWorldFlutter].
  static MirrorWorldFlutter get instance => _instance;

  /// Function to initialize the MirrorSDK
  Future<void> initialize({
    required String apiKey,
    MirrorEnv? mirrorEnv,
    bool? useDebugMode,
  }) {
    return MirrorWorldFlutterPlatform.instance.initialize(
      apiKey: apiKey,
      mirrorEnv: mirrorEnv,
      useDebugMode: useDebugMode,
    );
  }

  Future<void> startLogin() {
    return MirrorWorldFlutterPlatform.instance.startLogin();
  }

  Future<void> loginWithEmail({
    required String email,
    required String password,
  }) {
    return MirrorWorldFlutterPlatform.instance.loginWithEmail(
      email: email,
      password: password,
    );
  }

  Future<void> guestLogin() {
    return MirrorWorldFlutterPlatform.instance.guestLogin();
  }

  Future<void> logOut() {
    return MirrorWorldFlutterPlatform.instance.logOut();
  }

  Future<void> openMarket({
    required String marketUrl,
  }) {
    return MirrorWorldFlutterPlatform.instance.openMarket(
      marketUrl: marketUrl,
    );
  }

  Future<void> openUrl({
    required String url,
  }) {
    return MirrorWorldFlutterPlatform.instance.openUrl(
      url: url,
    );
  }

  Future<void> openWallet({
    String? walletUrl,
  }) {
    return MirrorWorldFlutterPlatform.instance.openWallet(
      walletUrl: walletUrl,
    );
  }

  Future<void> fetchUser() {
    return MirrorWorldFlutterPlatform.instance.fetchUser();
  }

  Future<void> queryUser({
    required String email,
  }) {
    return MirrorWorldFlutterPlatform.instance.queryUser(
      email: email,
    );
  }

  Future<void> getTokens() {
    return MirrorWorldFlutterPlatform.instance.getTokens();
  }

  Future<void> getTransactions({
    required String before,
    int? limit,
  }) async {
    try {
      MirrorWorldFlutterPlatform.instance.getTransactions(
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
      await MirrorWorldFlutterPlatform.instance.getTransaction(
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
      MirrorWorldFlutterPlatform.instance.getNFTDetails(
        mintAddress: mintAddress,
      );
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> getNFTsOwnedByAddress({
    required String ownerWalletAddress,
  }) {
    return MirrorWorldFlutterPlatform.instance.getNFTsOwnedByAddress(
      ownerWalletAddress: ownerWalletAddress,
    );
  }

  Future<void> transferSOL({
    required String toPublicKey,
    required double amount,
  }) {
    return MirrorWorldFlutterPlatform.instance.transferSOL(
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
    return MirrorWorldFlutterPlatform.instance.transferSPLToken(
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
    return MirrorWorldFlutterPlatform.instance.createVerifiedCollection(
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
    return MirrorWorldFlutterPlatform.instance.mintNFT(
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
    return MirrorWorldFlutterPlatform.instance.checkStatusOfMinting(
      mintAddresses: mintAddresses,
    );
  }

  Future<void> listNFT({
    required double price,
    required String mintAddress,
    String? auctionHouse,
    String? confirmation,
  }) {
    return MirrorWorldFlutterPlatform.instance.listNFT(
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
    return MirrorWorldFlutterPlatform.instance.buyNFT(
      price: price,
      mintAddress: mintAddress,
    );
  }

  Future<void> updateNFTListing({
    required double price,
    required String mintAddress,
    required String confirmation,
  }) {
    return MirrorWorldFlutterPlatform.instance.updateNFTListing(
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
    return MirrorWorldFlutterPlatform.instance.updateNFTProperties(
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
    return MirrorWorldFlutterPlatform.instance.cancelNFTListing(
      price: price,
      mintAddress: mintAddress,
      confirmation: confirmation,
    );
  }

  Future<void> transferNFT({
    required String mintAddress,
    required String toWalletAddress,
  }) {
    return MirrorWorldFlutterPlatform.instance.transferNFT(
      mintAddress: mintAddress,
      toWalletAddress: toWalletAddress,
    );
  }

  Future<void> fetchNFTsByMintAddresses({
    required List<String> mintAddresses,
  }) {
    return MirrorWorldFlutterPlatform.instance.fetchNFTsByMintAddresses(
      mintAddresses: mintAddresses,
    );
  }

  Future<void> fetchNFTsByCreatorAddresses({
    required List<String> creators,
    int? limit,
    int? offset,
  }) {
    return MirrorWorldFlutterPlatform.instance.fetchNFTsByCreatorAddresses(
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
    return MirrorWorldFlutterPlatform.instance.fetchNFTsByUpdateAuthorities(
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
    return MirrorWorldFlutterPlatform.instance.fetchNFTsByOwnerAddresses(
      owners: owners,
      limit: limit,
      offset: offset,
    );
  }

  Future<void> fetchNFTMarketplaceActivity({
    required String mintAddress,
  }) {
    return MirrorWorldFlutterPlatform.instance.fetchNFTMarketplaceActivity(
      mintAddress: mintAddress,
    );
  }
}
