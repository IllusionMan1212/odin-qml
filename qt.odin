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

/// Called when a property is readed/written or a slot should be executed
/// \param self The pointer of QObject in the binded language
/// \param slotName The slotName as DosQVariant
/// \param argc The number of arguments
/// \param argv An array of DosQVariant pointers
/// \note The first argument of \p argv is always the return value of the called slot.
/// In other words the length of argv is always 1 + number of arguments of \p slotName.
/// The return value should be assigned and modified by calling the dos_qvariant_assign()
/// or other dos_qvariant_set... setters.
/// \note The \p slotName is owned by the library thus it \b shouldn't be deleted
/// \note The \p argv array is owned by the library thus it \b shouldn't be deleted
ObjectCallback :: #type proc "c" (self: rawptr, slotName: ^QVariant, argc: i32, argv: [^]^QVariant)

QEventLoopProcessEventFlag :: enum i32 {
    ProcessAllEvents = 0x00,
    ExcludeUserInputEvents = 0x01,
    ProcessExcludeSocketNotifiers = 0x02,
    ProcessAllEventsWaitForMoreEvents = 0x03
}

/*
  enum Type {
  UnknownType = 0, Bool = 1, Int = 2, UInt = 3, LongLong = 4, ULongLong = 5,
  Double = 6, Long = 32, Short = 33, Char = 34, ULong = 35, UShort = 36,
  UChar = 37, Float = 38,
  VoidStar = 31,
  QChar = 7, QString = 10, QStringList = 11, QByteArray = 12,
  QBitArray = 13, QDate = 14, QTime = 15, QDateTime = 16, QUrl = 17,
  QLocale = 18, QRect = 19, QRectF = 20, QSize = 21, QSizeF = 22,
  QLine = 23, QLineF = 24, QPoint = 25, QPointF = 26, QRegExp = 27,
  QEasingCurve = 29, QUuid = 30, QVariant = 41, QModelIndex = 42,
  QRegularExpression = 44,
  QJsonValue = 45, QJsonObject = 46, QJsonArray = 47, QJsonDocument = 48,
  QObjectStar = 39, SChar = 40,
  Void = 43,
  QVariantMap = 8, QVariantList = 9, QVariantHash = 28,
  QFont = 64, QPixmap = 65, QBrush = 66, QColor = 67, QPalette = 68,
  QIcon = 69, QImage = 70, QPolygon = 71, QRegion = 72, QBitmap = 73,
  QCursor = 74, QKeySequence = 75, QPen = 76, QTextLength = 77, QTextFormat = 78,
  QMatrix = 79, QTransform = 80, QMatrix4x4 = 81, QVector2D = 82,
  QVector3D = 83, QVector4D = 84, QQuaternion = 85, QPolygonF = 86,
  QSizePolicy = 121,
  User = 1024
  };
*/
QMetaType :: enum i32 {
    Unknown = 0,
    Bool = 1,
    Int = 2,
    Double = 6,
    String = 10,
    VoidStr = 31,
    Float = 38,
    QObject = 39,
    QVariant = 41,
    Void = 43
}

QQmlApplicationEngine :: struct{}
QUrl :: struct{}
QVariant :: struct{}
QObject :: struct{}
QMetaObject :: struct{}
QQmlContext :: struct{}
QQuickImageProvider :: struct{}

/// \brief Store an array of QVariant
/// \note This struct should be freed by calling dos_qvariantarray_delete(DosQVariantArray *ptr). This in turn
/// cleans up the internal array
QVariantArray :: struct {
    /// The number of elements
	size: i32,
    /// The array
    data: [^]^QVariant,
}

/// Represents a parameter definition
ParameterDefinition :: struct {
    /// The parameter name
	name: cstring,
    /// The parameter metatype
    metaType: QMetaType,
}

/// Represents a single signal definition
SignalDefinition :: struct {
    /// The signal name
	name: cstring,
    /// The parameters count
    parametersCount: i32,
    /// The parameters
    parameters: [^]ParameterDefinition,
}

