/*
Write a SQL query to get the nth highest salary from the Employee table.

+----+--------+
| Id | Salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+
For example, given the above Employee table, the nth highest salary where n = 2 is 200. If there is no nth highest salary, then the query should return null.

+------------------------+
| getNthHighestSalary(2) |
+------------------------+
| 200                    |
+------------------------+
*/

CREATE FUNCTION getNthHighestSalary (N IN NUMBER) RETURN NUMBER 
IS
result NUMBER;
BEGIN

/*Option 1 using fetch option available only in 12c onwards but will not give correct result in all cases

WITH cte1 AS 
    (
    SELECT salary 
    FROM employee 
    ORDER BY salary DESC 
    FETCH FIRST N ROWS ONLY
    )
SELECT salary
INTO result
FROM cte1 
ORDER BY salary 
Fetch First 1 Rows Only*/


/*Option 2 using tradiontal style 
	
	SELECT MAX(salary)
    INTO result
    FROM employee a 
    WHERE N-1 = (SELECT COUNT(DISTINCT salary)
                    FROM employee b WHERE b.salary > a.salary);*/


/*Option 3 using dense_rank with distinct                                                        
  WITH cte1 AS(
    SELECT salary, 
    DENSE_RANK() OVER(ORDER BY Salary DESC) AS rn 
    FROM EMPLOYEE
    )
    SELECT DISTINCT salary 
    INTO result 
    FROM cte1 
    WHERE rn = N;*/
    
    
    /*Option 4 using dense_rank with aggregate function max 
    
     WITH cte1 AS(
    SELECT salary, 
    DENSE_RANK() OVER(ORDER BY Salary DESC) AS rn 
    FROM EMPLOYEE
    )
     SELECT  MAX(salary)    
    INTO Result 
    FROM cte1
    WHERE rn = N;*/
    
														   
   
RETURN result;

EXCEPTION WHEN
NO_DATA_FOUND THEN
RETURN NULL;
       
END;
