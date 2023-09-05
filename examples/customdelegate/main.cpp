#include "tree_model.h"

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

void populateModel(TreeModel& model)
{
    auto america = new TreeItem("America");
    auto asia = new TreeItem("Asia");
    auto europe = new TreeItem("Europe");
    auto oceania = new TreeItem("Oceania");

    auto brazil = new TreeItem("Brazil");
    auto canada = new TreeItem("Canada");
    auto mexico = new TreeItem("Mexico");
    auto usa = new TreeItem("USA");

    auto italy = new TreeItem("Italy");
    auto france = new TreeItem("France");
    auto portugal = new TreeItem("Portugal");
    auto spain = new TreeItem("Spain");

    model.addTopLevelItem(america);
    model.addTopLevelItem(asia);
    model.addTopLevelItem(europe);
    model.addTopLevelItem(oceania);
    model.addItem(america, brazil);
    model.addItem(america, canada);
    model.addItem(america, mexico);
    model.addItem(america, usa);
    model.addItem(europe, italy);
    model.addItem(europe, france);
    model.addItem(europe, portugal);
    model.addItem(europe, spain);
}

int main(int argc, char* argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    engine.addImportPath("qrc:/modules");

    auto treeModel = new TreeModel(&engine);
    populateModel(*treeModel);

    engine.rootContext()->setContextProperty("treeModel", treeModel);
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &app,
        [url](QObject* obj, const QUrl& objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
