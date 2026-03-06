package com.example.actual_phone_state

import android.Manifest
import android.content.Context
import android.content.pm.PackageManager
import android.telecom.TelecomManager
import android.telephony.TelephonyManager
import androidx.core.content.ContextCompat
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class ActualPhoneStatePlugin : FlutterPlugin, MethodChannel.MethodCallHandler {

    private lateinit var channel: MethodChannel
    private lateinit var context: Context

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        context = binding.applicationContext
        channel = MethodChannel(binding.binaryMessenger, "actual_phone_state")
        channel.setMethodCallHandler(this)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "getPhoneState" -> result.success(getPhoneState())
            else -> result.notImplemented()
        }
    }

    private fun getPhoneState(): String {
        val permissionGranted = ContextCompat.checkSelfPermission(
            context,
            Manifest.permission.READ_PHONE_STATE
        ) == PackageManager.PERMISSION_GRANTED

        if (!permissionGranted) {
            return "unknown"
        }

        try {
            val telecomManager =
                context.getSystemService(Context.TELECOM_SERVICE) as TelecomManager

            if (telecomManager.isInCall) {
                return "callActive"
            }
        } catch (_: Exception) {
        }

        return try {
            val telephonyManager =
                context.getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager

            when (telephonyManager.callState) {
                TelephonyManager.CALL_STATE_RINGING,
                TelephonyManager.CALL_STATE_OFFHOOK -> "callActive"
                TelephonyManager.CALL_STATE_IDLE -> "noCall"
                else -> "unknown"
            }
        } catch (_: Exception) {
            "unknown"
        }
    }
}