import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'enum/enum.dart';
import 'mirror_world_flutter_platform_interface.dart';

/// An implementation of [MirrorWorldFlutterPlatform] that uses method channels.
class MethodChannelMirrorWorldFlutter extends MirrorWorldFlutterPlatform {
  /// The method channel used to interact with the native platform.

  MethodChannelMirrorWorldFlutter() {
    listen();
  }

  @visibleForTesting
  final methodChannel = const MethodChannel('mirror_world_flutter');

  @visibleForTesting
  final eventChannel = const EventChannel('mirror_world_flutter/event');

  @override
  Future<void> listen() async {
    print('Listening to: ${eventChannel.name}');
    await for (final event in eventChannel.receiveBroadcastStream()) {
      try {
        print('mirror_world_flutter/event: ${jsonEncode(event)}');
      } catch (e) {
        print(e.toString());
      }
    }
  }

  @override
  Future<void> initialize({
    required String apiKey,
    MirrorEnv? mirrorEnv,
    bool? useDebugMode,
  }) {
    return methodChannel.invokeMethod(
      'initialize',
      {
        'api_key': apiKey,
        'mirror_env': (mirrorEnv ?? MirrorEnv.devNet).value,
        'use_debug_mode': useDebugMode ?? false,
      },
    );
  }

  @override
  Future<void> startLogin() async {
    return methodChannel.invokeMethod('startLogin');
  }

  @override
  Future<void> loginWithEmail({
    required String email,
    required String password,
  }) {
    return methodChannel.invokeMethod(
      'loginWithEmail',
      {
        'email': email,
        'password': password,
      },
    );
  }

  @override
  Future<void> guestLogin() {
    return methodChannel.invokeMethod('guestLogin');
  }

  @override
  Future<void> logOut() {
    return methodChannel.invokeMethod('logOut');
  }

  @override
  Future<bool> checkAuthenticated() async {
    return await methodChannel.invokeMethod<bool>('checkAuthenticated') ??
        false;
  }

  @override
  Future<void> openMarket({
    required String marketUrl,
  }) {
    return methodChannel.invokeMethod(
      'openMarket',
      {
        'market_url': marketUrl,
      },
    );
  }

  @override
  Future<void> openUrl({
    required String url,
  }) {
    return methodChannel.invokeMethod(
      'openUrl',
      {
        'url': url,
      },
    );
  }

  @override
  Future<void> openWallet({
    String? walletUrl,
  }) {
    return methodChannel.invokeMethod(
      'openWallet',
      {
        'wallet_url': walletUrl,
      },
    );
  }

  @override
  Future<void> fetchUser() {
    return methodChannel.invokeMethod(
      'fetchUser',
    );
  }

  @override
  Future<void> queryUser({
    required String email,
  }) {
    return methodChannel.invokeMethod(
      'queryUser',
      {
        'email': email,
      },
    );
  }

  @override
  Future<void> getTokens() {
    return methodChannel.invokeMethod('getTokens');
  }

  @override
  Future<void> getTransactions({
    required String before,
    int? limit,
  }) {
    return methodChannel.invokeMethod(
      'getTransactions',
      {
        'limit': limit,
        'before': before,
      },
    );
  }

  @override
  Future<void> getTransaction({
    required String signature,
  }) {
    return methodChannel.invokeMethod(
      'getTransaction',
      {
        'signature': signature,
      },
    );
  }

  @override
  Future<void> getNFTDetails({
    required String mintAddress,
  }) {
    return methodChannel.invokeMethod(
      'getNFTDetails',
      {
        'mint_address': mintAddress,
      },
    );
  }

  @override
  Future<void> getNFTsOwnedByAddress({
    required String ownerWalletAddress,
  }) {
    return methodChannel.invokeMethod(
      'getNFTsOwnedByAddress',
      {
        'owner_wallet_address': ownerWalletAddress,
      },
    );
  }

  @override
  Future<void> transferSOL({
    required String toPublicKey,
    required double amount,
  }) {
    return methodChannel.invokeMethod(
      'transferSOL',
      {
        'to_public_key': toPublicKey,
        'amount': amount,
      },
    );
  }

  @override
  Future<void> transferSPLToken({
    required String toPublicKey,
    required String tokenMint,
    required double amount,
    required double decimals,
  }) {
    return methodChannel.invokeMethod(
      'transferSOL',
      {
        'to_public_key': toPublicKey,
        'amount': amount,
        'token_mint': amount,
        'decimals': decimals,
      },
    );
  }

