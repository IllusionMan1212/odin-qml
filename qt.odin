package qt

USE_QT5 :: #config(USE_QT5, false)

when ODIN_OS == .Linux {
foreign import qt_qml {
	// Qt5: Built against 5.15.13.
	// Qt6: Built against 6.9.1
	"libs/libDOtherSideStatic-qt5.a" when USE_QT5 else "libs/libDOtherSideStatic-qt6.a",
	"system:Qt5Core" when USE_QT5 else "system:Qt6Core",
	"system:stdc++",
	"system:Qt5Qml" when USE_QT5 else "system:Qt6Qml",
	"system:Qt5Quick" when USE_QT5 else "system:Qt6Quick",
	"system:Qt5Gui" when USE_QT5 else "system:Qt6Gui",
	"system:Qt5Widgets" when USE_QT5 else "system:Qt5Widgets",
}
} else when ODIN_OS == .Windows {
	// TODO:
} else when ODIN_OS == .Darwin {
	// TODO:
}

QEventLoopProcessEventFlag :: enum i32 {
    ProcessAllEvents = 0x00,
    ExcludeUserInputEvents = 0x01,
    ProcessExcludeSocketNotifiers = 0x02,
    ProcessAllEventsWaitForMoreEvents = 0x03
}

QQmlApplicationEngine :: struct{}
QUrl :: struct{}
QVariant :: struct{}
QQmlContext :: struct{}
QQuickImageProvider :: struct{}

@(link_prefix="dos_")
foreign qt_qml {
	/// \brief Return the QCore::applicationDirPath
	/// \return The QCore::applicationDirPath as a UTF-8 string
	/// \note The returned string should be deleted by the calling code by using
	/// the dos_chararray_delete() function
	qcoreapplication_application_dir_path :: proc() -> cstring ---
	/// \brief Force the event loop to spin and process the given events
	qcoreapplication_process_events :: proc(flags: QEventLoopProcessEventFlag) ---
	// /// \brief Force the event loop to spin and process the given events until no more available or timed out
	qcoreapplication_process_events_timed :: proc(flags: QEventLoopProcessEventFlag, ms: i32) ---
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
	qqmlapplicationengine_create :: proc() -> ^QQmlApplicationEngine ---

	/// \brief Calls the QQmlApplicationEngine::load function
	/// \param vptr The QQmlApplicationEngine
	/// \param filename The file to load. The file is relative to the directory that contains the application executable
	qqmlapplicationengine_load :: proc(vptr: ^QQmlApplicationEngine, filename: cstring) ---

	/// \brief Calls the QQmlApplicationEngine::load function
	/// \param vptr The QQmlApplicationEngine
	/// \param url The QUrl of the file to load
	qqmlapplicationengine_load_url :: proc(vptr: ^QQmlApplicationEngine, url: ^QUrl) ---

	/// \brief Calls the QQmlApplicationEngine::loadData function
	/// \param vptr The QQmlApplicationEngine
	/// \param data The UTF-8 string of the QML to load
	qqmlapplicationengine_load_data :: proc(vptr: ^QQmlApplicationEngine, data: cstring) ---

	/// \brief Calls the QQmlApplicationEngine::addImportPath function
	/// \param vptr The QQmlApplicationEngine
	/// \param path The path to be added to the list of import paths
	qqmlapplicationengine_add_import_path :: proc(vptr: ^QQmlApplicationEngine, path: cstring) ---

	/// \brief Calls the QQmlApplicationEngine::context
	/// \param vptr The QQmlApplicationEngine
	/// \return A pointer to a QQmlContext. This should not be stored nor made available to the binded language if
	/// you can't guarantee that this QQmlContext should not live more that its Engine. This context is owned by
	/// the engine and so it should die with the engine.
	qqmlapplicationengine_context :: proc(vptr: ^QQmlApplicationEngine) -> ^QQmlContext ---

	/// \brief Calls the QQMLApplicationengine::addImageProvider
	/// \param vptr The QQmlApplicationEngine
	/// \param vptr_i A QQuickImageProvider, the QQmlApplicationEngine takes ownership of this pointer
	qqmlapplicationengine_addImageProvider :: proc(vptr: ^QQmlApplicationEngine, name: cstring, vptr_i: ^QQuickImageProvider) ---

	/// \brief Free the memory allocated for the given QQmlApplicationEngine
	/// \param vptr The QQmlApplicationEngine
	qqmlapplicationengine_delete :: proc(vptr: ^QQmlApplicationEngine) ---

	/// \defgroup QQmlContext QQmlContext
	/// \brief Functions related to the QQmlContext class
	/// @{

	/// \brief Calls the QQmlContext::baseUrl function
	/// \return The QQmlContext url as an UTF-8 string
	/// \note The returned string should be freed using with the dos_chararray_delete() function
	qqmlcontext_baseUrl :: proc(vptr: ^QQmlContext) -> cstring ---

	/// \brief Sets a property inside the context
	/// \param vptr The DosQQmlContext
	/// \param name The property name. The string is owned by the caller thus it will not be deleted by the library
	/// \param value The property value. The DosQVariant is owned by the caller thus it will not be deleted by the library
	qqmlcontext_setcontextproperty :: proc(vptr: ^QQmlContext, name: cstring, value: ^QVariant) ---
}
