TEMPLATE = subdirs

SUBDIRS += \
   examples \
   tests

OTHER_FILES += \
   $$files(modules/QMLTreeView/*) \
   README.md