  @override
  Future<void> createVerifiedCollection({
    required String name,
    required String symbol,
    required String detailUrl,
    String? confirmation,
  }) {
    return methodChannel.invokeMethod(
      'createVerifiedCollection',
      {
        'name': name,
        'symbol': symbol,
        'detail_url': detailUrl,
        'confirmation': confirmation,
      },
    );
  }

  @override
  Future<void> mintNFT({
    required String name,
    required String collectionMint,
    required String symbol,
    required String detailUrl,
    String? confirmation,
  }) {
    return methodChannel.invokeMethod(
      'mintNFT',
      {
        'name': name,
        'collection_mint': collectionMint,
        'symbol': symbol,
        'detail_url': detailUrl,
        'confirmation': confirmation,
      },
    );
  }

  @override
  Future<void> checkStatusOfMinting({
    required List<String> mintAddresses,
  }) {
    return methodChannel.invokeMethod(
      'checkStatusOfMinting',
      {
        'mint_addresses': mintAddresses,
      },
    );
  }

  @override
  Future<void> listNFT({
    required double price,
    required String mintAddress,
    String? auctionHouse,
    String? confirmation,
  }) {
    return methodChannel.invokeMethod(
      'listNFT',
      {
        'price': price,
        'mint_address': mintAddress,
        'auction_house': auctionHouse,
        'confirmation': confirmation,
      },
    );
  }

  @override
  Future<void> buyNFT({
    required double price,
    required String mintAddress,
  }) {
    return methodChannel.invokeMethod(
      'buyNFT',
      {
        'price': price,
        'mint_address': mintAddress,
      },
    );
  }

  @override
  Future<void> updateNFTListing({
    required double price,
    required String mintAddress,
    required String confirmation,
  }) {
    return methodChannel.invokeMethod(
      'updateNFTListing',
      {
        'price': price,
        'mint_address': mintAddress,
        'confirmation': confirmation,
      },
    );
  }

  @override
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
    return methodChannel.invokeMethod(
      'updateNFTProperties',
      {
        'mint_address': mintAddress,
        'name': name,
        'update_authority': updateAuthority,
        'nft_json_url': nftJsonUrl,
        'symbol': symbol,
        'seller_fee_basis_points': sellerFeeBasisPoints,
        'confirmation': confirmation,
      },
    );
  }

  @override
  Future<void> cancelNFTListing({
    required double price,
    required String mintAddress,
    required String confirmation,
  }) {
    return methodChannel.invokeMethod(
      'cancelNFTListing',
      {
        'price': price,
        'mint_address': mintAddress,
        'confirmation': confirmation,
      },
    );
  }

  @override
  Future<void> transferNFT({
    required String mintAddress,
    required String toWalletAddress,
  }) {
    return methodChannel.invokeMethod(
      'transferNFT',
      {
        'mint_address': mintAddress,
        'to_wallet_address': toWalletAddress,
      },
    );
  }

  @override
  Future<void> fetchNFTsByMintAddresses({
    required List<String> mintAddresses,
  }) {
    return methodChannel.invokeMethod(
      'fetchNFTsByMintAddresses',
      {
        'mint_addresses': mintAddresses,
      },
    );
  }

  @override
  Future<void> fetchNFTsByCreatorAddresses({
    required List<String> creators,
    int? limit,
    int? offset,
  }) {
    return methodChannel.invokeMethod(
      'fetchNFTsByCreatorAddresses',
      {
        'creators': creators,
        'limit': limit,
        'offset': offset,
      },
    );
  }

  @override
  Future<void> fetchNFTsByUpdateAuthorities({
    required List<String> updateAuthorities,
    int? limit,
    int? offset,
  }) {
    return methodChannel.invokeMethod(
      'fetchNFTsByUpdateAuthorities',
      {
        'update_authorities': updateAuthorities,
        'limit': limit,
        'offset': offset,
      },
    );
  }

  @override
  Future<void> fetchNFTsByOwnerAddresses({
    required List<String> owners,
    int? limit,
    int? offset,
  }) {
    return methodChannel.invokeMethod(
      'fetchNFTsByOwnerAddresses',
      {
        'owners': owners,
        'limit': limit,
        'offset': offset,
      },
    );
  }

  @override
  Future<void> fetchNFTMarketplaceActivity({
    required String mintAddress,
  }) {
    return methodChannel.invokeMethod(
      'fetchNFTMarketplaceActivity',
      {
        'mint_address': mintAddress,
      },
    );
  }
}
