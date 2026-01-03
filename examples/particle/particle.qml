import QtQuick
import QtQuick.Controls
import QtQuick.Particles
// Use this if you actually need effects:
// import QtQuick.Effects 

ApplicationWindow {
    id: app
    width: 640
    height: 480
    color: "lightgray"
    visible: true

    Rectangle {
        id: rect
        anchors.fill: parent // Better than hardcoding width/height
        visible: true

        gradient: Gradient {
            GradientStop { position: 0.0; color: "#3a2c32" }
            GradientStop { position: 0.8; color: "#875864" }
            GradientStop { position: 1.0; color: "#9b616c" }
        }

        Text {
            id: demoText
            text: "Odin Particle System Demo"
            color: "white"
            font.bold: true
            font.pointSize: 20
            
            // Replaced Component.onCompleted with Anchors for cleaner Qt6 code
            anchors.centerIn: parent

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                drag.target: parent
                // Ensure 'ctrl' is defined in your C++ context or elsewhere
                onReleased: if (typeof ctrl !== "undefined") ctrl.textReleased(parent)
            }
        }

        ParticleSystem { id: sys }

        ImageParticle {
            system: sys
            source: "particle.png"
            color: "white"
            colorVariation: 1.0
            alpha: 0.1
        }

        // Changed 'property var' to 'property Component' for better type safety
        property Component emitterComponent: Component {
            id: innerEmitterComp
            
            Emitter {
                id: container
                system: sys
                emitRate: 128
                lifeSpan: 600
                size: 24
                endSize: 8

                // Nested Emitter
                Emitter {
                    system: sys
                    emitRate: 128
                    lifeSpan: 600
                    size: 16
                    endSize: 8
                    velocity: AngleDirection { angleVariation: 360; magnitude: 60 }
                }

                property int life: 2600
                property real targetX: 0
                property real targetY: 0

                NumberAnimation on x {
                    id: xAnim
                    to: container.targetX
                    duration: container.life
                    running: true // Changed to true if you want it to move immediately on creation
                }
                NumberAnimation on y {
                    id: yAnim
                    to: container.targetY
                    duration: container.life
                    running: true
                }
                
                Timer {
                    interval: container.life
                    running: true
                    // onTriggered: if (typeof ctrl !== "undefined") ctrl.done(container)
                }
            }
        }
    }
}
