**Q5.** List all library staff members working in the 'Circulation' department.

SELECT l."Name",l."JobTitle",l."Gender", l."Address", l."PhoneNumber"
FROM librarystaff l JOIN departments d
ON l."DepartmentID"= d."DeptID" 
WHERE d."NameOfTheDepartment"='Circulation'