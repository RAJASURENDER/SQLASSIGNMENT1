create database SIS---student information system

USE SIS;

CREATE TABLE Students (
  student_id INT NOT NULL ,
  first_name VARCHAR(255) NOT NULL, 
  last_name VARCHAR(255) NOT NULL,
  date_of_birth date not null,
  email VARCHAR(255) NOT NULL,
  phone VARCHAR(255) NOT NULL,
  PRIMARY KEY (student_id),
  
);

CREATE TABLE Courses (
  course_id INT NOT NULL ,
  course_name VARCHAR(255) NOT NULL,
  credits INT NOT NULL,
  teacher_id INT NOT NULL,
  PRIMARY KEY (course_id),
  FOREIGN KEY (teacher_id) REFERENCES Teacher(teacher_id)
);

CREATE TABLE Enrollments
(
  enrollment_id  INT NOT NULL ,
  student_id INT NOT NULL,
  course_id INT NOT NULL,
  enrollment_date DATE NOT NULL,
  PRIMARY KEY (enrollment_id),
  FOREIGN KEY (student_id) REFERENCES Students(student_id),
  FOREIGN KEY (course_id) REFERENCES Courses (course_id)
);

CREATE TABLE Teacher
 (
  teacher_id INT NOT NULL ,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255)  NOT NULL,
  email VARCHAR(255) NOT NULL,
  PRIMARY KEY (teacher_id)
);

CREATE TABLE Payments
(
  payment_id INT NOT NULL ,
  student_id INT NOT NULL,
  amount INT NOT NULL,
  payment_date DATE NOT NULL,
  PRIMARY KEY (payment_id),
  FOREIGN KEY (student_id) REFERENCES Students(student_id)
);

----------------------------------------------------------------------------------
INSERT INTO STUDENTS
VALUES(100,'virat','khoili','2/20/2000','virat@gmail.com',9879876666),
(101,'MS','Dhoni','7/7/2000','ms@gmail.com',9879876667),
(103,'Rohit','Sharma','3/20/2000','rohit@gmail.com',9879876668),
(104,'Rahul','KL','2/2/2000','rahul@gmail.com',9979876669),
(105,'ben','stokes','2/14/2000','ben@gmail.com',9879876676),
(106,'sam','curran','2/23/2001','sam@gmail.com',8879876666),
(107,'ashwin','R','2/3/2002','ashwin@gmail.com',8889776666),
(108,'kuldeep','yadav','8/23/2001','yadav@gmail.com',7879876666),
(109,'shreyas','iyer','2/23/2003','iyer@gmail.com',7979876666),
(110,'jasprit','bumrah','2/13/2002','pacer@gmail.com',7679876666)

INSERT INTO Teacher
VALUES(200,'sachin','Tendulkar','sachin@gmail.com'),
(201,'Ricky','Pointing','ricky@gmail.com'),
(202,'Rahul','Dravid','dravid@gmail.com'),(203,'Chris','Gayle','chris@gmail.com'),
(204,'AB','Devillers','abd@gmail.com'),(205,'suresh','raina','raina@gmail.com'),
(206,'brendon','mccullum','brendon@gmail.com'),(207,'lasith','malinga','malinga@gmail.com'),
(208,'Gil','Christ','gil@gmail.com'),(209,'shane','watson','shane@gmail.com')

INSERT INTO Courses
VALUES(1,'english',4,200),(2,'maths',4,201),(3,'python',4,202),(4,'java',4,203),(5,'c',4,204),
(6,'Mysql',3,205),(7,'html',3,206),(8,'css',3,207),(9,'angular',3,208),(10,'react',3,209)

INSERT INTO Enrollments
VALUES(300,100,1,'11/29/2023'),(301,101,2,'11/29/2023'),(302,110,3,'11/30/2023'),(303,103,4,'11/9/2023'),
(304,104,5,'11/2/2023'),(305,105,6,'11/4/2023'),(306,106,7,'12/9/2023'),(307,107,8,'11/23/2023'),
(308,108,9,'10/29/2023'),(309,109,10,'10/29/2023')

INSERT INTO Payments
VALUES(1000,100,200,'11/29/2023'),(1001,101,200,'11/29/2023'),(1002,110,300,'11/30/2023'),
(1003,103,300,'11/9/2023'),(1004,104,300,'11/2/2023'),(1005,105,400,'11/4/2023'),
(1006,106,400,'12/9/2023'),(1007,107,400,'11/23/2023'),(1008,108,400,'11/29/2023'),
(1009,109,500,'12/29/2023')

