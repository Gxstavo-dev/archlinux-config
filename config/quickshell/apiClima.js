// archivo con las funciones para obtener y procesar datos del clima
// usa la api de open-meteo que es gratuita y no requiere api key

// funcion principal que hace la peticion a la api
// retorna datos actuales, pronostico por hora, y high/low del dia
function apiClima(callback) {
    var lat = 25.6866
    var lon = -100.3161

    // pedimos datos actuales + pronostico por hora para el dia completo
    var url = "https://api.open-meteo.com/v1/forecast?latitude=" + lat +
              "&longitude=" + lon +
              "&current=temperature_2m,weather_code" +
              "&hourly=temperature_2m,weather_code" +
              "&daily=temperature_2m_max,temperature_2m_min" +
              "&timezone=auto&forecast_days=1"

    var xhr = new XMLHttpRequest()
    xhr.onreadystatechange = function() {
        if (xhr.readyState === XMLHttpRequest.DONE) {
            if (xhr.status === 200) {
                var raw = JSON.parse(xhr.responseText)
                var data = procesarDatos(raw)
                callback(data)
            } else {
                console.error("error api clima: " + xhr.status)
            }
        }
    }
    xhr.open("GET", url)
    xhr.send()
}

// procesa los datos crudos de la api y los organiza para usarlos en el UI
function procesarDatos(raw) {
    var now = new Date()
    var horaActual = now.getHours()

    // datos actuales
    var tempActual = raw.current.temperature_2m
    var codeActual = raw.current.weather_code

    // conversion a fahrenheit
    var tempF = Math.round(tempActual * 9 / 5 + 32)

    // high y low del dia
    var high = Math.round(raw.daily.temperature_2m_max[0])
    var low = Math.round(raw.daily.temperature_2m_min[0])

    // pronostico por hora: tomamos 5 horas empezando desde la actual
    var pronostico = []
    for (var i = 0; i < 5; i++) {
        var idx = horaActual + i
        if (idx >= 24) idx = idx - 24

        var hora = raw.hourly.time[idx]
        var temp = Math.round(raw.hourly.temperature_2m[idx])
        var code = raw.hourly.weather_code[idx]

        // formateamos la hora: "now", "11 p.m.", etc.
        var label
        if (i === 0) {
            label = "Now"
        } else {
            var h = idx
            var ampm = h >= 12 ? "p.m." : "a.m."
            h = h % 12
            if (h === 0) h = 12
            label = h + " " + ampm
        }

        pronostico.push({
            hora: label,
            temp: temp + "°",
            icono: getIconoClima(code)
        })
    }

    return {
        temperatura: tempActual,
        tempF: tempF,
        code: codeActual,
        high: high,
        low: low,
        pronostico: pronostico
    }
}

// convierte el codigo wmo a descripcion en espanol
function getDescripcionClima(code) {
    var descripciones = {
        0: "despejado",
        1: "mayormente despejado",
        2: "parcialmente nublado",
        3: "nublado",
        45: "neblina",
        48: "neblina con escarcha",
        51: "llovizna ligera",
        53: "llovizna moderada",
        55: "llovizna intensa",
        61: "lluvia ligera",
        63: "lluvia moderada",
        65: "lluvia intensa",
        71: "nevada ligera",
        73: "nevada moderada",
        75: "nevada intensa",
        80: "chubascos ligeros",
        81: "chubascos moderados",
        82: "chubascos intensos",
        95: "tormenta",
        96: "tormenta con granizo",
        99: "tormenta con granizo intenso"
    }
    return descripciones[code] || "desconocido"
}

// retorna la ruta del svg flat/line-art segun el codigo del clima
function getIconoClima(code) {
    if (code === 0) return "./svgs/sunny.svg"
    if (code <= 3) return "./svgs/cloudy.svg"
    if (code === 45 || code === 48) return "./svgs/fog.svg"
    if (code >= 51 && code <= 55) return "./svgs/rain.svg"
    if (code >= 61 && code <= 65) return "./svgs/rain.svg"
    if (code >= 71 && code <= 75) return "./svgs/snow.svg"
    if (code >= 80 && code <= 82) return "./svgs/rain.svg"
    if (code >= 95) return "./svgs/storm.svg"
    return "./svgs/cloudy.svg"
}

// retorna el nombre corto del clima
function getNombreClima(code) {
    if (code === 0) return "soleado"
    if (code <= 3) return "nublado"
    if (code === 45 || code === 48) return "neblina"
    if (code >= 51 && code <= 55) return "llovizna"
    if (code >= 61 && code <= 65) return "lluvia"
    if (code >= 71 && code <= 75) return "nieve"
    if (code >= 80 && code <= 82) return "chubascos"
    if (code >= 95) return "tormenta"
    return "..."
}
