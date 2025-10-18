-- **Q7.** Find the top 5 most borrowed books along with the number of times each has been borrowed.

SELECT b."Title" AS "Book Name", COUNT(br."BookID") AS "Count of Borrowed"
FROM books b JOIN borrow_history br ON b."BookID"=br."BookID" 
GROUP BY "Book Name" ORDER BY "Count of Borrowed" DESC LIMIT 5;