/// Represents a set of signal definitions
SignalDefinitions :: struct {
    /// The total number of signals
	count: i32,
    /// The signals
    definitions: [^]SignalDefinition,
}

/// Represents a single slot definition
SlotDefinition :: struct {
    /// The slot name
	name: cstring,
    /// The slot return type
    returnMetaType: QMetaType,
    /// The parameters count
    parametersCount: i32,
    /// The parameters
    parameters: [^]ParameterDefinition,
}

/// Represents a set of slot definitions
SlotDefinitions :: struct {
    /// The total number of slots
	count: i32,
    /// The slot definitions array
    definitions: [^]SlotDefinition,
}

/// Represents a single property definition
PropertyDefinition :: struct {
    /// The property name
	name: cstring,
    /// The property metatype
    propertyMetaType: QMetaType,
    /// The name of the property read slot
    readSlot: cstring,
    /// \brief The name of the property write slot
    /// \note Setting this to null means a readonly proeperty
    writeSlot: cstring,
    /// \brief The name of the property notify signals
    /// \note Setting this to null means a constant property
    notifySignal: cstring,
}

/// Represents a set of property definitions
PropertyDefinitions :: struct {
    /// The total number of properties
	count: i32,
    /// The property definitions array
    definitions: [^]PropertyDefinition,
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
							dObjectCallback: ObjectCallback) -> ^QObject ---

	/// \brief Return the DosQObject objectName
	/// \param vptr The DosQObject pointer
	/// \return A string in UTF8 format
	/// \note The returned string should be freed using the dos_chararray_delete() function
	qobject_objectName :: proc(vptr: ^QObject) -> cstring ---



	/// \brief Create a new QVariant holding a QObject value
	/// \return The a new QVariant
	/// \param value The QObject value
	/// \note The returned QVariant should be freed using dos_qvariant_delete()
	qvariant_create_qobject :: proc(value: ^QObject) -> ^QVariant ---

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

	/// \brief Calls the QVariant::value<QString>() function
	/// \param vptr The QVariant
	/// \return The string value
	/// \note The returned string should be freed by using dos_chararray_delete()
	qvariant_toString :: proc(vptr: ^QVariant) -> cstring ---

	/// \brief Calls the QVariant::value<int>() function
	/// \param vptr The QVariant
	/// \return The int value
	qvariant_toInt :: proc(vptr: ^QVariant) -> i32 ---

	/// \brief Emit a signal definited in a QObject
	/// \param vptr The QObject
	/// \param name The signal name
	/// \param parametersCount The number of parameters in the \p parameters array
	/// \param parameters An array of DosQVariant with the values of signal arguments
	qobject_signal_emit :: proc(vptr: ^QObject,
								  name: cstring,
								  parametersCount: i32,
								  parameters: [^]rawptr) ---

	/// \brief Calls the QVariant::setValue<int>() function
	/// \param vptr The QVariant
	/// \param value The int value
	qvariant_setInt :: proc(vptr: ^QVariant, value: i32) ---

	/// \brief Calls the QVariant::operator=(const QVariant&) function
	/// \param vptr The QVariant (left side)
	/// \param other The QVariant (right side)
	qvariant_assign :: proc(vptr: ^QVariant, other: ^QVariant) ---

	/// \brief Create a new QVariant holding an int value
	/// \return The a new QVariant
	/// \param value The int value
	/// \note The returned QVariant should be freed using dos_qvariant_delete()
	qvariant_create_int :: proc(value: i32) -> ^QVariant ---

	/// \brief Calls the QVariant::value<QObject*>() function
	/// \param vptr The QVariant
	/// \return The QObject* value
	/// \note Storing the returned QObject* is higly dengerous and depends on how you managed the memory
	/// of QObjects in the binded language
	qvariant_toQObject :: proc(vptr: ^QVariant) -> ^QObject ---

}
