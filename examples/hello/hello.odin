package main 

import qt "../.."

main :: proc() {
	qt.qguiapplication_create()
	defer qt.qguiapplication_quit()

	engine := qt.qqmlapplicationengine_create()
	defer qt.qqmlapplicationengine_delete(engine)

	qt.qqmlapplicationengine_load_data(engine, #load("hello.qml"))

	qt.qguiapplication_exec()
}
