QT += testlib
QT -= gui

CONFIG += qt console warn_on depend_includepath testcase
CONFIG -= app_bundle

TEMPLATE = app

SOURCES +=  tst_treemodel.cpp
CONFIG += c++11

include(../../modules/qmltreeview.pri)

MOC_DIR = mocs
OBJECTS_DIR = obj
