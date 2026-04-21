--Library Management System Project

--Creating Branch Table
Drop table if exists book;
   Create Table Books (
		  isbn	varchar(20) primary key,
		  book_title  varchar(60),
		  category	varchar(20),
		  rental_price	float,
		  status	varchar(5),
		  author	varchar(25),
		  publisher varchar(30)
);

  Drop Table If Exists branch;
     Create table branch(
     branch_id	varchar(10) Primary key,
	 manager_id	varchar(10),
	 branch_address	varchar(15),
	 contact_no varchar(15)

	 );



 Drop Table If Exists emp_id;
    Create table emp_id (
	 emp_id	 varchar(6) Primary key,
	 emp_name	varchar(17),
	 position	varchar(10),
	 salary	  int,
	 branch_id varchar(9)

	 );

 Drop Table If Exists issued_status;
   Create table issued_emp_id (
   issued_id	varchar(10) Primary Key,
   issued_member_id	varchar(17),
   issued_book_name	varchar(55),
   issued_date	date,
   issued_book_isbn	varchar(18),
   issued_emp_id  varchar(15)
);
  Alter table issued_emp_id
  Add Primary key (issued_id);
   select * 
      from issued_emp_id;
 Drop Table If Exists members;
   Create Table members (
	   member_id varchar(10) primary key,	
	   member_name	varchar(15),
	   member_address	varchar(14),
	   reg_date date
	);

		Drop table If exists return_id;
		  Create table return_id (
			  return_id	varchar (10) primary key,
			  issued_id	varchar(10),
			  return_book_name	varchar(17),
			  return_date	date,
			  return_book_isbn varchar(17)
		);


--Foreign key
  Alter Table issued_emp_id
  Add constraint fk_mambers
  Foreign Key (issued_member_id)
  References members(member_id);

    Alter Table issued_emp_id
  Add constraint fk_books
  Foreign Key (issued_book_isbn)
  References books(isbn);


  Alter Table issued_emp_id
  Add constraint fk_emp_id
  Foreign Key (issued_emp_id)
  References emp_id(emp_id);

   Alter Table emp_id
  Add constraint fk_branch
  Foreign Key (emp_id)
  References branch(branch_id);
--I'm dropping this alter constraint beacause of i want to connet this to branch_id and i have connected to emp_id
  
   ALTER TABLE emp_id
   DROP CONSTRAINT fk_branch;

--- adding new constraint

   Alter Table emp_id
  Add constraint fk_branch
  Foreign Key (branch_id)
  References branch(branch_id); --Added
  
 Alter Table return_id
  Add constraint fk_issued_emp_id
  Foreign Key (issued_id)
  References issued_emp_id(issued_id);

