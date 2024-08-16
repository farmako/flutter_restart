package app.farmako.restart_example

import android.content.Context
import app.farmako.restart.RestartPlugin
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
    override fun provideFlutterEngine(context: Context) = RestartPlugin.provideFlutterEngine()
}
