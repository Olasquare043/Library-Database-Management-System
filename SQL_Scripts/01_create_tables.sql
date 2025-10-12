-- 1️⃣ Create ENUM types safely if they don't already exist
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'gender_enum') THEN
    CREATE TYPE gender_enum AS ENUM ('Male', 'Female', 'Other');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'membership_enum') THEN
    CREATE TYPE membership_enum AS ENUM ('Premium', 'Standard', 'Student');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'status_enum') THEN
    CREATE TYPE status_enum AS ENUM ('Active', 'Suspended');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'fulfillment_status_enum') THEN
    CREATE TYPE fulfillment_status_enum AS ENUM ('Fulfilled', 'Processing', 'Pending');
  END IF;
END
$$;

-- Drop existing tables 
DROP TABLE IF EXISTS "BorrowHistory", "Books", "Authors","BookOrders", "LibraryStaff", "Departments", "Members" CASCADE;

-- Creating the tables in dependency-safe order

-- Members
CREATE TABLE "Members" (
    "MemberID" SERIAL PRIMARY KEY,
    "Name" VARCHAR(100) NOT NULL,
    "Gender" gender_enum NOT NULL,
    "EmailAddress" VARCHAR(150) NOT NULL,
    "PhoneNumber" VARCHAR(20) NOT NULL,
    "Address" VARCHAR(200) NOT NULL,
    "Age" INTEGER NOT NULL,
    "TypeOfMembership" membership_enum NOT NULL,
    "DateOfMembership" DATE NOT NULL,
    "Status" status_enum NOT NULL
);
ALTER TABLE IF EXISTS public."Members"
    OWNER TO postgres;

-- Authors
CREATE TABLE "Authors" (
    "AuthorID" SERIAL PRIMARY KEY,
    "AuthorName" VARCHAR(25),
    "CountryOfOrigin" VARCHAR(25),
    "NumberOfBooksWritten" INT
);
ALTER TABLE IF EXISTS public."Authors"
    OWNER TO postgres;

-- Books
CREATE TABLE "Books" (
    "BookID" SERIAL PRIMARY KEY,
    "Title" VARCHAR(100) NOT NULL,
    "AuthorID" INT REFERENCES "Authors"("AuthorID"),
    "Genre" VARCHAR(50) NOT NULL,
    "DateOfPublication" DATE NOT NULL,
    "Publisher" VARCHAR(50) NOT NULL,
    "ISBN" VARCHAR(20) UNIQUE,
    "Language" VARCHAR(30),
    "AvailableCopies" INT,
    "AgeRating" VARCHAR(10)
);
ALTER TABLE IF EXISTS public."Books"
    OWNER TO postgres;

-- BorrowHistory
CREATE TABLE "BorrowHistory" (
    "BorrowHistoryID" SERIAL PRIMARY KEY,
    "BookID" INT NOT NULL REFERENCES "Books"("BookID"),
    "MemberID" INT NOT NULL REFERENCES "Members"("MemberID") ON DELETE CASCADE,
    "BorrowDate" DATE NOT NULL,
    "ReturnDate" DATE
);
ALTER TABLE IF EXISTS public."BorrowHistory"
    OWNER TO postgres;
-- BookOrders
CREATE TABLE "BookOrders" (
    "OrderID" SERIAL PRIMARY KEY,
    "OrderDate" DATE NOT NULL,
    "BookID" INT REFERENCES "Books"("BookID"),
    "Cost" DECIMAL(10, 2),
    "Quantity" INT,
    "SupplyDate" DATE,
    "FulfillmentStatus" fulfillment_status_enum NOT NULL,
    "NameOfSupplier" VARCHAR(50)
);
ALTER TABLE IF EXISTS public."BookOrders"
    OWNER TO postgres;

-- Departments
CREATE TABLE "Departments" (
    "DeptID" SERIAL PRIMARY KEY,
    "NameOfTheDepartment" VARCHAR(50) NOT NULL,
    "NameOfManager" VARCHAR(50) NOT NULL
);
ALTER TABLE IF EXISTS public."Departments"
    OWNER TO postgres;

-- LibraryStaff
CREATE TABLE "LibraryStaff" (
    "StaffID" SERIAL PRIMARY KEY,
    "Name" VARCHAR(100) NOT NULL,
    "JobTitle" VARCHAR(50) NOT NULL,
    "DepartmentID" INT REFERENCES "Departments"("DeptID"),
    "Gender" gender_enum NOT NULL,
    "Address" VARCHAR(200) NOT NULL,
    "PhoneNumber" VARCHAR(20) NOT NULL,
    "HireDate" DATE NOT NULL,
    "ManagerID" INT REFERENCES "LibraryStaff"("StaffID")
);
ALTER TABLE IF EXISTS public."LibraryStaff"
    OWNER TO postgres;
