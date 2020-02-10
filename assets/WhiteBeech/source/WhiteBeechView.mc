using Toybox.Activity as Act;
using Toybox.Application as App;
using Toybox.Graphics as Gfx;
using Toybox.Lang;
using Toybox.System as Sys;
using Toybox.Time;
using Toybox.WatchUi as Ui;

class WhiteBeechView extends Ui.WatchFace {

    hidden var active;
    hidden var logos;
    hidden var fonts = {};

    function initialize() {
        WatchFace.initialize();

    	logos = [
    	    Ui.loadResource(Rez.Drawables.Valentine)];

        fonts["TINY"] = Ui.loadResource(Rez.Fonts.SegoeUi24Bold);
        fonts["NORMAL"] = Ui.loadResource(Rez.Fonts.SegoeUi32Bold);
        fonts["LARGE"] = Ui.loadResource(Rez.Fonts.SegoeUi95Bold);
        fonts["LARGE-LIGHT"] = Ui.loadResource(Rez.Fonts.SegoeUi95);
    }

    function onUpdate(dc) {

        // Clear the screen buffer
        dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_BLACK);
        dc.clear();

        // var currentDate = Time.Gregorian.info(Time.now(), Time.FORMAT_SHORT);
        drawNormalFace(dc);
    }

    function drawNormalFace(dc) {

        var clockTime = System.getClockTime();

        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
        dc.drawText(
            dc.getWidth() / 2,
            dc.getHeight() / 2,
            fonts["LARGE"],
            Lang.format("$1$", [clockTime.hour.format("%02d")]),
            Gfx.TEXT_JUSTIFY_RIGHT | Gfx.TEXT_JUSTIFY_VCENTER);
        dc.setColor(Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT);
        dc.drawText(
            dc.getWidth() / 2,
            dc.getHeight() / 2,
            fonts["LARGE-LIGHT"],
            Lang.format("$1$", [clockTime.min.format("%02d")]),
            Gfx.TEXT_JUSTIFY_LEFT | Gfx.TEXT_JUSTIFY_VCENTER);

        if (active) {
	        dc.setColor(Gfx.COLOR_LT_GRAY, Gfx.COLOR_TRANSPARENT);
            dc.drawText(
                227,
                124,
                fonts["NORMAL"],
                Lang.format("$1$", [clockTime.sec.format("%02d")]),
                Gfx.TEXT_JUSTIFY_RIGHT);
        }

        var currentDateText = Time.Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
		var dayInWeek = currentDateText.day_of_week.substring(0,2);
		var day = currentDateText.day.format("%02d");
		var month = currentDateText.month.substring(0,3);
        dc.setColor(Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT);
        dc.drawText(
            dc.getWidth() / 2,
            3 * dc.getHeight() / 4,
            fonts["NORMAL"],
            Lang.format("$1$ $2$", [dayInWeek, day]),
            Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER);

        var currentLocation = [51.050407, 13.737262]; // Dresden
        var sunTime = SunCalc.calculateNextSunTime(currentLocation[0], currentLocation[1]);
        var h = Math.floor(sunTime);
        var m = Math.floor((sunTime - h) * 60);
        dc.setColor(Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT);
        dc.drawText(
            dc.getWidth() / 2,
            dc.getHeight() / 4,
            fonts["NORMAL"],
            Lang.format("$1$:$2$", [h.format("%02d"), m.format("%02d")]),
            Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER);

        dc.setColor(Gfx.COLOR_LT_GRAY, Gfx.COLOR_TRANSPARENT);
        dc.drawText(
            dc.getWidth() / 2,
            20,
            fonts["TINY"],
            Lang.format("$1$%", [Sys.getSystemStats().battery.format("%02d")]),
            Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER);

        dc.setColor(Gfx.COLOR_LT_GRAY, Gfx.COLOR_TRANSPARENT);
        dc.drawText(
            dc.getWidth() / 2,
            dc.getHeight() - 20,
            fonts["TINY"],
            Lang.format("$1$", [ActivityMonitor.getInfo().steps.format("%02d")]),
            Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER);
    }

    function drawValentineFace(dc) {
        dc.drawBitmap(
        	(dc.getWidth() / 2) - (logos[0].getWidth() / 2),
        	(2 * dc.getHeight() / 3) - (logos[0].getHeight() / 2),
         	logos[0]);
    }

    function onLayout(dc) {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    function onShow() {
    }

    function onHide() {
    }

    function onExitSleep() {
    	active = true;
    	Ui.requestUpdate();
    }

    function onEnterSleep() {
    	active = false;
    	Ui.requestUpdate();
    }
}
