processRelativeTime = (number, withoutSuffix, key, isFuture) ->
  format =
    m: ["eine Minute", "einer Minute"]
    h: ["eine Stunde", "einer Stunde"]
    d: ["ein Tag", "einem Tag"]
    dd: [number + " Tage", number + " Tagen"]
    M: ["ein Monat", "einem Monat"]
    MM: [number + " Monate", number + " Monaten"]
    y: ["ein Jahr", "einem Jahr"]
    yy: [number + " Jahre", number + " Jahren"]

  (if withoutSuffix then format[key][0] else format[key][1])

moment.defineLocale "de",
  months: "Januar_Februar_März_April_Mai_Juni_Juli_August_September_Oktober_November_Dezember".split("_")
  monthsShort: "Jan._Febr._Mrz._Apr._Mai_Jun._Jul._Aug._Sept._Okt._Nov._Dez.".split("_")
  weekdays: "Sonntag_Montag_Dienstag_Mittwoch_Donnerstag_Freitag_Samstag".split("_")
  weekdaysShort: "So._Mo._Di._Mi._Do._Fr._Sa.".split("_")
  weekdaysMin: "So_Mo_Di_Mi_Do_Fr_Sa".split("_")
  longDateFormat:
    LT: "HH:mm"
    LTS: "HH:mm:ss"
    L: "DD.MM.YYYY"
    LL: "D. MMMM YYYY"
    LLL: "D. MMMM YYYY LT"
    LLLL: "dddd, D. MMMM YYYY LT"

  calendar:
    sameDay: "[Heute um] LT [Uhr]"
    sameElse: "L"
    nextDay: "[Morgen um] LT [Uhr]"
    nextWeek: "dddd [um] LT [Uhr]"
    lastDay: "[Gestern um] LT [Uhr]"
    lastWeek: "[letzten] dddd [um] LT [Uhr]"

  relativeTime:
    future: "in %s"
    past: "vor %s"
    s: "ein paar Sekunden"
    m: processRelativeTime
    mm: "%d Minuten"
    h: processRelativeTime
    hh: "%d Stunden"
    d: processRelativeTime
    dd: processRelativeTime
    M: processRelativeTime
    MM: processRelativeTime
    y: processRelativeTime
    yy: processRelativeTime

  ordinalParse: /\d{1,2}\./
  ordinal: "%d."
  week:
    dow: 1 # Monday is the first day of the week.
    doy: 4 # The week that contains Jan 4th is the first week of the year.


moment.locale('de')

Meteor.startup ->
  
  # Potentially prompts the user to enable location services. We do this early
  # on in order to have the most accurate location by the time the user shares
  Geolocation.currentLocation()