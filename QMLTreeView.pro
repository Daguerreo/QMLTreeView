TEMPLATE = subdirs

DISTFILES += \
   $$files(src/*)

SUBDIRS += \
   TreeView \
   ListView

HEADERS += \
   src/json_entry.h

SOURCES += \
   src/json_entry.cpp
