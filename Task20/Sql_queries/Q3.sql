-- **Q3.** Display the total number of books written by each author, ordered by count (descending).

SELECT a."AuthorName", COUNT(*) AS "Number of books written" 
FROM books b JOIN authors a ON b."AuthorID"=a."AuthorID" 
GROUP BY a."AuthorName" ORDER BY "Number of books written" DESC ;

