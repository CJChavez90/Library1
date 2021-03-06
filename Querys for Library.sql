USE [db_library1]
/*1. How many copies of the book titled "The Lost Tribe" are owned by the library branch whose name is "Sharpstown"?*/

Select No_of_Copies from tbl_book_copies
where branch_id = 301 and book_id = 1;

/*2. How many copies of the book titled "The Lost Tribe" are owned by each library branch?*/

select No_of_copies, Branch_id from tbl_book_copies
where book_id = 1

/*3. Retrieve the names of all borrowers who do not have any books checked out.*/

select Name from tbl_borrower
WHERE Card_No not in (SELECT Card_No FROM tbl_book_loans);

/*4. For each book that is loaned out from the "Sharpstown" branch and whose DueDate is today, 
retrieve the book title, the borrower's name, and the borrower's address.*/

Select tbl_Book.Title, tbl_Borrower.Name, tbl_Borrower.Address
From (((tbl_Book
Inner Join tbl_Book_Loans On tbl_book.Book_id = tbl_Book_loans.Book_id)
Inner Join tbl_Borrower On tbl_Book_Loans.Card_no = tbl_Borrower.Card_No)
Inner Join tbl_library_branch On tbl_Book_Loans.Branch_id = tbl_library_branch.Branch_id)
Where tbl_Library_Branch.Branch_id = 301 And tbl_Book_Loans.Due_Date = '2018-03-10'

/*5. For each library branch, retrieve the branch name and the total number of books loaned out from that branch.*/

SELECT tbl_library_branch.Branch_Name, count(tbl_book_loans.Branch_id) as 'Total Loans' 
FROM tbl_library_branch
Inner Join tbl_book_loans on tbl_library_branch.branch_id = tbl_book_loans.branch_id
GROUP BY Branch_Name

/*7. For each book authored (or co-authored) by "Stephen King", retrieve the title and the number of 
copies owned by the library branch whose name is "Central".*/

Select tbl_book_authors.Author_Name, tbl_book.Title, tbl_book_copies.No_of_Copies, tbl_library_branch.Branch_Name
From tbl_book_authors
Inner Join tbl_book on tbl_book_authors.Book_id = tbl_book.Book_id
Inner Join tbl_book_copies on tbl_book_authors.Book_id = tbl_book_copies.Book_id
Inner Join tbl_library_branch on tbl_book_copies.Branch_id = tbl_library_branch.Branch_id
where tbl_book_authors.Author_Name = 'Stephen King' and tbl_library_branch.Branch_id = 302

/*6. Retrieve the names, addresses, and number of books checked out for all borrowers who have more than five books checked out.*/

Select Count(tbl_book_loans.Card_No) as CheckedOut, Name, Address
From tbl_book_loans
Inner Join tbl_borrower on tbl_book_loans.Card_No = tbl_borrower.Card_No
Group By tbl_book_loans.Card_No, Name, Address
Having Count(tbl_book_loans.Card_No) >5
