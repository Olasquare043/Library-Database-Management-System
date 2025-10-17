-- **Q4.** Show all currently borrowed books (books with no return date) 
-- along with the member's name and borrow date.

SELECT m."Name" AS "Member Name", b."Title" 
AS "Book Borrowed", br."BorrowDate" FROM borrow_history br 
JOIN members m ON br."MemberID"=m."MemberID" 
JOIN books b ON br."BookID"=b."BookID" WHERE br."ReturnDate" is null;