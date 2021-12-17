TEMPLATE = subdirs

DISTFILES += \
   $$files(plugin/*)

SUBDIRS += \
   examples/CustomDelegateTreeView \
   examples/JsonTreeView \
   examples/SimpleTreeView \
   examples/StyledTreeView \
   examples/TreeManipulation

HEADERS += \
   plugin/treemanipulator.h

SOURCES += \
   plugin/treemanipulator.cpp
