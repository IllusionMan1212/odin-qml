package qt

when ODIN_OS == .Linux {
foreign import qt_qml {
	"libs/libDOtherSideStatic.a",
	"system:Qt5Qml",
	"system:Qt5Core",
	"system:Qt5Quick",
	"system:Qt5Gui",
	"system:Qt5Widgets",
	"system:stdc++",
}
} else when ODIN_OS == .Windows {
	// TODO:
} else when ODIN_OS == .Darwin {
	// TODO:
}

DosQQmlApplicationEngine :: struct{}
DosQUrl :: struct{}
DosQQmlContext :: struct{}
DosQQuickImageProvider :: struct{}

@(link_prefix="dos_")
foreign qt_qml {
	/// \brief Return the QCore::applicationDirPath
	/// \return The QCore::applicationDirPath as a UTF-8 string
	/// \note The returned string should be deleted by the calling code by using
	/// the dos_chararray_delete() function
	qcoreapplication_application_dir_path :: proc() -> cstring ---
	/// \brief Force the event loop to spin and process the given events
	// qcoreapplication_process_events :: proc(flags: DosQEventLoopProcessEventFlag) ---
	// /// \brief Force the event loop to spin and process the given events until no more available or timed out
	// qcoreapplication_process_events_timed :: proc(flags: DosQEventLoopProcessEventFlag, ms: i32) ---
	/// \brief Create a QGuiApplication
	/// \note The created QGuiApplication should be freed by calling dos_qguiapplication_delete()
	qguiapplication_create :: proc() ---
	/// \brief Calls the QGuiApplication::exec() function of the current QGuiApplication
	/// \note A QGuiApplication should have been already created through dos_qguiapplication_create()
	qguiapplication_exec :: proc() ---
	/// \brief Calls the QGuiApplication::quit() function of the current QGuiApplication
	/// \note A QGuiApplication should have been already created through dos_qguiapplication_create()
	qguiapplication_quit :: proc() ---
	/// \brief Free the memory of the current QGuiApplication
	/// \note A QGuiApplication should have been already created through dos_qguiapplication_create()
	qguiapplication_delete :: proc() ---

	/// \brief Create a QApplication
	/// \note The created QApplication should be freed by calling dos_qapplication_delete()
	qapplication_create :: proc() ---

	/// \brief Calls the QApplication::exec() function of the current QGuiApplication
	/// \note A QApplication should have been already created through dos_qapplication_create()
	qapplication_exec :: proc() ---

	/// \brief Calls the QApplication::quit() function of the current QGuiApplication
	/// \note A QApplication should have been already created through dos_qapplication_create()
	qapplication_quit :: proc() ---

	/// \brief Free the memory of the current QApplication
	/// \note A QApplication should have been already created through dos_qapplication_create()
	qapplication_delete :: proc() ---

	/// \brief Create a new QQmlApplicationEngine
	/// \return A new QQmlApplicationEngine
	/// \note The returned QQmlApplicationEngine should be freed by using dos_qqmlapplicationengine_delete(DosQQmlApplicationEngine*)
	qqmlapplicationengine_create :: proc() -> ^DosQQmlApplicationEngine ---

	/// \brief Calls the QQmlApplicationEngine::load function
	/// \param vptr The QQmlApplicationEngine
	/// \param filename The file to load. The file is relative to the directory that contains the application executable
	qqmlapplicationengine_load :: proc(vptr: ^DosQQmlApplicationEngine, filename: cstring) ---

	/// \brief Calls the QQmlApplicationEngine::load function
	/// \param vptr The QQmlApplicationEngine
	/// \param url The QUrl of the file to load
	qqmlapplicationengine_load_url :: proc(vptr: ^DosQQmlApplicationEngine, url: ^DosQUrl) ---

	/// \brief Calls the QQmlApplicationEngine::loadData function
	/// \param vptr The QQmlApplicationEngine
	/// \param data The UTF-8 string of the QML to load
	qqmlapplicationengine_load_data :: proc(vptr: ^DosQQmlApplicationEngine, data: cstring) ---

	/// \brief Calls the QQmlApplicationEngine::addImportPath function
	/// \param vptr The QQmlApplicationEngine
	/// \param path The path to be added to the list of import paths
	qqmlapplicationengine_add_import_path :: proc(vptr: ^DosQQmlApplicationEngine, path: cstring) ---

	/// \brief Calls the QQmlApplicationEngine::context
	/// \param vptr The QQmlApplicationEngine
	/// \return A pointer to a QQmlContext. This should not be stored nor made available to the binded language if
	/// you can't guarantee that this QQmlContext should not live more that its Engine. This context is owned by
	/// the engine and so it should die with the engine.
	qqmlapplicationengine_context :: proc(vptr: ^DosQQmlApplicationEngine) -> ^DosQQmlContext ---

	/// \brief Calls the QQMLApplicationengine::addImageProvider
	/// \param vptr The QQmlApplicationEngine
	/// \param vptr_i A QQuickImageProvider, the QQmlApplicationEngine takes ownership of this pointer
	qqmlapplicationengine_addImageProvider :: proc(vptr: ^DosQQmlApplicationEngine, name: cstring, vptr_i: ^DosQQuickImageProvider) ---

	/// \brief Free the memory allocated for the given QQmlApplicationEngine
	/// \param vptr The QQmlApplicationEngine
	qqmlapplicationengine_delete :: proc(vptr: ^DosQQmlApplicationEngine) ---
}