-------------------------------------------------------------------------------------------------------


--1. Write an SQL query to insert a new student into the "Students" table with the following details:
--a. First Name: John b. Last Name: Doe c. Date of Birth: 1995-08-15 d. Email: john.doe@example.com e. Phone Number: 1234567890

INSERT INTO Students
VALUES(111,'John','Doe','1995-08-15','john.doe@example.com',1234567890)

--2. Write an SQL query to enroll a student in a course. Choose an existing student and course and
--insert a record into the "Enrollments" table with the enrollment date.

INSERT INTO Enrollments 
VALUES (311,101, 5, '2023-11-29');

--3. Update the email address of a specific teacher in the "Teacher" table. Choose any teacher and
--modify their email address.

Update Teacher
SET	email='change@gmail.com' where teacher_id= 209

--4. Write an SQL query to delete a specific enrollment record from the "Enrollments" table. Select
--an enrollment record based on student and course.

DELETE FROM Enrollments
WHERE student_id = 101 AND course_id = 2;

--5. Update the "Courses" table to assign a specific teacher to a course. Choose any course and
--teacher from the respective tables.

UPDATE Courses
SET  course_id=1 where teacher_id=200

--6. Delete a specific student from the "Students" table and remove all their enrollment records
--from the "Enrollments" table. Be sure to maintain referential integrity.

DELETE FROM Enrollments where student_id=108
DELETE FROM Payments where student_id=108
DELETE FROM Students where student_id=108

--7. Update the payment amount for a specific payment record in the "Payments" table. Choose any
--payment record and modify the payment amount.

UPDATE Payments
SET amount=1000 where   payment_id=1009

----------------------------JOINS---------------------------------------------------------------
--1. Write an SQL query to calculate the total payments made by a specific student. You will need to
--join the "Payments" table with the "Students" table based on the student's ID

SELECT  s.student_id,s.first_name,SUM(p.amount) as total_payments
from Students s join Payments p on s.student_id=p.student_id
where s.student_id=103
group by s.student_id,s.first_name

--2. Write an SQL query to retrieve a list of courses along with the count of students enrolled in each
--course. Use a JOIN operation between the "Courses" table and the "Enrollments" table.

select c.course_name,count(e.student_id) as enrolled
from Courses c join Enrollments e on c.course_id=e.course_id
where c.course_id=1

--3.Write an SQL query to find the names of students who have not enrolled in any course. Use a
--LEFT JOIN between the "Students" table and the "Enrollments" table to identify students
--without enrollments.

select s.first_name, count(e.student_id) as enroll
from Students s left join Enrollments e on s.student_id=e.student_id
where e.student_id<1
group by s.first_name, e.student_id

---4. Write an SQL query to retrieve the first name, last name of students, and the names of the 
--courses they are enrolled in. Use JOIN operations between the "Students" table and the 
--"Enrollments" and "Courses" tables

select s.first_name,s.last_name, c.course_name  from Students s 
join Enrollments e on s.student_id=e.student_id
join Courses c on c.course_id=e.course_id

--5. Create a query to list the names of teachers and the courses they are assigned to. Join the 
--"Teacher" table with the "Courses" table

select t.first_name,t.last_name, c.course_name  from Teacher t 
join Courses c on c.teacher_id=t.teacher_id

--6. Retrieve a list of students and their enrollment dates for a specific course. You'll need to join the 
--"Students" table with the "Enrollments" and "Courses" tables

select s.first_name,s.last_name, e.enrollment_date  from Students s 
join Enrollments e on s.student_id=e.student_id

--7. Find the names of students who have not made any payments. Use a LEFT JOIN between the 
--"Students" table and the "Payments" table and filter for students with NULL payment records

select s.first_name,s.last_name from Students s 
LEFT JOIN Payments p ON s.student_id = p.student_id
WHERE amount IS NULL

--8. Write a query to identify courses that have no enrollments. You'll need to use a LEFT JOIN 
--between the "Courses" table and the "Enrollments" table and filter for courses with NULL 
--enrollment records.

SELECT course_name FROM courses c
LEFT JOIN enrollments e
ON c.course_id = e.course_id WHERE e.course_id IS NULL;

--9. Identify students who are enrolled in more than one course. Use a self-join on the "Enrollments" 
--table to find students with multiple enrollment records.

