package com.mirrorworld.universe

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

/** MirrorWorldUniversePlugin */
class MirrorWorldUniversePlugin: FlutterPlugin, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private val channelId = "mirror_world_universe"
  private val eventChannelId = "mirror_world_universe/event"
  private lateinit var eventChannel: EventChannel
  private var handler: MethodCallHandlerImpl? = null

  override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(binding.binaryMessenger, channelId)
    eventChannel = EventChannel(binding.binaryMessenger, eventChannelId)
    handler = MethodCallHandlerImpl(binding.applicationContext, null, eventChannel, channel)
    channel.setMethodCallHandler(handler)
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
    handler = null
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    handler?.setActivity(binding.activity)
  }

  override fun onDetachedFromActivityForConfigChanges() {
    handler?.setActivity(null)
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    onAttachedToActivity(binding)
  }

  override fun onDetachedFromActivity() {
    ///
  }
}
