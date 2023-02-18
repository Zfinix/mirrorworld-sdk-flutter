package com.mirrorworld.universe

import android.app.Activity
import android.content.Context
import android.util.Log
import com.mirror.sdk.MirrorMarket
import com.mirror.sdk.MirrorWorld
import com.mirror.sdk.constant.MirrorEnv
import com.mirror.sdk.listener.auth.FetchUserListener
import com.mirror.sdk.listener.auth.LoginListener
import com.mirror.sdk.listener.confirmation.CheckStatusOfMintingListener
import com.mirror.sdk.listener.confirmation.CheckStatusOfMintingResponse
import com.mirror.sdk.listener.market.*
import com.mirror.sdk.listener.marketui.*
import com.mirror.sdk.listener.universal.BoolListener
import com.mirror.sdk.listener.wallet.*
import com.mirror.sdk.response.auth.UserResponse
import com.mirror.sdk.response.market.*
import com.mirror.sdk.response.marketui.*
import com.mirror.sdk.response.wallet.*
import com.mirror.sdk.utils.MirrorGsonUtils
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import org.json.JSONArray
import org.json.JSONObject


internal class MethodCallHandlerImpl(
    context: Context, activity: Activity?, eventChannel: EventChannel, methodChannel: MethodChannel
) : MethodCallHandler, EventChannel.StreamHandler, LoginListener, BoolListener, FetchUserListener {

    private var context: Context?
    private var activity: Activity?
    private var events: EventChannel.EventSink? = null
    private var openWalletResponse: String? = null
    private var walletUrl: String = ""
    private var eventChannel: EventChannel
    private var methodChannel: MethodChannel
    private val logTag: String = "MirrorSDKFlutter"
    private var useDebugMode = true
    private var isLoggedIn = false

    init {
        this.activity = activity
        this.context = context
        this.eventChannel = eventChannel
        this.methodChannel = methodChannel
        eventChannel.setStreamHandler(this)
    }


    fun setActivity(act: Activity?) {
        this.activity = act
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        try {
            when (call.method) {
                "initialize" -> init(call)
                "startLogin" -> startLogin()
                "guestLogin" -> guestLogin()
                "loginWithEmail" -> loginWithEmail(call, result)
                "isLoggedIn" -> result.success(isLoggedIn)
                "logOut" -> logOut()
                "openWallet" -> openWallet(call)
                "openMarket" -> openMarket(call)
                "fetchUser" -> fetchUser()
                "queryUser" -> queryUser(call)
                "getTokens" -> getTokens()
                "openUrl" -> openUrl(call)
                "getTransactions" -> getTransactions(call)
                "getTransaction" -> getTransaction(call)
                "getNFTDetails" -> getNFTDetails(call)
                "getNFTsOwnedByAddress" -> getNFTsOwnedByAddress(call)
                "transferSOL" -> transferSOL(call)
                "transferSPLToken" -> transferSPLToken(call)
                "mintNFT" -> mintNFT(call)
                "listNFT" -> listNFT(call)
                "buyNFT" -> buyNFT(call)
                "transferNFT" -> transferNFT(call)
                "cancelNFTListing" -> cancelNFTListing(call)
                "updateNFTProperties" -> updateNFTProperties(call)
                "updateNFTListing" -> updateNFTListing(call)
                "checkStatusOfMinting" -> checkStatusOfMinting(call)
                "checkStatusOfTransactions" -> checkStatusOfTransactions(call)
                "createVerifiedCollection" -> createVerifiedCollection(call)
                "fetchNFTsByMintAddresses" -> fetchNFTsByMintAddresses(call)
                "fetchNFTsByOwnerAddresses" -> fetchNFTsByOwnerAddresses(call)
                "fetchNFTsByCreatorAddresses" -> fetchNFTsByCreatorAddresses(call)
                "fetchNFTsByUpdateAuthorities" -> fetchNFTsByUpdateAuthorities(call)
                "fetchNFTMarketplaceActivity" -> fetchNFTMarketplaceActivity(call)
                "getNFTInfo" -> getNFTInfo(call, result)
                "searchNFTs" -> searchNFTs(call)
                "getNFTEvents" -> getNFTEvents(call)
                "getNFTRealPrice" -> getNFTRealPrice(call)
                "getCollectionInfo" -> getCollectionInfo(call)
                "getCollectionFilterInfo" -> getCollectionFilterInfo(call)
                else -> result.notImplemented()
            }

        } catch (e: Exception) {
            result.error(logTag, null, e.toString())
        }


    }


    private fun init(call: MethodCall) {

        val apiKey = call.argument<String>("api_key")!!
        val mirrorEnv = call.argument<String>("mirror_env")!!
        if (call.argument<Boolean>("use_debug_mode") == false) {
            useDebugMode = false
        }

        MirrorWorld.setDebug(useDebugMode)
        MirrorWorld.initMirrorWorld(activity, apiKey, MirrorEnv.valueOf(mirrorEnv))
        MirrorWorld.isLoggedIn(this)
    }

    private fun startLogin() {
        MirrorWorld.startLogin(this)
    }

    private fun loginWithEmail(call: MethodCall, result: MethodChannel.Result) {

        MirrorWorld.loginWithEmail(
            call.argument("email") ?: "", call.argument("password") ?: ""
        ) {
            result.success(it)
        }

    }

    private fun guestLogin() {
        MirrorWorld.guestLogin(this)
    }

    private fun logOut() {
        MirrorWorld.logout(this)
    }

    private fun openMarket(call: MethodCall) {
        MirrorWorld.openMarket(call.argument("market_url") ?: "")
    }

    private fun openUrl(call: MethodCall) {
        MirrorWorld.openUrl(call.argument("url") ?: "")
    }

    private fun fetchUser() {
        MirrorWorld.fetchUser(this)
    }

    private fun queryUser(call: MethodCall) {
        MirrorWorld.queryUser(call.argument("email") ?: "", this)
    }

    private fun openWallet(call: MethodCall) {
        val url = call.argument<String>("wallet_url")
        url?.let {
            walletUrl = url
        }

        MirrorWorld.openWallet(walletUrl) {
            events?.success(
                EventsHelper.mapEvent(
                    name = EventsHelper.openWalletEvent,
                    data = openWalletResponse,
                )
            )
        }
    }

    @Suppress("INACCESSIBLE_TYPE")
    private fun getTokens() {
        MirrorWorld.getTokens(object : GetWalletTokenListener {
            override fun onSuccess(res: GetWalletTokenResponse) {
                events?.success(
                    EventsHelper.mapEvent(
                        name = EventsHelper.getTokens,
                        data = mapOf(
                            "tokens" to res.tokens.toString(),
                            "sol" to res.sol,
                        ),
                    )
                )
            }

            override fun onFailed(code: Long, message: String) {
                onFetchFailed(code, message)
            }
        })
    }


    private fun getTransaction(call: MethodCall) {
        val signature = call.argument<String>("signature") ?: ""
        MirrorWorld.getTransaction(
            signature,
            object : GetOneWalletTransactionBySigListener {
                override fun onSuccess(res: TransactionsDTO) {
                    events?.success(
                        EventsHelper.mapEvent(
                            name = EventsHelper.getTransaction,
                            data = MirrorGsonUtils.getInstance().toJson(res)
                        )
                    )

                }

                override fun onFailed(code: Long, message: String) {
                    onFetchFailed(code, message)
                }
            },
        )
    }

    private fun getTransactions(call: MethodCall) {
        val limit = call.argument<Int>("limit") ?: 0
        val before = call.argument<String>("before") ?: ""

        MirrorWorld.getTransactions(
            limit, before,
            object : GetWalletTransactionListener {
                override fun onSuccess(res: GetWalletTransactionsResponse) {
                    events?.success(
                        EventsHelper.mapEvent(
                            name = EventsHelper.getTransactions, data = EventsHelper.toMap(res)
                        )
                    )
                }

                override fun onFailed(code: Long, message: String) {
                    onFetchFailed(code, message)
                }
            },
        )
    }


    private fun getNFTDetails(call: MethodCall) {
        val mintAddress = call.argument<String>("mint_address") ?: ""

        MirrorWorld.getNFTDetails(
            mintAddress,
            object : FetchSingleNFTListener {
                override fun onFetchSuccess(res: SingleNFTResponse) {
                    events?.success(
                        EventsHelper.mapEvent(
                            name = EventsHelper.getNFTDetails,
                            data = EventsHelper.toMap(res),
                        )
                    )
                }

                override fun onFetchFailed(code: Long, message: String) {
                    onFetchFailed(code, message)
                }
            },
        )
    }

    private fun getNFTsOwnedByAddress(call: MethodCall) {
        val ownerWalletAddress = call.argument<String>("owner_wallet_address") ?: ""

        MirrorWorld.getNFTsOwnedByAddress(
            ownerWalletAddress,
            object : FetchNFTsListener {
                override fun onFetchSuccess(res: MultipleNFTsResponse) {
                    events?.success(
                        EventsHelper.mapEvent(name = EventsHelper.getNFTsOwnedByAddress,
                            data = res.nfts.map { EventsHelper.toMap(it) })
                    )
                }

                override fun onFetchFailed(code: Long, message: String) {
                    onFetchFailed(code, message)
                }
            },
        )
    }

    private fun transferSOL(call: MethodCall) {
        val toPublicKey = call.argument<String>("to_public_key") ?: ""
        val amount = call.argument<Double>("amount") ?: 0.0

        MirrorWorld.transferSOL(
            toPublicKey, amount.toFloat(),
            object : TransferSOLListener {
                override fun onTransferSuccess(res: TransferResponse) {
                    Log.d("Fetch result", "$res")
                }

                override fun onTransferFailed(code: Long, message: String) {
                    onFetchFailed(code, message)
                }
            },
        )
    }

    private fun transferSPLToken(call: MethodCall) {
        val toPublicKey = call.argument<String>("to_public_key") ?: ""
        val tokenMint = call.argument<String>("token_mint") ?: ""
        val amount = call.argument<Double>("amount") ?: 0.0
        val decimals = call.argument<Double>("decimals") ?: 0.0

        MirrorWorld.transferSPLToken(
            toPublicKey, amount.toFloat(), tokenMint, decimals.toFloat()
        ) {
            events?.success(
                EventsHelper.mapEvent(
                    name = "transferSPLToken", data = it
                )
            )
        }
    }

    private fun createVerifiedCollection(call: MethodCall) {
        val name = call.argument<String>("name") ?: ""
        val symbol = call.argument<String>("symbol") ?: ""
        val detailUrl = call.argument<String>("detail_url") ?: ""
        val confirmation = call.argument<String>("confirmation")

        MirrorWorld.createVerifiedCollection(
            name, symbol, detailUrl, confirmation,
            object : CreateTopCollectionListener {
                override fun onCreateSuccess(res: MintResponse) {
                    Log.d("Fetch result", "$res")
                }

                override fun onCreateFailed(code: Long, message: String) {
                    onFetchFailed(code, message)
                }
            },
        )
    }

    private fun mintNFT(call: MethodCall) {
        val name = call.argument<String>("name") ?: ""
        val collectionMint = call.argument<String>("collection_mint") ?: ""
        val symbol = call.argument<String>("symbol") ?: ""
        val detailUrl = call.argument<String>("detail_url") ?: ""
        val confirmation = call.argument<String>("confirmation")

        MirrorWorld.mintNFT(
            collectionMint, name, symbol, detailUrl, confirmation,
            object : MintNFTListener {
                override fun onMintSuccess(res: MintResponse) {
                    Log.d("Fetch result", "$res")
                }

                override fun onMintFailed(code: Long, message: String) {
                    onFetchFailed(code, message)
                }
            },
        )
    }


    private fun checkStatusOfMinting(call: MethodCall) {
        val mintAddresses = call.argument<List<String>>("mint_addresses") ?: listOf()

        MirrorWorld.checkStatusOfMinting(mintAddresses, object : CheckStatusOfMintingListener {
            override fun onSuccess(res: CheckStatusOfMintingResponse) {
                Log.d("Fetch result", "$res")
            }

            override fun onCheckFailed(code: Long, message: String) {
                onFetchFailed(code, message)
            }
        })

    }

    private fun checkStatusOfTransactions(call: MethodCall) {
        val signatures = call.argument<List<String>>("signatures") ?: listOf()

        MirrorWorld.checkStatusOfTransactions(
            signatures,
            object : CheckStatusOfMintingListener {
                override fun onSuccess(res: CheckStatusOfMintingResponse) {
                    Log.d("Fetch result", "$res")
                }

                override fun onCheckFailed(code: Long, message: String) {
                    onFetchFailed(code, message)
                }
            },
        )

    }

    private fun listNFT(call: MethodCall) {
        val mintAddress = call.argument<String>("mint_address") ?: ""
        val auctionHouse = call.argument<String>("auction_house") ?: ""
        val confirmation = call.argument<String>("confirmation")
        val price = call.argument<Double>("price") ?: 0.0

        MirrorWorld.listNFT(
            mintAddress,
            price,
            confirmation,
            auctionHouse,
            object : ListNFTListener {
                override fun onListSuccess(res: ListingResponse) {
                    Log.d("Fetch result", "$res")
                }

                override fun onListFailed(code: Long, message: String) {
                    onFetchFailed(code, message)
                }
            },
        )


    }

    private fun buyNFT(call: MethodCall) {
        val mintAddress = call.argument<String>("mint_address") ?: ""
        val price = call.argument<Double>("price") ?: 0.0

        MirrorWorld.buyNFT(
            mintAddress, price,
            object : BuyNFTListener {
                override fun onBuySuccess(res: ListingResponse) {
                    Log.d("Fetch result", "$res")
                }

                override fun onBuyFailed(code: Long, message: String) {
                    onFetchFailed(code, message)
                }
            },
        )

    }

    private fun updateNFTListing(call: MethodCall) {
        val mintAddress = call.argument<String>("mint_address") ?: ""
        val price = call.argument<Double>("price")
        val confirmation = call.argument<String>("confirmation")

        MirrorWorld.updateNFTListing(
            mintAddress,
            price,
            confirmation,
            object : UpdateListListener {
                override fun onUpdateSuccess(res: ListingResponse) {
                    Log.d("Fetch result", "$res")
                }

                override fun onUpdateFailed(code: Long, message: String) {
                    onFetchFailed(code, message)
                }
            },
        )
    }


    private fun updateNFTProperties(call: MethodCall) {
        val mintAddress = call.argument<String>("mint_address")
        val name = call.argument<String>("name") ?: ""
        val updateAuthority = call.argument<String>("update_authority") ?: ""
        val nftJsonUrl = call.argument<String>("nft_json_url") ?: ""
        val symbol = call.argument<String>("symbol") ?: ""
        val sellerFeeBasisPoints = call.argument<Int>("seller_fee_basis_points") ?: 0
        val confirmation = call.argument<String>("confirmation")

        MirrorWorld.updateNFTProperties(
            mintAddress,
            name,
            symbol,
            updateAuthority,
            nftJsonUrl,
            sellerFeeBasisPoints,
            confirmation,
            object : MintNFTListener {
                override fun onMintSuccess(res: MintResponse) {
                }

                override fun onMintFailed(code: Long, message: String) {
                    onFetchFailed(code, message)
                }
            },
        )

    }

    private fun cancelNFTListing(call: MethodCall) {
        val mintAddress = call.argument<String>("mint_address") ?: ""
        val price = call.argument<Double>("price")
        val confirmation = call.argument<String>("confirmation")

        MirrorWorld.cancelNFTListing(
            mintAddress,
            price,
            confirmation,
            object : CancelListListener {
                override fun onCancelSuccess(res: ListingResponse) {
                    Log.d("Fetch result", "$res")
                }

                override fun onCancelFailed(code: Long, message: String) {
                    onFetchFailed(code, message)
                }
            },
        )
    }

    private fun transferNFT(call: MethodCall) {
        val mintAddress = call.argument<String>("mint_address") ?: ""
        val toWalletAddress = call.argument<String>("to_wallet_address") ?: ""

        MirrorWorld.transferNFT(
            mintAddress, toWalletAddress,
            object : TransferNFTListener {
                override fun onTransferSuccess(res: ListingResponse) {
                    Log.d("Fetch result", "$res")
                }

                override fun onTransferFailed(code: Long, message: String) {
                    onFetchFailed(code, message)
                }
            },
        )
    }

    private fun fetchNFTsByMintAddresses(call: MethodCall) {
        val mintAddresses = call.argument<List<String>>("mint_addresses") ?: listOf()

        MirrorWorld.fetchNFTsByMintAddresses(
            mintAddresses,
            object : FetchNFTsListener {
                override fun onFetchSuccess(res: MultipleNFTsResponse) {
                    Log.d("Fetch result", "$res")
                }

                override fun onFetchFailed(code: Long, message: String) {
                    onFetchFailed(code, message)
                }
            },
        )
    }

    private fun fetchNFTsByCreatorAddresses(call: MethodCall) {
        val creators = call.argument<List<String>>("creators") ?: listOf()
        val limit = call.argument<Int>("limit") ?: 0
        val offset = call.argument<Int>("offset") ?: 0

        MirrorWorld.fetchNFTsByCreatorAddresses(
            creators,
            limit,
            offset,
            object : FetchNFTsListener {
                override fun onFetchSuccess(res: MultipleNFTsResponse) {
                    Log.d("Fetch result", "$res")
                }

                override fun onFetchFailed(code: Long, message: String) {
                    onFetchFailed(code, message)
                }
            },
        )

    }

    private fun fetchNFTsByUpdateAuthorities(call: MethodCall) {
        val updateAuthorities = call.argument<List<String>>("update_authorities") ?: listOf()
        val limit = call.argument<Int>("limit") ?: 0
        val offset = call.argument<Int>("offset") ?: 0

        MirrorWorld.fetchNFTsByUpdateAuthorities(
            updateAuthorities,
            limit,
            offset,
            object : FetchNFTsListener {
                override fun onFetchSuccess(res: MultipleNFTsResponse) {
                    Log.d("Fetch result", "$res")
                }

                override fun onFetchFailed(code: Long, message: String) {
                    onFetchFailed(code, message)
                }
            },
        )
    }


    private fun fetchNFTsByOwnerAddresses(call: MethodCall) {
        val owners = call.argument<List<String>>("owners") ?: listOf()
        val limit = call.argument<Int>("limit") ?: 0
        val offset = call.argument<Int>("offset") ?: 0

        MirrorWorld.fetchNFTsByOwnerAddresses(
            owners, limit, offset,
            object : FetchByOwnerListener {
                override fun onFetchSuccess(res: MultipleNFTsResponse) {
                    Log.d("Fetch result", "$res")
                }

                override fun onFetchFailed(code: Long, message: String) {
                    onFetchFailed(code, message)
                }
            },
        )
    }

    private fun fetchNFTMarketplaceActivity(call: MethodCall) {
        val mintAddress = call.argument<String>("mint_address") ?: ""
        MirrorWorld.fetchNFTMarketplaceActivity(
            mintAddress,
            object : FetchSingleNFTActivityListener {
                override fun onFetchSuccess(res: ActivityOfSingleNftResponse) {
                    Log.d("Fetch result", "$res")
                }

                override fun onFetchFailed(code: Long, message: String) {
                    onFetchFailed(code, message)
                }
            },
        )
    }

    private fun getCollectionFilterInfo(call: MethodCall) {
        val collection = call.argument<String>("collection") ?: ""
        MirrorMarket.getCollectionFilterInfo(
            collection,
            object : GetCollectionFilterInfoListener {
                override fun onSuccess(res: GetCollectionFilterInfoRes) {
                    events?.success(
                        EventsHelper.mapEvent(
                            name = EventsHelper.getCollectionFilterInfo,
                            data = EventsHelper.toMap(res)
                        )
                    )
                }

                override fun onFail(code: Long, message: String) {
                    onFetchFailed(code, message)
                }
            },
        )
    }


    private fun getNFTInfo(call: MethodCall, res: MethodChannel.Result) {
        val mintAddress = call.argument<String>("mint_address") ?: ""

        MirrorMarket.getNFTInfo(
            mintAddress
        ) { result ->
            res.success(
                EventsHelper.mapEvent(
                    name = EventsHelper.getNFTInfo, data = EventsHelper.toMap(result)
                )
            )
        }
    }


    private fun getCollectionInfo(call: MethodCall) {
        val collections = call.argument<List<String>>("collections") ?: listOf()

        MirrorMarket.getCollectionInfo(
            collections,
            object : GetCollectionInfoListener {
                override fun onSuccess(res: List<GetCollectionInfoRes>) {
                    events?.success(
                        EventsHelper.mapEvent(
                            name = EventsHelper.getCollectionInfo, data = EventsHelper.toMap(res)
                        )
                    )
                }

                override fun onFail(code: Long, message: String) {
                    onFetchFailed(code, message)
                }
            },
        )
    }


    private fun getNFTEvents(call: MethodCall) {
        val mintAddress = call.argument<String>("mint_address") ?: ""
        val page = call.argument<Int>("page") ?: 1
        val pageSize = call.argument<Int>("page_size") ?: 10

        MirrorMarket.getNFTEvents(
            mintAddress, page, pageSize,
            object : GetNFTEventsListener {
                override fun onSuccess(res: GetNFTEventsRes) {
                    events?.success(
                        EventsHelper.mapEvent(
                            name = EventsHelper.getNFTEvents, data = EventsHelper.toMap(res)
                        )
                    )
                }

                override fun onFail(code: Long, message: String) {
                    onFetchFailed(code, message)
                }
            },
        )
    }


    private fun searchNFTs(call: MethodCall) {
        val collections = call.argument<List<String>>("collections") ?: listOf()
        val searchString = call.argument<String>("search_string") ?: ""

        MirrorMarket.searchNFTs(
            collections, searchString,
            object : SearchNFTsListener {
                override fun onSuccess(res: List<MirrorMarketSearchNFTObj>) {
                    events?.success(
                        EventsHelper.mapEvent(
                            name = EventsHelper.searchNFTs, data = EventsHelper.toMap(res)
                        )
                    )
                }

                override fun onFail(code: Long, message: String) {
                    onFetchFailed(code, message)
                }
            },
        )
    }


    private fun getNFTRealPrice(call: MethodCall) {
        val price = call.argument<String>("price") ?: ""
        val fee = call.argument<Int>("price") ?: 0

        MirrorMarket.getNFTRealPrice(price, fee, object : GetNFTRealPriceListener {
            override fun onSuccess(res: GetNFTRealPriceRes) {
                events?.success(
                    EventsHelper.mapEvent(
                        name = EventsHelper.getNFTRealPrice, data = EventsHelper.toMap(res)
                    )
                )
            }

            override fun onFail(code: Long, message: String) {
                onFetchFailed(code, message)
            }
        })
    }


    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        this.events = events
    }

    override fun onCancel(arguments: Any?) {
    }

    override fun onLoginSuccess() {
        Log.i(logTag, "User login success!")
        events?.success(
            EventsHelper.mapEvent(
                name = EventsHelper.loginEvent,
                data = true,
            )
        )
    }

    override fun onLoginFail() {
        events?.error(logTag, "User login failed!", "")
    }

    override fun onBool(boolValue: Boolean) {
        isLoggedIn = boolValue
    }

    override fun onUserFetched(user: UserResponse) {
        events?.success(
            EventsHelper.mapEvent(
                name = EventsHelper.userFetched, data = EventsHelper.toMap(user)
            )
        )
    }

    override fun onFetchFailed(code: Long, message: String?) {
        events?.success(
            EventsHelper.mapEvent(
                name = EventsHelper.fetchFailed,
                data = mapOf(
                    "code" to code,
                    "message" to message,
                ),
            )
        )
    }

}

