// CMSC 430 Compiler Theory and Design
// Project 3 Skeleton
// UMGC CITE
// Summer 2023

// This file contains the bodies of the evaluation functions

#include <string>
#include <cmath>

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
