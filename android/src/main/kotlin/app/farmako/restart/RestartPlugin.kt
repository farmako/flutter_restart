package app.farmako.restart

import android.util.Log
import android.app.Activity
import io.flutter.embedding.engine.FlutterJNI
import io.flutter.embedding.engine.loader.FlutterLoader
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

class RestartPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    private val lock = Any()
    private var channel: MethodChannel? = null
    private var activity: Activity? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "in.farmako/restart")
        channel?.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        if (call.method == "restart") {
            result.success(restart())
        } else {
            result.notImplemented()
        }
    }

    private fun restart() = synchronized(lock) {

        // [FlutterActivity.recreate] is sufficient to restart the underlying Flutter engine.
        // The following logic exists to ensure that Shorebird loads the latest downloaded patch
        // after restart, without requiring a full termination & re-launch of the process.
        // References:
        // * https://github.com/shorebirdtech/engine/blob/d1af83d/shell/platform/android/flutter_main.cc#L71
        // * https://github.com/shorebirdtech/engine/blob/d1af83d/shell/platform/android/flutter_main.cc#L138
        // * https://github.com/shorebirdtech/engine/blob/d1af83d/shell/common/shorebird/shorebird.cc#L83
        // * https://github.com/shorebirdtech/engine/blob/d1af83d/shell/common/shorebird/shorebird.cc#L170

        val flutterJNI = FlutterJNI.Factory().provideFlutterJNI()

        runCatching {
            val loadLibraryCalledField = flutterJNI.javaClass.getDeclaredField("loadLibraryCalled")
            loadLibraryCalledField.isAccessible = true
            loadLibraryCalledField.setBoolean(flutterJNI, false)
        }.onFailure {
            Log.e(TAG, "Unable to reset loadLibraryCalled.", it)
        }
        runCatching {
            val initCalledField = flutterJNI.javaClass.getDeclaredField("initCalled")
            initCalledField.isAccessible = true
            initCalledField.setBoolean(flutterJNI, false)
        }.onFailure {
            Log.e(TAG, "Unable to reset initCalled.", it)
        }
        runCatching {
            val prefetchDefaultFontManagerCalledField = flutterJNI.javaClass.getDeclaredField("prefetchDefaultFontManagerCalled")
            prefetchDefaultFontManagerCalledField.isAccessible = true
            prefetchDefaultFontManagerCalledField.setBoolean(flutterJNI, false)
        }.onFailure {
            Log.e(TAG, "Unable to reset prefetchDefaultFontManagerCalled.", it)
        }

        runCatching {
            val flutterLoader = FlutterLoader(FlutterJNI.Factory().provideFlutterJNI())
            flutterLoader.startInitialization(activity!!.applicationContext)
            flutterLoader.ensureInitializationComplete(activity!!.applicationContext, null)
        }.onFailure {
            Log.e(TAG, "Unable to initialize the Flutter runtime.", it)
        }

        activity?.recreate()
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel?.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) = synchronized(lock) {
        activity = binding.activity
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) = synchronized(lock) {
        activity = binding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {}

    override fun onDetachedFromActivity() {}

    companion object {
        private const val TAG = "RestartPlugin"
    }
}
