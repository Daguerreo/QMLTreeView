QT += quick

CONFIG += c++11

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

RESOURCES += qml.qrc \
   ../../plugin/treeview.qrc \
   qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

HEADERS += \
   ../../plugin/tree_item.h \
   ../../plugin/tree_model.h \
   json_entry.h

SOURCES += \
  ../../plugin/tree_item.cpp \
  ../../plugin/tree_model.cpp \
  json_entry.cpp \
  main.cpp

INCLUDEPATH += \
   ../../plugin
