SELECT * FROM book_count;
SELECT * FROM books;
SELECT * FROM branch;
SELECT * FROM emp_id;
SELECT * FROM issued_emp_id;
SELECT * FROM members;
SELECT * FROM rental_table;
SELECT * FROM return_id;


INSERT INTO issued_emp_id(issued_id, issued_member_id, issued_book_name, issued_date, issued_book_isbn, issued_emp_id)
VALUES
('IS151', 'C118', 'The Catcher in the Rye', CURRENT_DATE - INTERVAL '24 days',  '978-0-553-29698-2', 'E108'),
('IS152', 'C119', 'The Catcher in the Rye', CURRENT_DATE - INTERVAL '13 days',  '978-0-553-29698-2', 'E109'),
('IS153', 'C106', 'Pride and Prejudice', CURRENT_DATE - INTERVAL '7 days',  '978-0-14-143951-8', 'E107'),
('IS154', 'C105', 'The Road', CURRENT_DATE - INTERVAL '32 days',  '978-0-375-50167-0', 'E101');

-- Adding new column in return_status

ALTER TABLE return_id
ADD Column book_quality VARCHAR(15) DEFAULT('Good');

UPDATE return_id
SET book_quality = 'Damaged'
WHERE issued_id 
    IN ('IS112', 'IS117', 'IS118');
SELECT * FROM return_id; 

--Sql Project- Library management System N2

--Q13 Write a query to identify members who have overdue books (assume a 30-day return period).
--  Display the member's_id, member's name, book title, issue date, and days overdue.
 -- issued_id == members == books == return_id
 -- filter books which is return 
 -- overdue > 30 days


				 Select 
					 ist.issued_member_id,
					 m.member_name,
					 bk.book_title,
					 ist.issued_date,
					-- rs.return_date,
				 current_date - ist.issued_date as overdue_date
				 From issued_emp_id as ist
					 Join 
					 members as m
					  On m.member_id = ist.issued_member_id
					 Join 
					 books as bk
					  On bk.isbn = ist.issued_book_isbn
					 Left Join 
					  return_id as rs
					   On rs.issued_id = ist.issued_id
							   Where 
							    rs.return_date is null
								And 
								(current_date - ist.issued_date) > 30
								order by 1
--
/*
 Q14: Update Book Status on Return
Write a query to update the status of books in the books table to "Yes" when they are returned (based on entries in the return_status table).
*/


	SELECT * FROM issued_emp_id	
     Where issued_book_isbn = '978-0-451-52994-2';
	 
	ALTER TABLE issued_emp_id	
     ALTER COLUMN issued_book_isbn TYPE VARCHAR(20);
	 

	 Select * From books
	  Where isbn = '978-0-451-52994-2';

	  Update books
	  Set status = 'No'
	  Where isbn = '978-0-451-52994-2'

	Select * From return_id
	Where issued_id = 'IS130'

--

	Insert Into return_id(return_id, issued_id, return_date, book_quality )
	Values('RS125','IS130', Current_date, 'Good')


	 Update books
	  Set status = 'Yes'
	  Where isbn = '978-0-451-52994-2'

-- Store Procedures

   CREATE OR REPLACE PROCEDURE add_return_records(p_return_id Varchar(10), p_issued_id Varchar(10), p_book_quality Varchar(15))

   LANGUAGE plpgsql
   AS $$

   DECLARE
     v_isbn Varchar(20);
	 v_book_name Varchar(60);
   BEGIN
      Insert Into return_id(return_id, issued_id, return_date, book_quality )
		Values( p_return_id, p_issued_id , Current_date, p_book_quality );

		SELECT 
		issued_book_isbn,
		issued_book_name
		into 
		v_isbn,
		v_book_name
		From issued_emp_id
		Where issued_id = p_issued_id;

	Update books
	  Set status = 'yes'
	  Where isbn = 'v_isbn';
	 

	  Raise Notice 'Thank you For Returning book %',v_book_name;
   END
   $$

   -- calling function
   
	  call add_return_records('RS138', 'IS135', 'Good');

	  CALL add_return_records('RS148', 'IS140', 'Good');


	 
		SELECT * FROM books
		where isbn = '978-0-330-25864-8'
		
		
		SELECT * FROM issued_emp_id
		where issued_id = 'IS140'
		
		
		SELECT * FROM return_id
		where return_id = 'RS138'

/*
Q 15: Create a query that generates a performance report for each branch, 
showing the number of books issued, the number of books returned, 
and the total revenue generated from book rentals.		
		*/

	CREATE TABLE branch_report
	AS
	Select
	b.branch_id,
	b.manager_id,
	count(ist.issued_id) as num_of_books_issued,
	count(rs.return_id) as num_of_return_book,
	sum(bk.rental_price) as total_revenue
		
		From issued_emp_id as ist
	
			join
			emp_id as e
			on 
			e.emp_id = ist.issued_emp_id 
			
			join 
			branch as b
			on
			b.branch_id = e.branch_id
			
			join
			return_id as rs 
			on 
			rs.issued_id = ist.issued_id
			
			join books as bk
			on 
			ist.issued_book_isbn = bk.isbn
			Group By 1, 2;
			
	Select * From branch_report;

