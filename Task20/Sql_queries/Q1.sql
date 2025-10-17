-- **Q1.** List all books published after 2015 along with their authors' names.

SELECT b."Title", b."DateOfPublication", a."AuthorName" FROM books b
JOIN  authors a ON b."AuthorID"=a."AuthorID" WHERE b."DateOfPublication" > '2016-01-01';