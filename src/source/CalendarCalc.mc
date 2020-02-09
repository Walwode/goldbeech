module CalendarCalc {

    // Copied from https://forums.garmin.com/developer/connect-iq/f/discussion/2778/week-of-year

    function toJulianDay(year, month, day) {

        var a = (14 - month) / 12;
        var y = (year + 4800 - a);
        var m = (month + 12 * a - 3);
        return day + ((153 * m + 2) / 5) + (365 * y) + (y / 4) - (y / 100) + (y / 400) - 32045;
    }

    function isLeapYear(year) {

        if (year % 4 != 0) {
            return false;
        }
            else if (year % 100 != 0) {
            return true;
        }
            else if (year % 400 == 0) {
            return true;
        }
        return false;
    }

    function getIsoWeekNumber(year, month, day) {

        var first_day_of_year = toJulianDay(year, 1, 1);
        var given_day_of_year = toJulianDay(year, month, day);

        var day_of_week = (first_day_of_year + 3) % 7; // days past thursday
        var week_of_year = (given_day_of_year - first_day_of_year + day_of_week + 4) / 7;

        // week is at end of this year or the beginning of next year
        if (week_of_year == 53) {
            if (day_of_week == 6) {
                return week_of_year;
            }
                else if (day_of_week == 5 && isLeapYear(year)) {
                return week_of_year;
            }
            else {
                return 1;
            }
        }

        // week is in previous year, try again under that year
        else if (week_of_year == 0) {
            first_day_of_year = toJulianDay(year - 1, 1, 1);
            day_of_week = (first_day_of_year + 3) % 7;
            return (given_day_of_year - first_day_of_year + day_of_week + 4) / 7;
        }

        // any old week of the year
        else {
            return week_of_year;
        }
    }
}