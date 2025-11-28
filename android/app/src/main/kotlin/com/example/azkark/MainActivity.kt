package com.example.azkark

import android.app.AlarmManager
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.provider.Settings
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
	private val CHANNEL = "azkark/exact_alarm"

	override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
		super.configureFlutterEngine(flutterEngine)

		MethodChannel(
			flutterEngine.dartExecutor.binaryMessenger,
			CHANNEL
		).setMethodCallHandler { call, result ->
			when (call.method) {
				"ensureExactAlarmsAllowed" -> {
					if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
						val am = getSystemService(Context.ALARM_SERVICE) as AlarmManager
						if (am.canScheduleExactAlarms()) {
							result.success(true)
						} else {
							try {
								val intent = Intent(Settings.ACTION_REQUEST_SCHEDULE_EXACT_ALARM)
								intent.data = Uri.parse("package:${packageName}")
								intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
								startActivity(intent)
								result.success(false)
							} catch (e: Exception) {
								result.error("intent_error", e.message, null)
							}
						}
					} else {
						// On older Android versions exact alarms don't require special consent
						result.success(true)
					}
				}
				else -> result.notImplemented()
			}
		}
	}
}