select distinct s.student_id,s.first_name,s.last_name from Enrollments e1
join Enrollments e2 on e1.student_id=e2.student_id
AND e1.enrollment_id<>e2.enrollment_id
join Students s on e1.student_id=e2.student_id



--10. Find teachers who are not assigned to any courses. Use a LEFT JOIN between the "Teacher" 
-- and the "Courses" table and filter for teachers with NULL course assignments.

SELECT t.first_name FROM Teacher t
LEFT JOIN courses c
ON t.teacher_id = c.teacher_id WHERE t.teacher_id IS NULL

-----------------------------Aggregate Functions and Subqueries:-----------------------------

--1. Write an SQL query to calculate the average number of students enrolled in each course. Use 
--   aggregate functions and subqueries to achieve this

Select Courses.course_name from Courses


--2. Identify the student(s) who made the highest payment. Use a subquery to find the maximum 
--payment amount and then retrieve the student(s) associated with that amount

select first_name, last_name from Students 
where student_id=(select student_id from Payments
where amount=(select max(amount) from Payments))

-- 3. Retrieve a list of courses with the highest number of enrollments. Use subqueries to find the 
--course(s) with the maximum enrollment count.
select top 2 Courses.course_name,(select count(Enrollments.student_id) 
from Enrollments
where Enrollments.course_id=Courses.course_id) as Enrolled_student 
from Courses 
order by Enrolled_student desc 


--4. Calculate the total payments made to courses taught by each teacher. Use subqueries to sum payments for each teacher's courses
select course_name,(select sum(amount) from Payments p
where p.student_id in (select student_id from Enrollments e
where e.course_id = c.course_id)) as total_payment from Courses c;

--5. Identify students who are enrolled in all available courses. Use subqueries to compare a student's enrollments with the 
--total number of courses.
select Students.first_name from Students 
where Students.student_id in (select Enrollments.student_id from Enrollments group by
Enrollments.student_id 
having count(distinct Enrollments.course_id)=(select count(*) from Courses))

--6. Retrieve the names of teachers who have not been assigned to any courses. Use subqueries to 
--find teachers with no course assignment
select Teacher.first_name from Teacher 
where Teacher.teacher_id not in (select Courses.teacher_id from Courses)

--7. Calculate the average age of all students. Use subqueries to calculate the age of each student 
--based on their date of birth.
select avg(DATEDIFF(year,Students.date_of_birth,getdate())) from Students

--8. Identify courses with no enrollments.
--Use subqueries to find courses without enrollment records.select Courses.course_name from Courses where Courses.course_id not in (select Enrollments.course_id from
--Enrollments)
select course_id, course_name,(select avg(enrollment_count) 
from (select count(student_id) as enrollment_count 
from Enrollments e where e.course_id = c.course_id 
group by e.course_id) as CourseEnrollment) as average_students_enrolled
from Courses c;

--9. Calculate the total payments made by each student for each course they are enrolled in. Use 
--subqueries and aggregate functions to sum payments.
select (select Students.first_name from Students where Students.student_id= Payments.student_id),
(select Courses.course_name from Courses where Courses.course_id=Enrollments.course_id),
sum(Payments.amount) from Payments,Enrollments
where Payments.student_id=Enrollments.student_id
group by Payments.student_id,Enrollments.course_id

--10. Identify students who have made more than one payment. Use subqueries and aggregate 
--functions to count payments per student and filter for those with counts greater than one.
select (select Students.first_name from Students where Students.student_id=Payments.student_id), count(Payments.student_id)
from Payments
group by Payments.student_id
having count(Payments.student_id)>1

--11. Write an SQL query to calculate the total payments made by each student. Join the "Students" 
--table with the "Payments" table and use GROUP BY to calculate the sum of payments for each student.
select Students.first_name, sum(Payments.amount)
from Students
join Payments
on Students.student_id=Payments.student_id
group by Students.first_name

--12. Retrieve a list of course names along with the count of students enrolled in each course. Use 
--JOIN operations between the "Courses" table and the "Enrollments" table and GROUP BY to count enrollments.
select Courses.course_name , count(Enrollments.student_id) 
from Courses 
join Enrollments on Courses.course_id=
Enrollments.course_id
group by Courses.course_name

--13. Calculate the average payment amount made by students. Use JOIN operations between the 
--"Students" table and the "Payments" table and GROUP BY to calculate the average.
select Students.first_name, avg(amount) as avgpayment 
from Payments join Students on Payments.student_id=Students.student_id
group by Students.first_name
