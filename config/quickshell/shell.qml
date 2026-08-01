// widget de clima estilo glassmorphism para quickshell
// fondo oscuro semi-transparente con efecto glass
import Quickshell
import Quickshell.Wayland
import QtQuick
// importamos el archivo js con las funciones del clima
import "apiClima.js" as Api


// componente raiz del shell, obligatorio en quickshell
ShellRoot {
    Variants {
        model: Quickshell.screens
    // panelwindow crea una ventana que se integra con el compositor wayland
        PanelWindow {
        screen: modelData
        // la capa background hace que el panel quede detras de todas las ventanas
        WlrLayershell.layer: WlrLayer.Background
        // namespace es un identificador para que el compositor sepa que es este panel
        WlrLayershell.namespace: "clima"

        // anclamos el panel a la esquina superior izquierda de la pantalla
        anchors {
            top: true
            left: true
        }

        // dimensiones del panel
        implicitHeight: 150
        implicitWidth: 300
        // color transparente para que se vea el rectangle con opacidad
        color: "transparent"

        // margenes para separar el panel de los bordes de la pantalla
        margins {
            top: 20
            left: 20
        }

        // rectangle principal con estilo glassmorphism
        Rectangle {
            id: root
            implicitWidth: 300
            implicitHeight: 150
            // redondeamos todas las esquinas
            radius: 16
            color: Qt.rgba(0, 0, 0, 0.5)

            // propiedades reactivas que se actualizan cuando llegan datos de la api
            // estas propiedades estan vinculadas a los text y image del ui
            property real temperatura: 0
            property int tempF: 0
            property int high: 0
            property int low: 0
            property string nombreClima: "..."
            property string icono: "./svgs/cloudy.svg"
            // array con el pronostico por hora (5 horas)
            property var pronostico: []

            // funcion que hace la peticion http a la api de open-meteo
            // y actualiza todas las propiedades con los datos recibidos
            function cargarClima() {
                // llamamos a la funcion del archivo js pasandole un callback
                Api.apiClima(function(data) {
                    // asignamos cada dato a su propiedad correspondiente
                    root.temperatura = data.temperatura
                    root.tempF = data.tempF
                    root.high = data.high
                    root.low = data.low
                    root.code = data.code
                    // obtenemos el ruta del svg segun el codigo del clima
                    root.icono = Api.getIconoClima(data.code)
                    // obtenemos el nombre del clima por ejemplo "nublado"
                    root.nombreClima = Api.getNombreClima(data.code)
                    // guardamos el pronostico por hora para el repeater
                    root.pronostico = data.pronostico
                })
            }

            // cuando el componente se carga por primera vez, pedimos el clima
            Component.onCompleted: cargarClima()

            // header estilo codigo: const location = "monterrey"
            // usa rich text para poner colores diferentes a cada palabra
            Text {
                id: header
                anchors {
                    top: parent.top
                    left: parent.left
                    topMargin: 14
                    leftMargin: 16
                }
                // const = verde, location = morado, = = blanco, "monterrey" = azul
                text: '<span style="color:#7ee787">const</span> <span style="color:#d2a8ff">location</span> <span style="color:#f0f0f0">=</span> <span style="color:#a5d6ff">"Monterrey"</span>'
                textFormat: Text.RichText
                font {
                    // usamos fuente monoespaciada para que se vea como codigo
                    family: "JetBrains Mono, Fira Code, monospace"
                    pixelSize: 11
                }
            }

            // boton de recarga en la esquina superior derecha
            // circulo pequeno semi-transparente con icono de reload
            Rectangle {
                id: botonReload
                width: 24
                height: 24
                radius: 12
                // cambia de opacidad cuando el mouse esta encima
                color: mouseArea.containsMouse
                       ? Qt.rgba(1, 1, 1, 0.2)
                       : Qt.rgba(1, 1, 1, 0.1)

                anchors {
                    top: parent.top
                    right: parent.right
                    topMargin: 12
                    rightMargin: 14
                }

                // icono de recarga line-art en blanco
                Image {
                    id: reloadIcon
                    anchors.fill: parent
                    source: "./svgs/reload.svg"
                    sourceSize.width: 24
                    sourceSize.height: 24

                    // animacion de un giro de 360 grados al hacer click
                    RotationAnimation {
                        id: giro
                        target: reloadIcon
                        from: 0
                        to: 360
                        duration: 500
                        easing.type: Easing.InOutQuad
                    }
                }

                // area de clickeo que activa la animacion y recarga los datos
                MouseArea {
                    id: mouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        // reinicia la animacion del giro
                        giro.restart()
                        // vuelve a pedir los datos a la api
                        root.cargarClima()
                    }
                }
            }

            // bloque principal: temperatura + icono + high/low
            // row organiza los elementos en fila horizontal
            Row {
                anchors {
                    top: header.bottom
                    left: parent.left
                    right: parent.right
                    topMargin: 10
                    leftMargin: 16
                    rightMargin: 14
                }
                height: 100

                // columna izquierda: temperatura en grande
                Column {
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 4

                    // fila con la temperatura grande y el simbolo de grados pequeno
                    Row {
                        // numero de temperatura grande y bold
                        Text {
                            text: Math.round(root.temperatura)
                            color: "#f0f0f0"
                            font {
                                pixelSize: 52
                                weight: Font.bold
                            }
                        }
                        // simbolo de grados celsius pequeno y gris
                        Text {
                            text: "°C"
                            color: "#9a9a9a"
                            font.pixelSize: 16
                            // alineado arriba a la derecha del numero
                            anchors.top: parent.top
                            anchors.topMargin: 4
                        }
                    }

                    // texto con fahrenheit y condicion climatica
                    Text {
                        text: root.tempF + "°F    " + root.nombreClima
                        color: "#8a8a8a"
                        font.pixelSize: 13
                    }
                }

                // columna derecha: icono del clima + high/low
                Column {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    spacing: 8

                    // imagen svg flat/line-art del clima actual
                    Image {
                        source: root.icono
                        sourceSize.width: 48
                        sourceSize.height: 48
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    // fila con la temperatura maxima y minima del dia
                    // h = high (maxima) en rojo, l = low (minima) en azul
                    Row {
                        spacing: 8
                        anchors.horizontalCenter: parent.horizontalCenter

                        Text {
                            text: "H:" + root.high + "°"
                            color: "#ff7b72"
                            font.pixelSize: 11
                        }
                        Text {
                            text: "L:" + root.low + "°"
                            color: "#79c0ff"
                            font.pixelSize: 11
                        }
                    }
                }
            }

            // separador visual sutil entre el bloque principal y el pronostico
            Rectangle {
                anchors {
                    top: header.bottom
                    left: parent.left
                    right: parent.right
                    topMargin: 118
                    leftMargin: 14
                    rightMargin: 14
                }
                height: 1
                // linea blanca casi invisible
                color: Qt.rgba(1, 1, 1, 0.08)
            }

            // fila de pronostico por hora en la parte inferior
            // muestra 5 columnas: ahora y las siguientes 4 horas
            Row {
                anchors {
                    top: header.bottom
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                    topMargin: 128
                    leftMargin: 10
                    rightMargin: 10
                    bottomMargin: 14
                }

                // repeater crea una columna por cada elemento del array pronostico
                Repeater {
                    model: root.pronostico

                    // cada columna tiene: hora, icono pequeno, y temperatura
                    Column {
                        width: 52
                        anchors.verticalCenter: parent.verticalCenter
                        spacing: 4

                        // hora: "now", "11 p.m.", etc.
                        Text {
                            text: modelData.hora
                            // la primera columna (now) se ve mas brillante que las demas
                            color: index === 0 ? "#f0f0f0" : "#6a6a6a"
                            font.pixelSize: 10
                            anchors.horizontalCenter: parent.horizontalCenter
                        }

                        // icono svg pequeno del clima para esa hora
                        Image {
                            source: modelData.icono
                            sourceSize.width: 20
                            sourceSize.height: 20
                            anchors.horizontalCenter: parent.horizontalCenter
                        }

                        // temperatura de esa hora en grados
                        Text {
                            text: modelData.temp
                            // la primera columna se ve mas brillante
                            color: index === 0 ? "#f0f0f0" : "#9a9a9a"
                            font {
                                pixelSize: 13
                                weight: Font.bold
                            }
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }
                }
            }
        }
    }
    }
}
