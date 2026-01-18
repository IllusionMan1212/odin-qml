package qt

QVariant :: struct{}
QModelIndex :: struct{}
QAbstractItemModel :: struct{}
QAbstractListModel :: struct{}
QAbstractTableModel :: struct{}
QQmlApplicationEngine :: struct{}
QQuickView :: struct{}
QQmlContext :: struct{}
QHashIntQByteArray :: struct{}
QUrl :: struct{}
QMetaObject :: struct{}
QObject :: struct{}
QQuickImageProvider :: struct{}
QPixmap :: struct{}
QPointer :: struct{}
QMetaObjectConnection :: struct{}

/// A pixmap callback to be supplied to an image provider
/// \param id Image source id
/// \param width pointer to the width of the image
/// \param height pointer to the height of the image
/// \param requestedHeight sourceSize.height attribute
/// \param requestedWidth sourcesSize.width attribute
/// \param[out] result The result QPixmap. This should be assigned from the binded language
/// \note \p id is the trailing part of an image source url for example "image://<provider_id>/<id>
/// \note The \p result arg is an out parameter so it \b shouldn't be deleted. See the dos_qpixmap_assign
RequestPixmapCallback :: #type proc "c" (id: cstring, width: ^i32, height: ^i32, requestedWidth: i32, requestedHeight: i32, result: ^QPixmap)

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
DObjectCallback :: #type proc "c" (self: rawptr, slotName: ^QVariant, argc: i32, argv: [^]^QVariant)

/// Called when the QAbstractItemModel::rowCount method must be executed
/// \param self The pointer of the QAbstractItemModel in the binded language
/// \param index The parent DosQModelIndex
/// \param[out] result The rowCount result. This must be deferenced and filled from the binded language
/// \note The \p parent QModelIndex is owned by the DOtherSide library thus it \b shouldn't be deleted
/// \note The \p result arg is an out parameter so it \b shouldn't be deleted
RowCountCallback :: #type proc "c" (self: rawptr, parent: ^QModelIndex, result: ^i32)

/// Called when the QAbstractItemModel::columnCount method must be executed
/// \param self The pointer to the QAbstractItemModel in the binded language
/// \param index The parent DosQModelIndex
/// \param[out] result The rowCount result. This must be deferenced and filled from the binded language
/// \note The \p parent QModelIndex is owned by the DOtherSide library thus it \b shouldn't be deleted
/// \note The \p result arg is an out parameter so it \b shouldn't be deleted
ColumnCountCallback :: #type proc "c" (self: rawptr, parent: ^QModelIndex, result: ^i32)

/// Called when the QAbstractItemModel::data method must be executed
/// \param self The pointer to the QAbstractItemModel in the binded language
/// \param index The DosQModelIndex to which we request the data
/// \param[out] result The DosQVariant result. This must be deferenced and filled from the binded language.
/// \note The \p index QModelIndex is owned by the DOtherSide library thus it \b shouldn't be deleted
/// \note The \p result arg is an out parameter so it \b shouldn't be deleted
DataCallback :: #type proc "c" (self: rawptr, index: ^QModelIndex, role: i32, result: ^QVariant)

/// Called when the QAbstractItemModel::setData method must be executed
SetDataCallback :: #type proc "c" (self: rawptr, index: ^QModelIndex, value: ^QVariant, role: i32, result: ^b32)

/// Called when the QAbstractItemModel::roleNames method must be executed
RoleNamesCallback :: #type proc "c" (self: rawptr, result: ^QHashIntQByteArray)

/// Called when the QAbstractItemModel::flags method must be called
FlagsCallback :: #type proc "c" (self: rawptr, index: ^QModelIndex, result: ^i32)

/// Called when the QAbstractItemModel::headerData method must be called
HeaderDataCallback :: #type proc "c" (self: rawptr, section: i32, orientation: i32, role: i32, result: ^QVariant)

/// Called when the QAbstractItemModel::index method must be called
IndexCallback :: #type proc "c" (self: rawptr, row: i32, column: i32, parent: ^QModelIndex, result: ^QModelIndex)

/// Called when the QAbstractItemModel::parent method must be called
ParentCallback :: #type proc "c" (self: rawptr, child: ^QModelIndex, result: ^QModelIndex)

/// Called when the QAbstractItemModel::hasChildren method must be called
HasChildrenCallback :: #type proc "c" (self: rawptr, parent: ^QModelIndex, result: ^b32)

/// Called when the QAbstractItemModel::canFetchMore method must be called
CanFetchMoreCallback :: #type proc "c" (self: rawptr, parent: ^QModelIndex, result: ^b32)

/// Called when the QAbstractItemModel::fetchMore method must be called
FetchMoreCallback :: #type proc "c" (self: rawptr, parent: ^QModelIndex)

