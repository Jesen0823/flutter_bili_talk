package com.jesen.flutter_bili_talk

import io.flutter.embedding.android.FlutterActivity
import android.graphics.Color
import android.os.Bundle;
import android.os.Build
import androidx.appcompat.app.AppCompatActivity
import android.view.Window

class MainActivity : FlutterActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            val window = activity.window
            //设置状态栏为透明色，fix启动时状态栏会灰色闪一下
            window.statusBarColor = Color.TRANSPARENT
        }
    }

}
