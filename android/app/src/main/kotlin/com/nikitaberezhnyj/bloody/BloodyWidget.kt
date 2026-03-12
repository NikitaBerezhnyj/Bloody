package com.nikitaberezhnyj.bloody

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.view.View
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetPlugin

class BloodyWidget : AppWidgetProvider() {

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {

        for (widgetId in appWidgetIds) {

            val views = RemoteViews(context.packageName, R.layout.bloody_widget)

            val prefs = HomeWidgetPlugin.getData(context)

            val daysText = prefs.getString("widget_days_text", "") ?: ""
            val labelText = prefs.getString("widget_label_text", "Bloody") ?: "Bloody"
            val showIcon = prefs.getBoolean("widget_show_icon", false)

            views.setTextViewText(R.id.widget_days_text, daysText)
            views.setTextViewText(R.id.widget_label_text, labelText)

            if (showIcon) {
                views.setViewVisibility(R.id.widget_icon, View.VISIBLE)
                views.setViewVisibility(R.id.widget_days_text, View.GONE)
            } else {
                views.setViewVisibility(R.id.widget_icon, View.GONE)
                views.setViewVisibility(R.id.widget_days_text, View.VISIBLE)
            }

            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}