/// Callback called from QML for creating a registered type
/**
 * When a type is created through the QML engine a new QObject \p "Wrapper" is created. This becomes a proxy
 * between the "default" QObject created through dos_qobject_create() and the QML engine. This imply that implementation
 * for this callback should swap the DosQObject* stored in the binded language with the wrapper. At the end the wrapper
 * becomes the owner of the original "default" DosQObject. Furthermore if the binding language is garbage collected you
 * should disable (pin/ref) the original object and unref in the DeleteDObject() callback. Since the wrapper has been created
 * from QML is QML that expect to free the memory for it thus it shouldn't be destroyed by the QObject in the binded language.
 *
 * An example of implementation in pseudocode is: \n
 * \code{.nim}
proc createCallback(.....) =
  # Call the constructor for the given type and create a QObject in Nim
  let nimQObject = constructorMap[id]()

  # Disable GC
  GC.ref(nimQObject)

  # Retrieve the DosQObject created dos_qobject_create() inside the nimQObject
  *dosQObject = nimQObject.vptr

  # Store the pointer to the nimQObject
  *bindedQObject = cast[ptr](&nimQObject)

  # Swap the vptr inside the nimQObject with the wrapper
  nimQObject.vptr = wrapper

  # The QObject in the Nim language should not destroy its inner DosQObject
  nimQObject.owner = false

\endcode

 * \param id This is the id for which we are requesting the creation.
 * This is the same value that was returned during registration through the calls
 * to dos_qdeclarative_qmlregistertype() or dos_qdeclarative_qmlregistersingletontype()
 * \param wrapper This is the QObject wrapper that should be stored by the binded language and to which forward the
 * DOtherSide calls
 * \param bindedQObject This should be deferenced and assigned with the pointer of the QObject modeled in the binded language
 * \param dosQObject This should be deferenced and assigned with the DosQObject pointer you gained from calling the dos_qobject_create() function
 */
CreateDObject :: #type proc "c" (id: i32, wrapper: rawptr, bindedQObject: ^rawptr, dosQObject: ^rawptr)

/// Callback invoked from QML for deleting a registered type
/**
 * This is called when the wrapper gets deleted from QML. The implementation should unref/unpin
 * the \p bindedQObject or delete it in the case of languages without GC
 * \param id This is the type id for which we are requesting the deletion
 * \param bindedQObject This is the pointer you given in the CreateDObject callback and you can use it
 * for obtaining the QObject in your binded language. This allows you to unpin/unref it or delete it.
 */
DeleteDObject :: #type proc "c" (id: i32, bindedQObject: rawptr)

/// Callback invoked after an emit of a signal
QObjectConnectLambdaCallback :: #type proc "c" (callbackData: rawptr, argc: i32, argv: [^]^QVariant)

/// Callback invoked after a QMetaObject invoke method
QMetaObjectInvokeMethodCallback :: #type proc "c" (callbackData: rawptr)

/// \brief Store an array of QVariant
/// \note This struct should be freed by calling dos_qvariantarray_delete(DosQVariantArray *ptr). This in turn
/// cleans up the internal array
QVariantArray :: struct {
    /// The number of elements
	size: i32,
    /// The array
    data: [^]^QVariant,
}

/// The data needed for registering a custom type in the QML environment
/**
 * This is used from dos_qdeclarative_qmlregistertype() and dos_qdeclarative_qmlregistersingletontype() calls.
 * \see dos_qdeclarative_qmlregistertype()
 * \see dos_qdeclarative_qmlregistersingletontype()
 * \note All string and objects are considered to be owned by the caller thus they'll
 * not be freed
*/
QmlRegisterType :: struct {
    /// The Module major version
	major: i32,
    /// The Module minor version
    minor: i32,
    /// The Module uri
    uri: cstring,
    /// The type name to be used in QML files
    qml: cstring,
    /// The type QMetaObject
    staticMetaObject: ^QMetaObject,
    /// The callback invoked from QML when this type should be created
    createDObject: CreateDObject,
    /// The callback invoked from QML when this type should be deleted
    deleteDObject: DeleteDObject,
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

/// Incapsulate all the QAbstractItemModel callbacks
QAbstractItemModelCallbacks :: struct {
	rowCount: RowCountCallback,
    columnCount: ColumnCountCallback,
    data: DataCallback,
    setData: SetDataCallback,
    roleNames: RoleNamesCallback,
    flags: FlagsCallback,
    headerData: HeaderDataCallback,
    index: IndexCallback,
    parent: ParentCallback,
    hasChildren: HasChildrenCallback,
    canFetchMore: CanFetchMoreCallback,
    fetchMore: FetchMoreCallback,
}

QEventLoopProcessEventFlag :: enum i32 {
    ProcessAllEvents = 0x00,
    ExcludeUserInputEvents = 0x01,
    ProcessExcludeSocketNotifiers = 0x02,
    ProcessAllEventsWaitForMoreEvents = 0x03
}

QtConnectionType :: enum {
    AutoConnection = 0,
    DirectConnection = 1,
    QueuedConnection = 2,
    BlockingConnection = 3,
    UniqueConnection = 0x80
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

