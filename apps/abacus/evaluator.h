#ifndef EVALUATOR_H
#define EVALUATOR_H

#include <string>
#include "./exprtk.h"

template <typename T>
class Evaluator {
public:
    typedef exprtk::symbol_table<T> symbol_table_t;
    typedef exprtk::expression<T>  expression_t;
    typedef exprtk::parser<T>      parser_t;

    Evaluator()
    {
        // T x;
        // symbol_table.add_variable("x", x);
    }

    T evaluate(std::string expression_string)
    {
        symbol_table.add_constants();

        expression_t expression;
        expression.register_symbol_table(symbol_table);

        parser_t parser;
        parser.compile(expression_string,expression);

        return expression.value();
    }

private:
    symbol_table_t symbol_table;
};

#endif // EVALUATOR_H
