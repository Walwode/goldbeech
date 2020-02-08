using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang;
using Toybox.Application as App;
using Toybox.Time;

class GoldBeechView extends Ui.WatchFace {

    hidden var active;
    hidden var bitmapWaltsWoodDesign;
    hidden var bitmapCosmoConsult;
    hidden var settings;

    function initialize() {
        WatchFace.initialize();

    	bitmapWaltsWoodDesign = Ui.loadResource(Rez.Drawables.WaltsWoodDesignWhite);
    	bitmapCosmoConsult = Ui.loadResource(Rez.Drawables.CosmoConsultClaimColored);
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

        // Call the parent onUpdate function to redraw the layout
        // View.onUpdate(dc);
    }

    function drawLogo(dc) {
        dc.drawBitmap(
        	(dc.getWidth()/2)-(bitmapWaltsWoodDesign.getWidth()/2),
        	(dc.getHeight()/2)-(bitmapWaltsWoodDesign.getHeight()/2),
         	bitmapWaltsWoodDesign);
        // dc.drawBitmap(
        // 	(dc.getWidth()/2)-(bitmapCosmoConsult.getWidth()/2) + 2,
        // 	(dc.getHeight()/2)-(bitmapCosmoConsult.getHeight()/2),
        // 	bitmapCosmoConsult);
    }

    function drawClock(dc) {
        var clockTime = System.getClockTime();

        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
        dc.drawText(
            dc.getWidth()/2,
            0,
            Gfx.FONT_NUMBER_MEDIUM,
            Lang.format("$1$:$2$", [clockTime.hour.format("%02d"), clockTime.min.format("%02d")]),
            Gfx.TEXT_JUSTIFY_CENTER);
    }

    function drawDate(dc) {
        var currentDate = Time.Gregorian.info(Time.now(), Time.FORMAT_LONG);

        dc.setColor(Gfx.COLOR_DK_GREEN, Gfx.COLOR_TRANSPARENT);
        dc.drawText(
            dc.getWidth()/2,
            dc.getHeight() - 30,
            Gfx.FONT_MEDIUM,
            Lang.format("$1$ $2$ $3$", [currentDate.day_of_week.substring(0,2), currentDate.day.format("%02d"), currentDate.month.substring(0,3)]),
            Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER);
    }

    function drawInfos(dc) {
        dc.setColor(Gfx.COLOR_LT_GRAY, Gfx.COLOR_TRANSPARENT);
        dc.drawText(
            dc.getWidth()/6,
            dc.getHeight() - 30,
            Gfx.FONT_SMALL,
            Lang.format("$1$%", [Sys.getSystemStats().battery.format("%02d")]),
            Gfx.TEXT_JUSTIFY_LEFT | Gfx.TEXT_JUSTIFY_VCENTER);
        dc.drawText(
            5 * dc.getWidth()/6,
            dc.getHeight() - 30,
            Gfx.FONT_SMALL,
            Lang.format("$1$", [Sys.getDeviceSettings().notificationCount]),
            Gfx.TEXT_JUSTIFY_RIGHT | Gfx.TEXT_JUSTIFY_VCENTER);
        dc.drawText(
            dc.getWidth()/2,
            dc.getHeight() - 10,
            Gfx.FONT_SMALL,
            Lang.format("$1$", [ActivityMonitor.getInfo().steps.format("%02d")]),
            Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER);
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
		settings = System.getDeviceSettings();
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
