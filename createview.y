%{
	#include<stdio.h>
	#include<stdlib.h>
	#include<fcntl.h>
%}
	/*
 	PROCESSING: The yacc file will parse the tokens as per the grammar that is defined using 34 Production rules. There are no semantic actions because we are just checking
	the validity. If the query do not start with create, (since its a parser for create view sql command), 
	it will be rejected or will be declared invalid in the beginning statement itself.
	*/

%token crt view g ob id cb as slct comma frm whr sc star nl
%token LT GT LE GE NE AND OR EQ si di ds
%token num odr by asc desc nj sum cnt avg


%%
result: s nl {printf("\n*************** VALID QUERY **************\n");exit(0);}
;
s: crt view id as slct star frm id MT join S4 G sort sc
	|crt view id as slct column frm id MT join S4 G sort sc
;
	/*
	s contains two production rules, 1st works for the star (all columns defined) 
	and second over given set of columns
	*/

MT : comma id
	|
;

	// MT label is used to add two tables separeted by comma 
	// or there will single table in query

join: nj id
	|
;	
	//this is one of a join clause which is used to join two or more columns

condition: id LT F logical
			|id GT F logical
			|id LE F logical
			|id GE F logical
			|id NE F logical
			|id EQ F logical
;
	// this condition statement will check the validity of relational operator followed by F label and then go to logical.

logical: AND condition
		|OR condition
		|
;
	// this logical label is used to add logical operators in query followed by condition
	// or we can use no logical operator.

S4: whr condition
	|
;
	/*
	this is a where clause which goes to condition after reading where 
	or there will be no where condition in query
	*/

G:  g by column
	|
;
	/*
	if groupby occurs it must be followed by some column name or
	there will be no groupby statement in query
	*/

column: id column
		|comma id column
		|comma agrfunc column
		|agrfunc column
		|
;
	/*
	if column label is called it could start with either identifier, comma , or any agrfunc (cnt, sum, avg) 
	followed by column, or there will be no column needed in query
	*/

agrfunc:sum ob column cb
		| cnt ob star cb 
		| cnt ob column cb
		| avg ob column cb
;
	// this label defines few aggregative functions like sum, count, avg followed by '(' column name ')' as a syntax.

sort: odr by id
	|odr by id asc
	|odr by id desc
	|
;
	// sort label is used to arrange the data in ascending or descending order with respect to any column, or not.

F: 	si id si
	|di id di
	|num ds num ds num
	|num
;
	// F defines the final item i.e. identifier (generally string format) or numbers used in the relational label.

%%




	// this error function will return INVALID QUERY if the query is not parsed by the above CFG.

int yyerror(char *s){
	printf("\n*************** INVALID QUERY **************\n");
	exit(1);
}


	/*
	driver function of the program
	it will take query as a input and calls parse function. 
	parse function will return VALID if queryis syntactically correct and INVALID if syntactically incorrect.
	*/

int main(){
	printf("Enter the Query: \n");
	yyparse();
	return 1;
}

