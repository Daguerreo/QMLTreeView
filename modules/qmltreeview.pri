QMLTREEVIEW_PATH = $$PWD/QMLTreeView

HEADERS += \
   $$QMLTREEVIEW_PATH/tree_item.h \
   $$QMLTREEVIEW_PATH/tree_model.h

SOURCES += \
   $$QMLTREEVIEW_PATH/tree_item.cpp \
   $$QMLTREEVIEW_PATH/tree_model.cpp \

INCLUDEPATH += \
   $$QMLTREEVIEW_PATH

RESOURCES += \
   $$QMLTREEVIEW_PATH/treeview.qrc \
