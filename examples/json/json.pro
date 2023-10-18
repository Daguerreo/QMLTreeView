QT += quick

CONFIG += c++11

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

## Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH = $$PWD/../../modules

## Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH = $$PWD/../../modules

RESOURCES += \
   qml.qrc \
   resources.qrc

HEADERS += \
   json_entry.h \
   json_model.h

SOURCES += \
  json_entry.cpp \
  json_model.cpp \
  main.cpp

include(../../modules/qmltreeview.pri)

MOC_DIR = mocs
OBJECTS_DIR = obj