@Suppress("INACCESSIBLE_TYPE")
internal class EventsHelper {
    companion object {
        const val openWalletEvent: String = "OPEN_WALLET_EVENT"
        const val userFetched: String = "USER_FETCHED"
        const val fetchFailed: String = "FETCH_FAILED"
        const val getTokens: String = "GET_TOKENS"
        const val getTransactions: String = "GET_TRANSACTIONS"
        const val getTransaction: String = "GET_TRANSACTION"
        const val loginEvent: String = "LOGIN_EVENT"
        const val getNFTDetails: String = "NFT_DETAILS"
        const val getNFTsOwnedByAddress: String = "NFTs_OWNED_BY_ADDRESS"
        const val getCollectionFilterInfo: String = "GET_COLLECTION_FILTER_INFO"
        const val getCollectionInfo: String = "GET_COLLECTION_INFO"
        const val getNFTInfo: String = "GET_NFT_INFO"
        const val getNFTEvents: String = "GET_NFT_EVENTS"
        const val searchNFTs: String = "SEARCH_NFT"
        const val getNFTRealPrice: String = "GET_NFT_REAL_PRICE"

        fun mapEvent(name: String, data: Any?): Map<String, Any?> {
            return mapOf(
                "event" to name,
                "data" to data,
            )
        }

        fun toMap(res: Any?): Map<String, Any?> {

            return when (res) {
                null -> mapOf()
                is List<*> -> mapOf(
                    "data" to res.map {
                        MirrorGsonUtils.getInstance().toJsonObj(it).toMap()
                    },
                )
                else -> MirrorGsonUtils.getInstance().toJsonObj(res).toMap()
            }
        }
    }


}

fun JSONObject.toMap(): Map<String, *> = keys().asSequence().associateWith { it ->
    when (val value = this[it]) {
        is JSONArray -> {
            val map = (0 until value.length()).associate { Pair(it.toString(), value[it]) }
            JSONObject(map).toMap().values.toList()
        }
        is JSONObject -> value.toMap()
        JSONObject.NULL -> null
        else -> value
    }
}