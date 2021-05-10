#include <qtimer.h>
#include "mainwindow.h"
#include "./ui_mainwindow.h"

#include <string>
#include <iostream>

#include "./exprtk.h"

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);

    QTimer::singleShot(0, this, [this] {
       ui->lineEdit->setFocus();
   });

}

MainWindow::~MainWindow()
{
    delete ui;
}

template <class T>
T evaluate(std::string expression_string) {


typedef exprtk::symbol_table<T> symbol_table_t;
   typedef exprtk::expression<T>  expression_t;
   typedef exprtk::parser<T>      parser_t;

   T x;

   symbol_table_t symbol_table;
   // symbol_table.add_variable("x",x);
   symbol_table.add_constants();

   expression_t expression;
   expression.register_symbol_table(symbol_table);

   parser_t parser;
   parser.compile(expression_string,expression);

   T res = expression.value();
   return res;
}

void MainWindow::on_lineEdit_returnPressed()
{
    auto text = ui->lineEdit->text().toStdString();

    auto result = evaluate<double>(std::string(text));
    auto line = QString().asprintf("%s = %lf", text.c_str(), result);

    ui->listWidget->addItem(line);
    ui->lineEdit->clear();
}

