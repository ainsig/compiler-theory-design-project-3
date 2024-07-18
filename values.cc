// CMSC 430 Compiler Theory and Design
// Project 3 Skeleton
// UMGC CITE
// Summer 2023

// This file contains the bodies of the evaluation functions

#include <string>
#include <cmath>
#include <vector>  
#include <functional> 

using namespace std;

#include "values.h"
#include "listing.h"

double evaluateArithmetic(double left, Operators operator_, double right) {
	double result;
	switch (operator_) {
		case ADD:
			result = left + right;
			break;
		case MULTIPLY:
			result = left * right;
			break;
		case SUBTRACT:
			result = left - right; 
			break; 
		case DIVIDE: 
			result = left / right; 
			break; 
		case REMAINDER: 
			result = fmod(left, right); 
			break; 
		case EXPONENT:
			result = pow(left, right); 
			break; 
		case NEGATE: 
			result = -right;
			break;
		default: 
			result = 0;
			break; 
	}
	return result;
}

double evaluateRelational(double left, Operators operator_, double right) {
	double result;
	switch (operator_) {
		case LESS:
			result = left < right;
			break;
		case GREATER:
			result = left > right; 
			break;
		case EQUAL:
			result = left == right; 
			break;
		case NOTEQUAL:
			result = left != right; 
			break;
		case LESSEQUAL:
			result = left <= right; 
		case GREATEREQUAL:
			result = left >= right;
			break;
		default:
			result = 0; 
			break; 
	}
	return result;
}

double evaluateLogical(double left, Operators operator_, double right){
	double result; 
	switch (operator_){
		case AND:
			result = left && right; 
			break; 
		case OR:
			result = left || right; 
			break; 
		case NOT:
			result = !right; 
			break; 
		default:
			result = 0; 
			break; 
	}
	return result; 
}

double evaluateFold(Operators operator_, vector<double>* values, bool isLeft) {
    double result;
    if (values->empty()) {
        appendError(SYNTAX, "Empty list in fold");
        return NAN;
    }

    std::function<double(double, double)> operation;
    switch (operator_) {
        case ADD: operation = [](double a, double b) { return a + b; }; break;
        case SUBTRACT: operation = [](double a, double b) { return a - b; }; break;
        case MULTIPLY: operation = [](double a, double b) { return a * b; }; break;
        case DIVIDE: operation = [](double a, double b) { return a / b; }; break;
        case REMAINDER: operation = [](double a, double b) { return fmod(a, b); }; break;
        // Add other operators as needed
        default: appendError(SYNTAX, "Unsupported operation for fold"); return NAN;
    }

    if (isLeft) {
        result = values->front();
        for (size_t i = 1; i < values->size(); ++i) {
            result = operation(result, (*values)[i]);
        }
    } else {
        result = values->back();
        for (int i = values->size() - 2; i >= 0; --i) {
            result = operation((*values)[i], result);
        }
    }

    return result;
}

