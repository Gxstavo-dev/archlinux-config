import app from "ags/gtk4/app"
import { Astal, Gtk, Gdk } from "ags/gtk4"

export default function Bar(gdkmonitor: Gdk.Monitor) {
  const { TOP, LEFT } = Astal.WindowAnchor

  return (
    <window
      visible
      name="bar"
      class="Bar"
      gdkmonitor={gdkmonitor}
      exclusivity={Astal.Exclusivity.IGNORE}
      anchor={TOP | LEFT}
      marginTop={20}
      marginLeft={20}
      widthRequest={200}
      heightRequest={200}
      application={app}
      $={(self) => {
        self.layer = Astal.Layer.BOTTOM
      }}
    >
      <box cssName="centerbox" hexpand vexpand>
        <label label="Mi widget" />
      </box>
    </window>
  )
}