-- Inserting data
--1 Books

			INSERT INTO books(isbn, book_title, category, rental_price, status, author, publisher) 
			VALUES
			('978-0-553-29698-2', 'The Catcher in the Rye', 'Classic', 7.00, 'yes', 'J.D. Salinger', 'Little, Brown and Company'),
			('978-0-330-25864-8', 'Animal Farm', 'Classic', 5.50, 'yes', 'George Orwell', 'Penguin Books'),
			('978-0-14-118776-1', 'One Hundred Years of Solitude', 'Literary Fiction', 6.50, 'yes', 'Gabriel Garcia Marquez', 'Penguin Books'),
			('978-0-525-47535-5', 'The Great Gatsby', 'Classic', 8.00, 'yes', 'F. Scott Fitzgerald', 'Scribner'),
			('978-0-141-44171-6', 'Jane Eyre', 'Classic', 4.00, 'yes', 'Charlotte Bronte', 'Penguin Classics'),
			('978-0-307-37840-1', 'The Alchemist', 'Fiction', 2.50, 'yes', 'Paulo Coelho', 'HarperOne'),
			('978-0-679-76489-8', 'Harry Potter and the Sorcerers Stone', 'Fantasy', 7.00, 'yes', 'J.K. Rowling', 'Scholastic'),
			('978-0-7432-4722-4', 'The Da Vinci Code', 'Mystery', 8.00, 'yes', 'Dan Brown', 'Doubleday'),
			('978-0-09-957807-9', 'A Game of Thrones', 'Fantasy', 7.50, 'yes', 'George R.R. Martin', 'Bantam'),
			('978-0-393-05081-8', 'A Peoples History of the United States', 'History', 9.00, 'yes', 'Howard Zinn', 'Harper Perennial'),
			('978-0-19-280551-1', 'The Guns of August', 'History', 7.00, 'yes', 'Barbara W. Tuchman', 'Oxford University Press'),
			('978-0-307-58837-1', 'Sapiens: A Brief History of Humankind', 'History', 8.00, 'no', 'Yuval Noah Harari', 'Harper Perennial'),
			('978-0-375-41398-8', 'The Diary of a Young Girl', 'History', 6.50, 'no', 'Anne Frank', 'Bantam'),
			('978-0-14-044930-3', 'The Histories', 'History', 5.50, 'yes', 'Herodotus', 'Penguin Classics'),
			('978-0-393-91257-8', 'Guns, Germs, and Steel: The Fates of Human Societies', 'History', 7.00, 'yes', 'Jared Diamond', 'W. W. Norton & Company'),
			('978-0-7432-7357-1', '1491: New Revelations of the Americas Before Columbus', 'History', 6.50, 'no', 'Charles C. Mann', 'Vintage Books'),
			('978-0-679-64115-3', '1984', 'Dystopian', 6.50, 'yes', 'George Orwell', 'Penguin Books'),
			('978-0-14-143951-8', 'Pride and Prejudice', 'Classic', 5.00, 'yes', 'Jane Austen', 'Penguin Classics'),
			('978-0-452-28240-7', 'Brave New World', 'Dystopian', 6.50, 'yes', 'Aldous Huxley', 'Harper Perennial'),
			('978-0-670-81302-4', 'The Road', 'Dystopian', 7.00, 'yes', 'Cormac McCarthy', 'Knopf'),
			('978-0-385-33312-0', 'The Shining', 'Horror', 6.00, 'yes', 'Stephen King', 'Doubleday'),
			('978-0-451-52993-5', 'Fahrenheit 451', 'Dystopian', 5.50, 'yes', 'Ray Bradbury', 'Ballantine Books'),
			('978-0-345-39180-3', 'Dune', 'Science Fiction', 8.50, 'yes', 'Frank Herbert', 'Ace'),
			('978-0-375-50167-0', 'The Road', 'Dystopian', 7.00, 'yes', 'Cormac McCarthy', 'Vintage'),
			('978-0-06-025492-6', 'Where the Wild Things Are', 'Children', 3.50, 'yes', 'Maurice Sendak', 'HarperCollins'),
			('978-0-06-112241-5', 'The Kite Runner', 'Fiction', 5.50, 'yes', 'Khaled Hosseini', 'Riverhead Books'),
			('978-0-06-440055-8', 'Charlotte''s Web', 'Children', 4.00, 'yes', 'E.B. White', 'Harper & Row'),
			('978-0-679-77644-3', 'Beloved', 'Fiction', 6.50, 'yes', 'Toni Morrison', 'Knopf'),
			('978-0-14-027526-3', 'A Tale of Two Cities', 'Classic', 4.50, 'yes', 'Charles Dickens', 'Penguin Books'),
			('978-0-7434-7679-3', 'The Stand', 'Horror', 7.00, 'yes', 'Stephen King', 'Doubleday'),
			('978-0-451-52994-2', 'Moby Dick', 'Classic', 6.50, 'yes', 'Herman Melville', 'Penguin Books'),
			('978-0-06-112008-4', 'To Kill a Mockingbird', 'Classic', 5.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.'),
			('978-0-553-57340-1', '1984', 'Dystopian', 6.50, 'yes', 'George Orwell', 'Penguin Books'),
			('978-0-7432-4722-5', 'Angels & Demons', 'Mystery', 7.50, 'yes', 'Dan Brown', 'Doubleday'),
			('978-0-7432-7356-4', 'The Hobbit', 'Fantasy', 7.00, 'yes', 'J.R.R. Tolkien', 'Houghton Mifflin Harcourt')
			

	Select * From books;

--2 Branch
           INSERT INTO branch(branch_id, manager_id, branch_address, contact_no) 
				VALUES
				('B001', 'E109', '123 Main St', '+919099988676'),
				('B002', 'E109', '456 Elm St', '+919099988677'),
				('B003', 'E109', '789 Oak St', '+919099988678'),
				('B004', 'E110', '567 Pine St', '+919099988679'),
				('B005', 'E110', '890 Maple St', '+919099988680');
				SELECT * FROM branch;

--3 emp_id
          INSERT INTO emp_id(emp_id, emp_name, position, salary, branch_id) 
				VALUES
				('E101', 'John Doe', 'Clerk', 60000.00, 'B001'),
				('E102', 'Jane Smith', 'Clerk', 45000.00, 'B002'),
				('E103', 'Mike Johnson', 'Librarian', 55000.00, 'B001'),
				('E104', 'Emily Davis', 'Assistant', 40000.00, 'B001'),
				('E105', 'Sarah Brown', 'Assistant', 42000.00, 'B001'),
				('E106', 'Michelle Ramirez', 'Assistant', 43000.00, 'B001'),
				('E107', 'Michael Thompson', 'Clerk', 62000.00, 'B005'),
				('E108', 'Jessica Taylor', 'Clerk', 46000.00, 'B004'),
				('E109', 'Daniel Anderson', 'Manager', 57000.00, 'B003'),
				('E110', 'Laura Martinez', 'Manager', 41000.00, 'B005'),
				('E111', 'Christopher Lee', 'Assistant', 65000.00, 'B005');
				SELECT * FROM emp_id;


--4 issued_emp_id
        INSERT INTO issued_emp_id(issued_id, issued_member_id, issued_book_name, issued_date, issued_book_isbn, issued_emp_id) 
			VALUES
			('IS106', 'C106', 'Animal Farm', '2024-03-10', '978-0-330-25864-8', 'E104'),
			('IS107', 'C107', 'One Hundred Years of Solitude', '2024-03-11', '978-0-14-118776-1', 'E104'),
			('IS108', 'C108', 'The Great Gatsby', '2024-03-12', '978-0-525-47535-5', 'E104'),
			('IS109', 'C109', 'Jane Eyre', '2024-03-13', '978-0-141-44171-6', 'E105'),
			('IS110', 'C110', 'The Alchemist', '2024-03-14', '978-0-307-37840-1', 'E105'),
			('IS111', 'C109', 'Harry Potter and the Sorcerers Stone', '2024-03-15', '978-0-679-76489-8', 'E105'),
			('IS112', 'C109', 'A Game of Thrones', '2024-03-16', '978-0-09-957807-9', 'E106'),
			('IS113', 'C109', 'A Peoples History of the United States', '2024-03-17', '978-0-393-05081-8', 'E106'),
			('IS114', 'C109', 'The Guns of August', '2024-03-18', '978-0-19-280551-1', 'E106'),
			('IS115', 'C109', 'The Histories', '2024-03-19', '978-0-14-044930-3', 'E107'),
			('IS116', 'C110', 'Guns, Germs, and Steel: The Fates of Human Societies', '2024-03-20', '978-0-393-91257-8', 'E107'),
			('IS117', 'C110', '1984', '2024-03-21', '978-0-679-64115-3', 'E107'),
			('IS118', 'C101', 'Pride and Prejudice', '2024-03-22', '978-0-14-143951-8', 'E108'),
			('IS119', 'C110', 'Brave New World', '2024-03-23', '978-0-452-28240-7', 'E108'),
			('IS120', 'C110', 'The Road', '2024-03-24', '978-0-670-81302-4', 'E108'),
			('IS121', 'C102', 'The Shining', '2024-03-25', '978-0-385-33312-0', 'E109'),
			('IS122', 'C102', 'Fahrenheit 451', '2024-03-26', '978-0-451-52993-5', 'E109'),
			('IS123', 'C103', 'Dune', '2024-03-27', '978-0-345-39180-3', 'E109'),
			('IS124', 'C104', 'Where the Wild Things Are', '2024-03-28', '978-0-06-025492-6', 'E110'),
			('IS125', 'C105', 'The Kite Runner', '2024-03-29', '978-0-06-112241-5', 'E110'),
			('IS126', 'C105', 'Charlotte''s Web', '2024-03-30', '978-0-06-440055-8', 'E110'),
			('IS127', 'C105', 'Beloved', '2024-03-31', '978-0-679-77644-3', 'E110'),
			('IS128', 'C105', 'A Tale of Two Cities', '2024-04-01', '978-0-14-027526-3', 'E110'),
			('IS129', 'C105', 'The Stand', '2024-04-02', '978-0-7434-7679-3', 'E110'),
			('IS130', 'C106', 'Moby Dick', '2024-04-03', '978-0-451-52994-2', 'E101'),
			('IS131', 'C106', 'To Kill a Mockingbird', '2024-04-04', '978-0-06-112008-4', 'E101'),
			('IS132', 'C106', 'The Hobbit', '2024-04-05', '978-0-7432-7356-4', 'E106'),
			('IS133', 'C107', 'Angels & Demons', '2024-04-06', '978-0-7432-4722-5', 'E106'),
			('IS134', 'C107', 'The Diary of a Young Girl', '2024-04-07', '978-0-375-41398-8', 'E106'),
			('IS135', 'C107', 'Sapiens: A Brief History of Humankind', '2024-04-08', '978-0-307-58837-1', 'E108'),
			('IS136', 'C107', '1491: New Revelations of the Americas Before Columbus', '2024-04-09', '978-0-7432-7357-1', 'E102'),
			('IS137', 'C107', 'The Catcher in the Rye', '2024-04-10', '978-0-553-29698-2', 'E103'),
			('IS138', 'C108', 'The Great Gatsby', '2024-04-11', '978-0-525-47535-5', 'E104'),
			('IS139', 'C109', 'Harry Potter and the Sorcerers Stone', '2024-04-12', '978-0-679-76489-8', 'E105'),
			('IS140', 'C110', 'Animal Farm', '2024-04-13', '978-0-330-25864-8', 'E102');
              Select * From issued_emp_id


--5 Members	

         INSERT INTO members(member_id, member_name, member_address, reg_date) 
			VALUES
			('C101', 'Alice Johnson', '123 Main St', '2021-05-15'),
			('C102', 'Bob Smith', '456 Elm St', '2021-06-20'),
			('C103', 'Carol Davis', '789 Oak St', '2021-07-10'),
			('C104', 'Dave Wilson', '567 Pine St', '2021-08-05'),
			('C105', 'Eve Brown', '890 Maple St', '2021-09-25'),
			('C106', 'Frank Thomas', '234 Cedar St', '2021-10-15'),
			('C107', 'Grace Taylor', '345 Walnut St', '2021-11-20'),
			('C108', 'Henry Anderson', '456 Birch St', '2021-12-10'),
			('C109', 'Ivy Martinez', '567 Oak St', '2022-01-05'),
			('C110', 'Jack Wilson', '678 Pine St', '2022-02-25'),
			('C118', 'Sam', '133 Pine St', '2024-06-01'),    
			('C119', 'John', '143 Main St', '2024-05-01');
				SELECT * FROM members;


--6 return_id

       INSERT INTO return_id(return_id, issued_id, return_date) 
		VALUES
		
		('RS105', 'IS107', '2024-05-03'),
		('RS104', 'IS106', '2024-05-01'),
		('RS106', 'IS108', '2024-05-05'),
		('RS107', 'IS109', '2024-05-07'),
		('RS108', 'IS110', '2024-05-09'),
		('RS109', 'IS111', '2024-05-11'),
		('RS110', 'IS112', '2024-05-13'),
		('RS111', 'IS113', '2024-05-15'),
		('RS112', 'IS114', '2024-05-17'),
		('RS113', 'IS115', '2024-05-19'),
		('RS114', 'IS116', '2024-05-21'),
		('RS115', 'IS117', '2024-05-23'),
		('RS116', 'IS118', '2024-05-25'),
		('RS117', 'IS119', '2024-05-27'),
		('RS118', 'IS120', '2024-05-29');

	Select * From return_id


--Projects Task

    ---CRUD Operations
	
	---Q1 Create a New Book Record -- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"

      Insert Into books(isbn, book_title, category, rental_price, status, author, publisher)
	   Values
      ('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');
	  Select * from books


	---Q2 Update an Existing Member's Address

		
		Update members
		Set member_address = '124 Chowk St'
		Where member_id = 'C101'

		Select * from members

	---Q3 Delete a Record from the Issued_emp_id Table -- Objective: Delete the record with issued_id = 'IS121' from the issued_emp_id table.

	     
		 Delete From issued_emp_id
		 Where issued_id = 'IS121'
		 Select * from issued_emp_id
		 where issued_id = 'IS121'

	---Q4 Retrieve All Books Issued by a Specific emp_id -- Objective: Select all books issued by the employee with emp_id = 'E101'

	  Select * From emp_id
	  Where emp_id = 'E101' ;
    
	---Q5 List Members Who Have Issued More Than One Book -- Objective: Find members who have issued more than one book.

	   Select 
	    issued_emp_id,
		count(issued_id) as total_book_issued
	   From issued_emp_id
	   Group By 1
	   Having count(issued_id) > 1

	 ---CTAS(Create Table As Select)

	---Q6 Create Summary Tables: Used CTAS to generate new tables based on query results - each book and total book_issued_count

         Create Table  book_count 
		 As
		 Select 
		   b.isbn,
		   b.book_title,
		   Count(ist.issued_id) as no_issued
		 from books as b
		 Join 
		 Issued_emp_id as ist
		 On ist.issued_book_isbn = b.isbn
	 
	   Group By 1,2;
       Select * From book_count

	--- Q7 Retrieve All Books in a Specific Category:

	    Select * From books
		Where category = 'Classic'

	---Q8 Find Total Rental Income by Category:

	   Select 
	     b.category,
		 Sum(b.rental_price)
		-- Count(*)
	   From books as b
	   Join 
	   issued_emp_id as ist
	   On ist.issued_book_isbn = b.isbn 
	   Group By 1

	---Q9 List Members Who Registered in the Last 180 Days:

		Select * From members
		Where reg_date >= Current_date - Interval '180 days';

	---Q10 List Employees with Their Branch Manager's Name and their branch details:

	   Select 
	     e1.*,
		 b.manager_id,
		 e2.emp_name As manager
	   From emp_id as e1
	   Join
	   branch as b
	   On b.branch_id = e1.branch_id
	   Join 
	   emp_id as e2
	   On b.manager_id = e2.emp_id

	---Q11  Create a Table of Books with Rental Price Above a Certain Threshold 7USD:

	  Create Table rental_table
	  as
	  Select * from books
	   Where rental_price > 7

	   Select * From rental_table

    ---Q12 Retrieve the List of Books Not Yet Returned

	   Select 
	    ist.issued_book_name
	   From issued_emp_id As ist
	   Left Join
	   return_id As rs
	   On ist.issued_id = rs.issued_id
	   Where rs.return_id is Null
	   