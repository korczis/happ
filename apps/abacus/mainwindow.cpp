#include <qtimer.h>

#include "mainwindow.h"
#include "./ui_mainwindow.h"

#include "./evaluator.h"

#include <string>
#include <iostream>

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);

    QTimer::singleShot(0, this, [this] {
       ui->lineEdit->setFocus();
   });

    evaluator = new Evaluator<double>();

}

MainWindow::~MainWindow()
{
    delete ui;

    delete evaluator;
}


void MainWindow::on_lineEdit_returnPressed()
{
    auto text = ui->lineEdit->text().toStdString();

    auto result = evaluator->evaluate(std::string(text));
    auto line = QString().asprintf("%s = %lf", text.c_str(), result);

    ui->listWidget->addItem(line);
    ui->lineEdit->clear();
}

