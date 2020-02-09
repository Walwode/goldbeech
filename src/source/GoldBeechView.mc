using Toybox.Activity as Act;
using Toybox.Application as App;
using Toybox.Graphics as Gfx;
using Toybox.Lang;
using Toybox.System as Sys;
using Toybox.Time;
using Toybox.WatchUi as Ui;

class GoldBeechView extends Ui.WatchFace {

    hidden var active;
    hidden var logos;
    hidden var fonts = {};

    function initialize() {
        WatchFace.initialize();

    	logos = [
            Ui.loadResource(Rez.Drawables.WaltsWoodDesignWhite),
    	    Ui.loadResource(Rez.Drawables.CosmoConsultClaimColored),
    	    Ui.loadResource(Rez.Drawables.LaufszeneSachsenColored),
    	    Ui.loadResource(Rez.Drawables.Valentine)];

        fonts["TINY"] = Ui.loadResource(Rez.Fonts.SegoeUi12Bold);
        fonts["NORMAL"] = Ui.loadResource(Rez.Fonts.SegoeUi24Bold);
        fonts["LARGE"] = Ui.loadResource(Rez.Fonts.SegoeUi60Bold);
        fonts["LARGE-LIGHT"] = Ui.loadResource(Rez.Fonts.SegoeUi60);
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    // Update the view
    function onUpdate(dc) {

        // Clear the screen buffer
        dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_BLACK);
        dc.clear();

        drawLogo(dc);
        drawClock(dc);
        drawDate(dc);
        drawInfos(dc);
        drawSun(dc);

        // Call the parent onUpdate function to redraw the layout
        // View.onUpdate(dc);
    }

    function drawLogo(dc) {
        var logo = logos[App.getApp().getProperty("Logo")];
        dc.drawBitmap(
        	(dc.getWidth() / 2) - (logo.getWidth() / 2),
        	(dc.getHeight() / 2) - (logo.getHeight() / 2),
         	logo);
    }

    function drawClock(dc) {
        var clockTime = System.getClockTime();
        // clockTime.sec.format("%02d")

        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
        dc.drawText(
            dc.getWidth() / 2 - 1,
            -5,
            fonts["LARGE"],
            Lang.format("$1$", [clockTime.hour.format("%02d")]),
            Gfx.TEXT_JUSTIFY_RIGHT);
        dc.drawText(
            dc.getWidth() / 2 + 1,
            -5,
            fonts["LARGE-LIGHT"],
            Lang.format("$1$", [clockTime.min.format("%02d")]),
            Gfx.TEXT_JUSTIFY_LEFT);

        if (true) {
            dc.drawText(
                dc.getWidth() / 2 + 50,
                25,
                fonts["NORMAL"],
                Lang.format("$1$", [clockTime.sec.format("%02d")]),
                Gfx.TEXT_JUSTIFY_LEFT);
        }
    }

    function drawDate(dc) {
        var currentDateText = Time.Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
        var currentDate = Time.Gregorian.info(Time.now(), Time.FORMAT_SHORT);

		var dayInWeek = currentDateText.day_of_week.substring(0,2);
		var day = currentDateText.day.format("%02d");
		var month = currentDateText.month.substring(0,3);
		var weekInYear = CalendarCalc.getIsoWeekNumber(currentDate.year, currentDate.month, currentDate.day);

        dc.setColor(Gfx.COLOR_DK_GREEN, Gfx.COLOR_TRANSPARENT);
        dc.drawText(
            dc.getWidth()/2,
            dc.getHeight() - 30,
            fonts["NORMAL"],
            Lang.format("$1$ $2$ W$3$", [day, month, weekInYear]),
            Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER);
    }

    function drawInfos(dc) {
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
        dc.setPenWidth(3);
    	dc.drawLine(0, 138, ((Sys.getSystemStats().battery / 100) * dc.getWidth()), 138);
    	
        dc.setColor(Gfx.COLOR_LT_GRAY, Gfx.COLOR_TRANSPARENT);
        dc.drawText(
            dc.getWidth() / 4,
            dc.getHeight() - 30,
            fonts["TINY"],
            Lang.format("$1$%", [Sys.getSystemStats().battery.format("%02d")]),
            Gfx.TEXT_JUSTIFY_RIGHT | Gfx.TEXT_JUSTIFY_VCENTER);
        dc.drawText(
            3 * dc.getWidth() / 4,
            dc.getHeight() - 30,
            fonts["TINY"],
            Lang.format("#$1$", [Sys.getDeviceSettings().notificationCount.format("%02d")]),
            Gfx.TEXT_JUSTIFY_LEFT | Gfx.TEXT_JUSTIFY_VCENTER);
        dc.drawText(
            dc.getWidth() / 2,
            dc.getHeight() - 10,
            fonts["TINY"],
            Lang.format("$1$", [ActivityMonitor.getInfo().steps.format("%02d")]),
            Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER);
    }

    function drawSun(dc) {
        var currentLocation = [51.050407, 13.737262]; // Dresden
        var sunTime = SunCalc.calculateNextSunTime(currentLocation[0], currentLocation[1]);
        var h = Math.floor(sunTime);
        var m = Math.floor((sunTime - h) * 60);

        dc.drawText(
            dc.getWidth()/2,
            dc.getHeight() - 50,
            fonts["TINY"],
            // Gfx.FONT_SMALL,
            Lang.format("$1$:$2$", [h.format("%02d"), m.format("%02d")]),
            Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER);
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
		// settings = System.getDeviceSettings();
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
    	active = true;
    	Ui.requestUpdate();
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
    	active = false;
    	Ui.requestUpdate();
    }

}
