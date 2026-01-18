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



	/// \defgroup QQuickImageProvider QQuickImageProvider
	/// \brief Functions related to the QQuickImageProvider class
	/// @{

	/// \brief Create a new QQuickImageProvider
	/// \return A new QQuickImageProvider
	/// \note The returned QQuickImageProvider should be freed by using dos_qquickimageprovider_delete(DosQQuickImageProvider*) unless the QQuickImageProvider has been bound to a QQmlApplicationEngine
	qquickimageprovider_create :: proc(callback: RequestPixmapCallback) -> ^QQuickImageProvider ---
	/// \breif Frees a QQuickImageProvider
	qquickimageprovider_delete :: proc(vptr: ^QQuickImageProvider) ---
	/// @}



	/// \defgroup QPixmap QPixmap
	/// \brief Functions related to the QPixmap class
	/// @{

	/// \brief Creates a null QPixmap
	qpixmap_create :: proc() -> ^QPixmap ---
	/// \brief Creates a QPixmap copied from another
	qpixmap_create_qpixmap :: proc(other: ^QPixmap) -> ^QPixmap ---
	/// \brief Create a new QPixmap
	qpixmap_create_width_and_height :: proc(width: i32, height: i32) -> ^QPixmap ---
	/// \brief Frees a QPixmap
	qpixmap_delete :: proc(vptr: ^QPixmap) ---
	/// \brief Load image data into a QPixmap from an image file
	qpixmap_load :: proc(vptr: ^QPixmap, filepath: cstring, format: cstring) ---
	/// \brief Load image data into a QPixmap from a buffer
	qpixmap_loadFromData :: proc(vptr: ^QPixmap, data: [^]byte, len: u32) ---
	/// \brief Fill a QPixmap with a single color
	qpixmap_fill :: proc(vptr: ^QPixmap, r: u8, g: u8, b: u8, a: u8) ---
	/// \brief Calls the QPixmap::operator=(const QPixmap&) function
	/// \param vptr The left hand side QPixmap
	/// \param other The right hand side QPixmap
	qpixmap_assign :: proc(vptr: ^QPixmap, other: ^QPixmap) ---
	/// \brief Calls the QPixmap::isNull
	/// \return True if the QPixmap is null, false otherwise
	qpixmap_isNull :: proc(vptr: ^QPixmap) -> b32 ---
	/// @}


	/// \defgroup QQuickStyle QQuickStyle
	/// \brief Functions related to the QQuickStyle class
	/// @{

	/// \brief Set the QtQuickControls2 style
	qquickstyle_set_style :: proc(style: cstring) ---

	/// \brief Set the QtQuickControls2 fallback style
	qquickstyle_set_fallback_style :: proc(style: cstring) ---

	/// @}


	/// \defgroup QQuickView QQuickView
	/// \brief Functions related to the QQuickView class
	/// @{

	/// \brief Create a new QQuickView
	/// \return A new QQuickView
	/// \note The returned QQuickView should be freed by using dos_qquickview_delete(DosQQuickview*)
	qquickview_create :: proc() -> ^QQuickView ---

	/// \brief Calls the QQuickView::show() function
	/// \param vptr The QQuickView
	qquickview_show :: proc(vptr: ^QQuickView) ---

	/// \brief Calls the QQuickView::source() function
	/// \param vptr The QQuickView
	/// \return The QQuickView source as an UTF-8 string
	/// \note The returned string should be freed by using the dos_chararray_delete() function
	qquickview_source :: proc(vptr: ^QQuickView) -> cstring ---

	/// \brief Calls the QQuickView::setSource() function
	/// \param vptr The QQuickView
	/// \param url The source QUrl
	qquickview_set_source_url :: proc(vptr: ^QQuickView, url: ^QUrl) ---

	/// \brief Calls the QQuickView::setSource() function
	/// \param vptr The QQuickView
	/// \param filename The source path as an UTF-8 string. The path is relative to the directory
	///  that contains the application executable
	qquickview_set_source :: proc(vptr: ^QQuickView, filename: cstring) ---

	/// \brief Calls the QQuickView::setResizeMode() function
	/// \param vptr The QQuickView
	/// \param resizeMode The resize mode
	qquickview_set_resize_mode :: proc(vptr: ^QQuickView, resizeMode: i32) ---

	/// \brief Free the memory allocated for the given QQuickView
	/// \param vptr The QQuickView
	qquickview_delete :: proc(vptr: ^QQuickView) ---

	/// \brief Return the QQuickView::rootContext() as a QQuickContext
	/// \param vptr The QQuickView
	qquickview_rootContext :: proc(vptr: ^QQuickView) -> ^QQmlContext ---



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


	/// @}

	/// \defgroup String String
	/// \brief Functions related to strings
	/// @{

	/// \brief Free the memory allocated for the given UTF-8 string
	/// \param ptr The UTF-8 string to be freed
	chararray_delete :: proc(ptr: cstring) ---

	/// @}


	/// Delete a DosQVariantArray
	qvariantarray_delete :: proc(ptr: ^QVariantArray) ---

	/// \brief Create a new QVariant (null)
	/// \return The a new QVariant
	/// \note The returned QVariant should be freed using dos_qvariant_delete()
	qvariant_create :: proc() -> ^QVariant ---

	/// \brief Create a new QVariant holding an int value
	/// \return The a new QVariant
	/// \param value The int value
	/// \note The returned QVariant should be freed using dos_qvariant_delete()
	qvariant_create_int :: proc(value: i32) -> ^QVariant ---

	/// \brief Create a new QVariant holding a long long value
	/// \return The a new QVariant
	/// \param value The value
	/// \note The returned QVariant should be freed using dos_qvariant_delete()
	qvariant_create_longlong :: proc(value: i64) -> ^QVariant ---

	/// \brief Create a new QVariant holding an usigned long long value
	/// \return The a new QVariant
	/// \param value The value
	/// \note The returned QVariant should be freed using dos_qvariant_delete()
	qvariant_create_ulonglong :: proc(value: u64) -> ^QVariant ---

	/// \brief Create a new QVariant holding a bool value
	/// \return The a new QVariant
	/// \param value The bool value
	/// \note The returned QVariant should be freed using dos_qvariant_delete()
	qvariant_create_bool :: proc(value: b32) -> ^QVariant ---

	/// \brief Create a new QVariant holding a string value
	/// \return The a new QVariant
	/// \param value The string value
	/// \note The returned QVariant should be freed using dos_qvariant_delete()
	/// \note The given string is copied inside the QVariant and will not be deleted
	qvariant_create_string :: proc(value: cstring) -> ^QVariant ---

	/// \brief Create a new QVariant holding a QObject value
	/// \return The a new QVariant
	/// \param value The QObject value
	/// \note The returned QVariant should be freed using dos_qvariant_delete()
	qvariant_create_qobject :: proc(value: ^QObject) -> ^QVariant ---

	/// \brief Create a new QVariant with the same value of the one given as argument
	/// \return The a new QVariant
	/// \param value The QVariant to which copy its value
	/// \note The returned QVariant should be freed using dos_qvariant_delete()
	qvariant_create_qvariant :: proc(value: ^QVariant) -> ^QVariant ---

	/// \brief Create a new QVariant holding a float value
	/// \return The a new QVariant
	/// \param value The float value
	/// \note The returned QVariant should be freed using dos_qvariant_delete()
	qvariant_create_float :: proc(value: f32) -> ^QVariant ---

	/// \brief Create a new QVariant holding a double value
	/// \return The a new QVariant
	/// \param value The double value
	/// \note The returned QVariant should be freed using dos_qvariant_delete()
	qvariant_create_double :: proc(value: f64) -> ^QVariant ---

	/// \brief Create a new QVariant holding a QVariantList
	/// \return A new QVariant
	/// \param size The size of the QVariant array
	/// \param array The array of QVariant that will be inserted in the inner QVariantList
	/// \note The \p array is owned by the caller thus it will not be deleted
	qvariant_create_array :: proc(size: i32, array: [^]^QVariant) -> ^QVariant ---

	/// \brief Calls the QVariant::setValue<int>() function
	/// \param vptr The QVariant
	/// \param value The int value
	qvariant_setInt :: proc(vptr: ^QVariant, value: i32) ---

	/// \brief Calls the QVariant::setValue<long long>() function
	/// \param vptr The QVariant
	/// \param value The long long value
	qvariant_setLongLong :: proc(vptr: ^QVariant, value: i64) ---

	/// \brief Calls the QVariant::setValue<unsigned long long>() function
	/// \param vptr The QVariant
	/// \param value The unsigned long long value
	qvariant_setULongLong :: proc(vptr: ^QVariant, value: u64) ---

	/// \brief Calls the QVariant::setValue<bool>() function
	/// \param vptr The QVariant
	/// \param value The bool value
	qvariant_setBool :: proc(vptr: ^QVariant, value: b32) ---

	/// \brief Calls the QVariant::setValue<float>() function
	/// \param vptr The QVariant
	/// \param value The float value
	qvariant_setFloat :: proc(vptr: ^QVariant, value: f32) ---

	/// \brief Calls the QVariant::setValue<double>() function
	/// \param vptr The QVariant
	/// \param value The double value
	qvariant_setDouble :: proc(vptr: ^QVariant, value: f64) ---

	/// \brief Calls the QVariant::setValue<QString>() function
	/// \param vptr The QVariant
	/// \param value The string value
	/// \note The string argument is copied inside the QVariant and it will not be deleted
	qvariant_setString :: proc(vptr: ^QVariant, value: cstring) ---

	/// \brief Calls the QVariant::setValue<QObject*>() function
	/// \param vptr The QVariant
	/// \param value The string value
	/// \note The string argument is copied inside the QVariant and it will not be deleted
	qvariant_setQObject :: proc(vptr: ^QVariant, value: ^QObject) ---

	/// \brief Calls the QVariant::setValue<QVariantList>() function
	/// \param vptr The QVariant
	/// \param size The size of the \p array
	/// \param array The array of QVariant use for setting the inner QVariantList
	qvariant_setArray :: proc(vptr: ^QVariant, size: i32, array: [^]^QVariant) ---

	/// \brief Calls the QVariant::isNull function
	/// \return True if the QVariant is null, false otherwise
	/// \param vptr The QVariant
	qvariant_isnull :: proc(vptr: ^QVariant) -> b32 ---

	/// \brief Free the memory allocated for the given QVariant
	/// \param vptr The QVariant
	qvariant_delete :: proc(vptr: ^QVariant) ---

	/// \brief Calls the QVariant::operator=(const QVariant&) function
	/// \param vptr The QVariant (left side)
	/// \param other The QVariant (right side)
	qvariant_assign :: proc(vptr: ^QVariant, other: ^QVariant) ---

	/// \brief Calls the QVariant::value<int>() function
	/// \param vptr The QVariant
	/// \return The int value
	qvariant_toInt :: proc(vptr: ^QVariant) -> i32 ---

	/// \brief Calls the QVariant::value<long long>() function
	/// \param vptr The QVariant
	/// \return The int value
	qvariant_toLongLong :: proc(vptr: ^QVariant) -> i64 ---

	/// \brief Calls the QVariant::value<unsigned long long>() function
	/// \param vptr The QVariant
	/// \return The int value
	qvariant_toULongLong :: proc(vptr: ^QVariant) -> u64 ---

	/// \brief Calls the QVariant::value<bool>() function
	/// \param vptr The QVariant
	/// \return The bool value
	qvariant_toBool :: proc(vptr: ^QVariant) -> b32 ---

	/// \brief Calls the QVariant::value<QString>() function
	/// \param vptr The QVariant
	/// \return The string value
	/// \note The returned string should be freed by using dos_chararray_delete()
	qvariant_toString :: proc(vptr: ^QVariant) -> cstring ---

	/// \brief Calls the QVariant::value<float>() function
	/// \param vptr The QVariant
	/// \return The float value
	qvariant_toFloat :: proc(vptr: ^QVariant) -> f32 ---

	/// \brief Calls the QVariant::value<double>() function
	/// \param vptr The QVariant
	/// \return The double value
	qvariant_toDouble :: proc(vptr: ^QVariant) -> f64 ---

	/// \brief Calls the QVariant::value<QVariantList>() function
	/// \param vptr The QVariant
	/// \return The QVariantList value as an array
	qvariant_toArray :: proc(vptr: ^QVariant) -> ^QVariantArray ---

	/// \brief Calls the QVariant::value<QObject*>() function
	/// \param vptr The QVariant
	/// \return The QObject* value
	/// \note Storing the returned QObject* is higly dengerous and depends on how you managed the memory
	/// of QObjects in the binded language
	qvariant_toQObject :: proc(vptr: ^QVariant) -> ^QObject ---



	/// \brief Create a new QMetaObject
	/// \param superClassMetaObject The superclass metaobject
	/// \param className The class name
	/// \param signalDefinitions The SignalDefinitions
	/// \param slotDefinitions The SlotDefinitions struct
	/// \param propertyDefinitions The PropertyDefinitions struct
	/// \note The returned QMetaObject should be freed using dos_qmetaobject_delete().
	/// \attention The QMetaObject should live more than the QObject it refears to.
	/// Depending on the implementation usually the QMetaObject should be modeled as static variable
	/// So with a lifetime equals to the entire application
	qmetaobject_create :: proc(superClassMetaObject: ^QMetaObject,
                                                        className: cstring,
                                                        signalDefinitions: ^SignalDefinitions,
                                                        slotDefinitions: ^SlotDefinitions,
                                                        propertyDefinitions: ^PropertyDefinitions) -> ^QMetaObject ---

	/// \brief Free the memory allocated for the given QMetaObject
	/// \param vptr The QMetaObject
	qmetaobject_delete :: proc(vptr: ^QMetaObject) ---

	/// \brief Invoke a function with the given data
	/// \param callback The callback that will be called
	/// \param data The data passed to the callback
	/// \param connection_type The connection type
	qmetaobject_invoke_method :: proc(ctx: ^QObject,
										callback: QMetaObjectInvokeMethodCallback ,
										callbackData: rawptr,
										connection_type: QtConnectionType) -> b32 ---




	/// @}

	/// \defgroup QAbstractListModel QAbstractItemModel
	/// \brief Functions related to the QAbstractListModel class
	/// @{

	/// \brief Return QMetaObject associated to the QAbstractListModel class
	/// \return The QMetaObject of the QAbstractListModel class
	/// \note The returned QMetaObject should be freed using dos_qmetaobject_delete().
	qabstractlistmodel_qmetaobject :: proc() -> ^QMetaObject ---

	/// \brief Create a new QAbstractListModel
	/// \param callbackObject The pointer of QAbstractListModel in the binded language
	/// \param metaObject The QMetaObject for this QAbstractListModel
	/// \param dObjectCallback The callback for handling the properties read/write and slots execution
	/// \param callbacks The QAbstractItemModel callbacks
	qabstractlistmodel_create :: proc(callbackObject: rawptr,
									  metaObject: ^QMetaObject,
									  dObjectCallback: DObjectCallback,
									  callbacks: ^QAbstractItemModelCallbacks) -> ^QAbstractListModel ---

	/// \brief Calls the default QAbstractListModel::index() function
	qabstractlistmodel_index :: proc(vptr: ^QAbstractListModel,
										row: i32, column: i32, parent: ^QModelIndex) -> ^QModelIndex ---

	/// \brief Calls the default QAbstractListModel::parent() function
	qabstractlistmodel_parent :: proc(vptr: ^QAbstractListModel, child: ^QModelIndex) -> ^QModelIndex ---

	/// \brief Calls the default QAbstractListModel::columnCount() function
	qabstractlistmodel_columnCount :: proc(vptr: ^QAbstractListModel, parent: ^QModelIndex) -> i32 ---

	/// @}

	/// \defgroup QAbstractTableModel QAbstractTableModel
	/// \brief Functions related to the QAbstractTableModel class
	/// @{

	/// \brief Return QMetaObject associated to the QAbstractTableModel class
	/// \return The QMetaObject of the QAbstractTableModel class
	/// \note The returned QMetaObject should be freed using dos_qmetaobject_delete().
	qabstracttablemodel_qmetaobject :: proc() -> ^QMetaObject ---

	/// \brief Create a new QAbstractTableModel
	/// \param callbackObject The pointer of QAbstractTableModel in the binded language
	/// \param metaObject The QMetaObject for this QAbstractTableModel
	/// \param dObjectCallback The callback for handling the properties read/write and slots execution
	/// \param callbacks The QAbstractItemModel callbacks
	qabstracttablemodel_create :: proc(callbackObject: rawptr,
										metaObject: ^QMetaObject,
										dObjectCallback: DObjectCallback,
										callbacks: ^QAbstractItemModelCallbacks) -> ^QAbstractTableModel ---

	/// \brief Calls the default QAbstractTableModel::index() function
	qabstracttablemodel_index :: proc(vptr: ^QAbstractTableModel,
																   row: i32, column: i32, parent: ^QModelIndex) -> ^QModelIndex ---

	/// \brief Calls the default QAbstractTableModel::parent() function
	qabstracttablemodel_parent :: proc(vptr: ^QAbstractTableModel, child: ^QModelIndex) -> ^QModelIndex ---

	/// @}

	/// \defgroup QAbstractItemModel QAbstractItemModel
	/// \brief Functions related to the QAbstractItemModel class
	/// @{

	/// \brief Return QMetaObject associated to the QAbstractItemModel class
	/// \return The QMetaObject of the QAbstractItemModel class
	/// \note The returned QMetaObject should be freed using dos_qmetaobject_delete().
	qabstractitemmodel_qmetaobject :: proc() -> ^QMetaObject ---

	/// \brief Create a new QAbstractItemModel
	/// \param callbackObject The pointer of QAbstractItemModel in the binded language
	/// \param metaObject The QMetaObject for this QAbstractItemModel
	/// \param dObjectCallback The callback for handling the properties read/write and slots execution
	/// \param callbacks The QAbstractItemModel callbacks
	/// \note The callbacks struct is copied so you can freely delete after calling this function
	qabstractitemmodel_create :: proc(callbackObject: rawptr,
									  metaObject: ^QMetaObject,
									  dObjectCallback: DObjectCallback,
									  callbacks: ^QAbstractItemModelCallbacks) -> ^QAbstractItemModel ---

	/// \brief Calls the QAbstractItemModel::setData function
	qabstractitemmodel_setData :: proc(vptr: ^QAbstractItemModel, index: ^QModelIndex, data: ^QVariant, role: i32) -> b32 ---

	/// \brief Calls the QAbstractItemModel::roleNames function
	qabstractitemmodel_roleNames :: proc(vptr: ^QAbstractItemModel) -> ^QHashIntQByteArray ---

	/// \brief Calls the QAbstractItemModel::flags function
	qabstractitemmodel_flags :: proc(vptr: ^QAbstractItemModel, index: ^QModelIndex) -> i32 ---

	/// \brief Calls the QAbstractItemModel::headerData function
	qabstractitemmodel_headerData :: proc(vptr: ^QAbstractItemModel, section: i32, orientation: i32, role: i32) -> ^QVariant ---

	/// \brief Calls the QAbstractItemModel::hasChildren function
	qabstractitemmodel_hasChildren :: proc(vptr: ^QAbstractItemModel, parentIndex: ^QModelIndex) -> b32 ---

	/// \brief Calls the QAbstractItemModel::hasIndex function
	qabstractitemmodel_hasIndex :: proc(vptr: ^QAbstractItemModel, row: i32, column: i32, dosParentIndex: ^QModelIndex) -> b32 ---

	/// \brief Calls the QAbstractItemModel::canFetchMore function
	qabstractitemmodel_canFetchMore :: proc(vptr: ^QAbstractItemModel, parentIndex: ^QModelIndex) -> b32 ---

	/// \brief Calls the QAbstractItemModel::fetchMore function
	qabstractitemmodel_fetchMore :: proc(vptr: ^QAbstractItemModel, parentIndex: ^QModelIndex) ---

	/// \brief Calls the QAbstractItemModel::beginInsertRows() function
	/// \param vptr The QAbstractItemModel
	/// \param parent The parent QModelIndex
	/// \param first The first row in the range
	/// \param last The last row in the range
	/// \note The \p parent QModelIndex is owned by the caller thus it will not be deleted
	qabstractitemmodel_beginInsertRows :: proc(vptr: ^QAbstractItemModel, parent: ^QModelIndex, first: i32, last: i32) ---

	/// \brief Calls the QAbstractItemModel::endInsertRows() function
	/// \param vptr The QAbstractItemModel
	qabstractitemmodel_endInsertRows :: proc(vptr: ^QAbstractItemModel) ---

	/// \brief Calls the QAbstractItemModel::beginRemovetRows() function
	/// \param vptr The QAbstractItemModel
	/// \param parent The parent QModelIndex
	/// \param first The first column in the range
	/// \param last The last column in the range
	/// \note The \p parent QModelIndex is owned by the caller thus it will not be deleted
	qabstractitemmodel_beginRemoveRows :: proc(vptr: ^QAbstractItemModel, parent: ^QModelIndex, first: i32, last: i32) ---

	/// \brief Calls the QAbstractItemModel::endRemoveRows() function
	/// \param vptr The QAbstractItemModel
	qabstractitemmodel_endRemoveRows :: proc(vptr: ^QAbstractItemModel) ---

	/// \brief Calls the QAbstractItemModel::beginInsertColumns() function
	/// \param vptr The QAbstractItemModel
	/// \param parent The parent QModelIndex
	/// \param first The first column in the range
	/// \param last The last column in the range
	/// \note The \p parent QModelIndex is owned by the caller thus it will not be deleted
	qabstractitemmodel_beginInsertColumns :: proc(vptr: ^QAbstractItemModel, parent: ^QModelIndex, first: i32, last: i32) ---

	/// \brief Calls the QAbstractItemModel::endInsertColumns() function
	/// \param vptr The QAbstractItemModel
	qabstractitemmodel_endInsertColumns :: proc(vptr: ^QAbstractItemModel) ---

	/// \brief Calls the QAbstractItemModel::beginRemovetColumns() function
	/// \param vptr The QAbstractItemModel
	/// \param parent The parent QModelIndex
	/// \param first The first column in the range
	/// \param last The last column in the range
	/// \note The \p parent QModelIndex is owned by the caller thus it will not be deleted
	qabstractitemmodel_beginRemoveColumns :: proc(vptr: ^QAbstractItemModel, parent: ^QModelIndex, first: i32, last: i32) ---

	/// \brief Calls the QAbstractItemModel::endRemoveColumns() function
	/// \param vptr The QAbstractItemModel
	qabstractitemmodel_endRemoveColumns :: proc(vptr: ^QAbstractItemModel) ---

	/// \brief Calls the QAbstractItemModel::beginResetModel() function
	/// \param vptr The QAbstractItemModel
	qabstractitemmodel_beginResetModel :: proc(vptr: ^QAbstractItemModel) ---

	/// \brief Calls the QAbstractItemModel::endResetModel() function
	/// \param vptr The QAbstractItemModel
	qabstractitemmodel_endResetModel :: proc(vptr: ^QAbstractItemModel) ---

	/// \brief Emit the dataChanged signal
	/// \param vptr The DosQAbstractItemModel pointer
	/// \param topLeft The topLeft DosQModelIndex
	/// \param bottomRight The bottomright DosQModelIndex
	/// \param rolesPtr The roles array
	/// \param rolesLength The roles array length
	/// \note The \p topLeft, \p bottomRight and \p rolesPtr arguments are owned by the caller thus they will not be deleted
	qabstractitemmodel_dataChanged :: proc(vptr: ^QAbstractItemModel,
											 topLeft: ^QModelIndex,
											 bottomRight: ^QModelIndex,
											 rolesPtr: [^]i32, rolesLength: i32) ---

	/// \brief Calls the QAbstractItemModel::createIndex() function
	qabstractitemmodel_createIndex :: proc(vptr: ^QAbstractItemModel, row: i32, column: i32, data: rawptr) -> ^QModelIndex ---



	/// \brief Return QMetaObject associated to the QObject class
	/// \return The QMetaObject of the QObject class
	/// \note The returned QObject should be freed using dos_qmetaobject_delete().
	qobject_qmetaobject :: proc() -> ^QMetaObject ---

	/// \brief Create a new QObject
	/// \param dObjectPointer The pointer of the QObject in the binded language
	/// \param metaObject The QMetaObject associated to the given QObject
	/// \param dObjectCallback The callback called from QML whenever a slot or property
	/// should be in read, write or invoked
	/// \return A new QObject
	/// \note The returned QObject should be freed by calling dos_qobject_delete()
	/// \note The \p dObjectPointer is usefull for forwarding a property read/slot to the correct
	/// object in the binded language in the callback
	qobject_create :: proc(dObjectPointer: rawptr,
							metaObject: ^QMetaObject,
							dObjectCallback: DObjectCallback) -> ^QObject ---

	/// \brief Emit a signal definited in a QObject
	/// \param vptr The QObject
	/// \param name The signal name
	/// \param parametersCount The number of parameters in the \p parameters array
	/// \param parameters An array of DosQVariant with the values of signal arguments
	qobject_signal_emit :: proc(vptr: ^QObject,
								  name: cstring,
								  parametersCount: i32,
								  parameters: [^]rawptr) ---

	/// \brief Return the DosQObject objectName
	/// \param vptr The DosQObject pointer
	/// \return A string in UTF8 format
	/// \note The returned string should be freed using the dos_chararray_delete() function
	qobject_objectName :: proc(vptr: ^QObject) -> cstring ---

	/// \brief Calls the QObject::setObjectName() function
	/// \param vptr The QObject
	/// \param name A pointer to an UTF-8 string
	/// \note The \p name string is owned by the caller thus it will not be deleted
	void qobject_setObjectName :: proc(DosQObject *vptr, const char *name)

	/// \brief Free the memory allocated for the QObject
	/// \param vptr The QObject
	void qobject_delete :: proc(DosQObject *vptr)

	/// \brief Free the memory allocated for the QObject in the next event loop cycle
	/// \param vptr The QObject
	void qobject_deleteLater :: proc(DosQObject *vptr)

	/// \brief Read Value of a property by its name
	/// \param vptr The QObject
	/// \param propertyName the Name of the property to be read
	/// \returns Value of the given property
	/// \note returns an empty QVariant if the propertyName does not exist
	DosQVariant *qobject_property :: proc(DosQObject *vptr,
													   const char *propertyName)

	/// \brief Write Value to a property by its name
	/// \param vptr The QObject
	/// \param propertyName The Name of the property to be written
	/// \param value The value to be written
	/// \return Result as bool
	bool qobject_setProperty :: proc(DosQObject *vptr,
												  const char *propertyName,
												  DosQVariant *value)

	/// \brief Return the equivalent of SLOT(str) macro invokation
	/// \note The returned string should be free with dos_chararray_delete
	char* slot_macro :: proc(const char* str)

	/// \brief Return the equivalent of SIGNAL(str) macro invokation
	/// \note The returned string should be freed by calling the dos_chararray_delete() function
	char* signal_macro :: proc(const char* str)

	/// \brief Connect an object signal to a lambda/callback
	DosQMetaObjectConnection* qobject_connect_lambda_static :: proc(DosQObject *sender, const char *signal,
																				 DosQObjectConnectLambdaCallback callback, void* callbackData,
																				 DosQtConnectionType connection_type)

	/// \brief Connect an object signal to a lambda/callback
	DosQMetaObjectConnection* qobject_connect_lambda_with_context_static :: proc(DosQObject *sender, const char *signal, DosQObject *context,
																							  DosQObjectConnectLambdaCallback callback, void* callbackData,
																							  DosQtConnectionType connection_type)

	/// \brief Connect an object signal to another object signal or slot
	/// \note Use the dos_signal_macro o dos_slot_macro for property format the string arguments
	DosQMetaObjectConnection* qobject_connect_static :: proc(DosQObject *sender, const char *signal,
																		  DosQObject *receiver, const char *slot,
																		  DosQtConnectionType connection_type)

	/// \brief Disconnect an object slot or signal from an object signal
	/// \note Use the dos_signal_macro o dos_slot_macro for property format the string arguments
	qobject_disconnect_static :: proc(DosQObject *sender, const char *signal,
														DosQObject *receiver, const char *slot) ---

	/// \brief Disconnect through a DosQMetaObjectConnection
	qobject_disconnect_with_connection_static :: proc(DosQMetaObjectConnection* connection) ---

	/// \defgroup QMetaObject::Connection QMetaObject::Connection
	/// \brief Functions related to the QMetaObject::Connection class
	/// @{

	void dos_qmetaobject_connection_delete(DosQMetaObjectConnection* self)

	/// @}

	/// \defgroup QModelIndex QModelIndex
	/// \brief Functions related to the QModelIndex class
	/// @{

	/// \brief Create a new QModelIndex()
	/// \note The returned QModelIndex should be freed by calling the dos_qmodelindex_delete() function
	DosQModelIndex *dos_qmodelindex_create(void)

	/// \brief Create a new QModelIndex() copy constructed with given index
	/// \note The returned QModelIndex should be freed by calling the dos_qmodelindex_delete() function
	DosQModelIndex *dos_qmodelindex_create_qmodelindex(DosQModelIndex *index)

	/// \brief Free the memory allocated for the QModelIndex
	/// \param vptr The QModelIndex
	void dos_qmodelindex_delete (DosQModelIndex *vptr)

	/// \brief Calls the QModelIndex::row() function
	/// \param vptr The QModelIndex
	/// \return The QModelIndex row
	int  dos_qmodelindex_row    (const DosQModelIndex *vptr)

	/// \brief Calls the QModelIndex::column() function
	/// \param vptr The QModelIndex
	/// \return The QModelIndex column
	int  dos_qmodelindex_column (const DosQModelIndex *vptr)

	/// \brief Calls the QModelIndex::isvalid() function
	/// \param vptr The QModelIndex
	/// \return True if the QModelIndex is valid, false otherwise
	bool dos_qmodelindex_isValid(const DosQModelIndex *vptr)

	/// \brief Calls the QModelIndex::data() function
	/// \param vptr The QModelIndex
	/// \param role The model role to which we want the data
	/// \return The QVariant associated at the given role
	/// \note The returned QVariant should be freed by calling the dos_qvariant_delete() function
	DosQVariant *dos_qmodelindex_data (const DosQModelIndex *vptr, int role)

	/// \brief Calls the QModelIndex::parent() function
	/// \param vptr The QModelIndex
	/// \return The model parent QModelIndex
	/// \note The returned QModelIndex should be freed by calling the dos_qmodelindex_delete() function
	DosQModelIndex *dos_qmodelindex_parent (const DosQModelIndex *vptr)

	/// \brief Calls the QModelIndex::child() function
	/// \param vptr The QModelIndex
	/// \param row The child row
	/// \param column The child column
	/// \return The model child QModelIndex at the given \p row and \p column
	/// \note The returned QModelIndex should be freed by calling the dos_qmodelindex_delete() function
	DosQModelIndex *dos_qmodelindex_child  (const DosQModelIndex *vptr, int row, int column)

	/// \brief Calls the QModelIndex::sibling() function
	/// \param vptr The QModelIndex
	/// \param row The sibling row
	/// \param column The sibling column
	/// \return The model sibling QModelIndex at the given \p row and \p column
	/// \note The returned QModelIndex should be freed by calling the dos_qmodelindex_delete() function
	DosQModelIndex *dos_qmodelindex_sibling(const DosQModelIndex *vptr, int row, int column)

	/// \brief Calls the QModelIndex::operator=(const QModelIndex&) function
	/// \param l The left side QModelIndex
	/// \param r The right side QModelIndex
	void dos_qmodelindex_assign(DosQModelIndex *l, const DosQModelIndex *r)

	/// \brief Calls the QModelIndex::internalPointer function
	/// \param vptr The QModelIndex
	/// \return The internal pointer
	void* dos_qmodelindex_internalPointer(DosQModelIndex *vptr)


	/// @}

	/// \defgroup QHash QHash
	/// \brief Functions related to the QHash class
	/// @{

	/// \brief Create a new QHash<int, QByteArray>
	/// \return A new QHash<int, QByteArray>
	/// \note The retuned QHash<int, QByteArray> should be freed using
	/// the dos_qhash_int_qbytearray_delete(DosQHashIntQByteArray *) function
	DosQHashIntQByteArray *dos_qhash_int_qbytearray_create(void)

	/// \brief Free the memory allocated for the QHash<int, QByteArray>
	/// \param vptr The QHash<int, QByteArray>
	void  dos_qhash_int_qbytearray_delete(DosQHashIntQByteArray *vptr)

	/// \brief Calls the QHash<int, QByteArray>::insert() function
	/// \param vptr The QHash<int, QByteArray>
	/// \param key The key
	/// \param value The UTF-8 string
	/// \note The \p value string is owned by the caller thus it will not be freed
	void  dos_qhash_int_qbytearray_insert(DosQHashIntQByteArray *vptr, int key, const char *value)

	/// \brief Calls the QHash<int, QByteArray>::value() function
	/// \param vptr The QHash<int, QByteArray>
	/// \param key The key to which retrive the value
	/// \return The UTF-8 string associated to the given value
	/// \note The returned string should be freed by calling the dos_chararray_delete() function
	char *dos_qhash_int_qbytearray_value(const DosQHashIntQByteArray *vptr, int key)

	/// @}

	/// \defgroup QResource QResource
	/// \brief Functions related to the QResource class
	/// @{

	/// Register the given .rcc (compiled) file in the resource system
	void dos_qresource_register(const char *filename)

	/// @}

	/// \defgroup QUrl QUrl
	/// \brief Functions related to the QUrl class
	/// @{

	/// \brief Create a new QUrl
	/// \param url The UTF-8 string that represents an url
	/// \param parsingMode The parsing mode
	/// \note The retuned QUrl should be freed using the dos_qurl_delete() function
	DosQUrl *dos_qurl_create(const char *url, int parsingMode)

	/// \brief Free the memory allocated for the QUrl
	/// \param vptr The QUrl to be freed
	void dos_qurl_delete(DosQUrl *vptr)

	/// \brief Calls the QUrl::toString() function
	/// \param vptr The QUrl
	/// \return The url as an UTF-8 string
	/// \note The returned string should be freed using the dos_chararray_delete() function
	char *dos_qurl_to_string(const DosQUrl *vptr)

	/// \brief Class the QUrl::isValid() function
	/// \param vptr The QUrl
	/// \return True if the QUrl is valid, false otherwise
	bool dos_qurl_isValid(const DosQUrl *vptr)

	/// @}

	/// \defgroup QDeclarative QDeclarative
	/// \brief Functions related to the QDeclarative module
	/// @{

	/// \brief Register a type in order to be instantiable from QML
	/// \return An integer value that represents the registration ID in the
	/// qml environment
	/// \note The \p qmlRegisterType is owned by the caller thus it will not be freed
	int dos_qdeclarative_qmlregistertype(const QmlRegisterType *qmlRegisterType)

	/// \brief Register a singleton type in order to be accessible from QML
	/// \return An integer value that represents the registration ID in the
	/// \note The \p qmlRegisterType is owned by the caller thus it will not be freed
	int dos_qdeclarative_qmlregistersingletontype(const QmlRegisterType *qmlRegisterType)

	/// @}


	/// \defgroup QPointer QPointer
	/// @{

	/// \brief Create a new QPointer with the given DosQObject
	DosQPointer* dos_qpointer_create(DosQObject* object)

	/// \brief Free the memory allocated for the given QPointer
	void dos_qpointer_delete(DosQPointer* self)

	/// \brief Test the QPointer for nullness
	bool dos_qpointer_is_null(DosQPointer* self)

	/// \brief Clear the QPointer
	void dos_qpointer_clear(DosQPointer* self)

	/// \brief Return a pointer to the tracked DosQObject
	/// \note The return DosQObject is a reference and should not be fred unless you know what you're doing
	DosQObject* dos_qpointer_data(DosQPointer* self)

	/// @}


}