/*
Q16- Use the CREATE TABLE AS (CTAS) statement to 
create a new table active_members containig menmbers who have issued 
at least one book in the last 2 months.	*/

   Create table active_members
   as
     select * from members
	where member_id in ( select 
	   distinct issued_member_id
	 from issued_emp_id
	 where issued_date >= current_date - interval '2 month' );

	 select * from active_members ;


/*17: Find Employees with the Most Book Issues Processed
Write a query to find the top 3 employees who have processed the most book issues. 
Display the employee name, number of books processed, and their branch.*/

SELECT * FROM emp_id;
SELECT * FROM issued_emp_id;
SELECT * FROM branch;

	select
	emp_name,
	count(ist.issued_id) as num_of_books_issued,
	b.*
	From emp_id as e
		 join issued_emp_id as ist
		on
		ist.issued_emp_id = e.emp_id 

		join branch as b
		on 
		e.branch_id = b.branch_id
		group by 1,3
		order by 2 desc
		limit 3

 /*Task 18: Identify Members Issuing High-Risk Books
	Write a query to identify members who have issued books with the 
	status "damaged" in the books table. Display the member name, book title, and the 
	number of times they've issued damaged books.*/	

			  SELECT 
			   m.member_name,
			   bk.book_title,
			   Count(ist.issued_member_id) as no_of_issued_book,
			   r.book_quality
			   
			  FROM issued_emp_id as ist
			  join books as bk
			  on 
			  ist.issued_book_isbn = bk.isbn
			
			  Join members as m
			  on 
			  ist.issued_member_id = m.member_id
			
			  join return_id as r
			  on 
			  ist.issued_id = r.issued_id
			
			  Where r.book_quality = 'Damaged'
			
			  
				Group by 1, 2, 4
				having count(ist.issued_member_id) <= 1
				order by 3;

	/* 19	Alternate question for Q-18
	Write a query to identify books with a rental price greater than 7 that were issued more than 1 times. Display:
	
	Book title
	Category
	Rental price
	Total issue count*/

	  Select 
	  b.book_title,
	  b.category,
	  b.rental_price,
	  count(ist.issued_member_id) as Total_issued_count
	  From issued_emp_id as ist
	  left join books as b
	  on
	  ist.issued_book_isbn = b.isbn
	
	    Where b.rental_price <7
		
	  Group by 1, 2, 3 
	  having count(ist.issued_member_id) >1 
	  order by 4;
  


 /* 20 Write a query to identify members who issued books whose status is 'No'.
   Display:
   Member name
	Book title
	Status
	Issue date*/

	select 
	m.member_name,
	b.book_title,
	b.status,
	ist.issued_date
	
	from issued_emp_id as ist
	join books as b
	on 
	 ist.issued_book_isbn = b.isbn
	join members as m
	 on
	 ist.issued_member_id = m.member_id

	 where b.status = 'no'

	 group by 1, 2, 3, 4;


/* Q-21 Write a query to identify which author’s books were issued the most.
Display:
Author name
Total books issued
Total distinct book titles*/	 
	
	select  b.author,
	count(issued_book_isbn) as total_book_issued,
	COUNT(DISTINCT b.book_title) as total_distinct_book_title
	from issued_emp_id as ist
	join books as b
	on 
	ist.issued_book_isbn = b.isbn

	group by 1
	order by 2, 3;

	
/* Task 19: Stored Procedure Objective: Create a stored procedure to manage the
status of books in a library system. Description: Write a stored procedure that
updates the status of a book in the library based on its issuance. The procedure 
should function as follows: The stored procedure should take the book_id as an 
input parameter. The procedure should first check if the book is 
available (status = 'yes'). If the book is available, it should be issued, 
and the status in the books table should be updated to 'no'. If the book is 
not available (status = 'no'), the procedure should return an error message
indicating that the book is currently not available.*/
	select * from issued_emp_id
	select* from books
	
create or replace procedure 

		issue_book(p_issued_id varchar(10),
		p_issued_member_id varchar(17), 
		p_issued_book_isbn varchar(20), 
		p_issued_emp_id varchar(15))


language plpgsql
As $$

declare
    v_status varchar(5);

begin
   Select status 
   into v_status 
   From books
   where isbn = p_issued_book_isbn;
   
   If 
   
		   v_status = 'yes' Then
		     Insert into 
			 issued_emp_id(issued_id, issued_member_id, issued_date, issued_book_isbn, issued_emp_id)
			 Values 
			 (p_issued_id , p_issued_member_id , Current_date, p_issued_book_isbn , p_issued_emp_id );

			  Update books
				  Set status = 'no'
				  Where isbn = 'issued_book_isbn';
		
			 Raise Notice 'Book Record added successfully for book isbn : %', p_issued_book_isbn;

else--

          Raise Notice 'sorry book_isbn is not available: %', p_issued_book_isbn;

	End If;	  

	

end;
$$;

CALL issue_book('IS155', 'C108', '978-0-553-29698-2', 'E104');
CALL issue_book('IS156', 'C108', '978-0-375-41398-8', 'E104');

SELECT * FROM books
WHERE isbn = '978-0-375-41398-8'