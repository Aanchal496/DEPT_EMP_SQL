select * from dept;
select * from emp;

/* Display all the employees who are getting 2500 and excess salaries in department 20.*/
select emp_no, dept_no, ename, sal
from emp
where dept_no = 20 and sal >=2500;

/*Display all the managers working in 20 & 30 department.*/
select emp_no, dept_no, ename, sal
from emp
where dept_no in (20,30);


/*Display all the employees who are getting some commission with their designation is 
neither MANANGER nor ANALYST*/
select emp_no, ename, job, comm
from emp
where job not in ('manager','analyst') and comm is not null ;

/*Display all the managers whose name doesn’t ends with ‘S’ */
select emp_no, job, ename
from emp 
where job = 'manager' and ename not regexp "S$";

/* Display all the employees whose naming is having letter ‘E’ as the last but one character*/
select emp_no, job, ename
from emp 
where ename like "%e";


/*Display all the employees who total salary is more than 2000.
(Total Salary = Sal + Comm)*/
select emp_no, ename, sal, comm
from emp where (sal+comm)>2000;

select emp_no, ename, sal, comm, sum(sal+comm) as tsal
from emp 
group by emp_no
having sum(sal+comm) >= 2500;


/* Display all the employees who are getting some commission in department 20 & 30.*/
select emp_no, ename, dept_no, comm
from emp
where dept_no in (20,30) and comm is not null ;

/* Display all the managers whose name doesn't start with A & S*/
select emp_no, job, ename
from emp 
where job ='manager' and ename not like "s%" or "a%";


/* Display all the employees whose name doesn't start with A & S*/
select emp_no, job, ename
from emp 
where ename not regexp "[as]";


/* Display all the employees who earning salary not in the range of 2500 and 5000 in department 10 & 20 */
select dept_no, ename, sal
from emp
where dept_no in (20,30) and sal between 2500 and 5000;

/* Display job-wise maximum salary */
select job, max(sal) as maxsal
from emp
group by job
order by sal desc;

/* Display the departments that are having more than 3 employees under it. */
select dept_no, count(emp_no) as count_emp
from emp 
group by dept_no
having count(emp_no) > 3;

/* Display job-wise average salaries for the employees whose employee number is not from 7788 to 7900.*/
select dept_no, emp_no, job, round(avg(sal)) as avg_sal	
from emp
where emp_no not in (7788,7900)
group by job;


/* Display department-wise total salaries for all the Managers and Analysts, 
only if the average salaries for the same is greater than or equal to 2500.*/
select dept_no, sum(sal) as total_sal, round(avg(sal)) as avg_sal
from emp 
where job in ('manager','analyst')
group by dept_no
having avg(sal) > 2500;

/* 19) Display all the employees who are earning more than all the managers.*/
select ename, job, sal
from emp
where sal > all (select sal from emp where job = 'manager');


/* 20) Display all the employees who are earning more than any of the managers.*/
select ename, job, sal
from emp
where sal > any (select sal from emp where job = 'manager');


/* 21) Select employee number, job & salaries of all the Analysts who are earning more than any of the managers.*/
select emp_no, job, sal
from emp
where job = 'analyst' and sal > any (select sal from emp where job = 'manager');


/* 22) Select all the employees who work in DALLAS.*/
/*joins*/
select e.dept_no, ename, loc
from emp e join dept d 
on e.dept_no = d.dept_no 
where  loc = 'dallas';

/*subquery*/
select dept_no, ename
from emp 
where dept_no in ( select dept_no from dept where loc = 'dallas');

select * from dept;

/* 23) Select department name & location of all the employees working for CLARK.*/
select dept_no,dname, loc
from dept
where dept_no in (select dept_no from emp where ename = 'clark');

SELECT DNAME,LOC
FROM DEPT
WHERE DEPT_NO IN (SELECT DEPT_NO
FROM EMP
WHERE MGR IN (SELECT EMP_NO
FROM EMP
WHERE ENAME='CLARK'));

/* 24) Select all the departmental information for all the managers*/
select * 
from dept 
where dept_no in 
   ( select dept_no from emp where  job = 'manager');
   
/* 25) Display the first maximum salary. */
select ename, sal, job
from emp 
where sal in (select max(sal) from emp);


/* 26) Display the second maximum salary.*/
select ename, job, max(sal) as 2nd_highest_Sal
from emp 
where sal not in (select max(sal) from emp);


/* 27) Display the third maximum salary.*/
select ename, max(sal) as 3rd_highest_Sal
from emp 
where sal <(select max(sal) from emp where sal <(select max(sal) from emp));


/* 28) Display all the managers & clerks who work in Accounts and sales departments.*/
select e.emp_no, e.dept_no, job, dname
from emp e join dept d on e.dept_no = d.dept_no 
where e.job in ('manager','clerk') and d.dname in ('accounting','sales');


/* 29) Display all the salesmen who are not located at DALLAS.*/
select emp_no, job
from emp 
where job = 'salesman' and dept_no in 
(select dept_no from dept where loc <>'dallas');

select e.emp_no, e.dept_no
from emp e join dept d 
on e.dept_no =d.dept_no 
where e.job='SALESMAN' and d.loc<>'DALLAS';


/* 30) Get all the employees who work in the same departments as of SCOTT.*/
select ename, job
from emp 
where job in (select job from emp where ename = 'scott');


/* 31) Select all the employees who are earning same as SMITH.*/
select ename, sal 
from emp 
where sal in (select sal from emp where ename = 'smith');


/* 32) Display all the employees who are getting some commission in sales department 
		where the employees have joined only on weekdays.*/
select ename, comm, weekday(hiredate) as hdate 
from emp 
where comm is not null and dept_no in (select dept_no from dept where dname = 'sales'); 


/* 33) Display all the employees who are getting more than the average salaries of all the employees.*/
select ename, sal
from emp 
where sal > (select avg(sal) from emp);

        /*ASSIGNMENTS ON EQUI-JOINS*/

/*34) Display all the managers & clerks who work in Accounts and Marketing departments. */
select e.dept_no, e.job, d.dname
from emp e join dept d on e.dept_no = d.dept_no
where d.dname in ('accounting','sales') and e.job in ('manager','clerk');

/*35) Display all the salesmen who are not located at DALLAS.*/
select e.ename, job, loc
from emp e join dept d on e.dept_no = d.dept_no
where job = 'salesman' and loc <> 'dallas';

/*36) Select department name & location of all the employees working for CLARK.*/
select e.ename, e.dept_no, loc, dname
from emp e join dept d on e.dept_no = d.dept_no
where mgr in (select emp_no from emp where ename = 'clark');

/*37) Select all the departmental information for all the managers*/
select d.*, ename, job
from dept d join emp e 
on e.dept_no = d.dept_no
where job = 'manager';

/*38) Select all the employees who work in DALLAS.*/
select e.ename, job, loc
from emp e join dept d on e.dept_no = d.dept_no
where loc = 'dallas';

/*39) Delete the records from the DEPT table that don’t have matching records in EMP */
select d.*,e.*
from dept d left join emp e on e.dept_no = d.dept_no
where e.dept_no is null;

delete d.*,e.*
from dept d left join emp e on e.dept_no = d.dept_no
where e.dept_no is null ;

select * from dept;

/*ASSIGNMENTS ON OUTER-JOINS*/
/*40) Display all the departmental information for all the existing employees and if a 
department has no employees display it as “No employees”.*/

insert into dept values (40,'Operations','Boston');
select * from dept;

select d.*,count(e.dept_no),
case when e.dept_no is null then 'no employees'
else 'employees' end as emp_status
from dept d left outer join emp e 
on e.dept_no = d.dept_no
group by d.dept_no;


select d.*,
case when count(e.dept_no) is null then 'no employees'
else count(e.dept_no) end as emp 
from dept d left outer join emp e 
on e.dept_no = d.dept_no
group by d.dept_no;


/*41) Get all the matching & non-matching records from both the tables.*/
select d.*, e.*
from dept d left outer join emp e 
on e.dept_no = d.dept_no;

/* full outer join */
select d.*, e.*
from emp e left outer join dept d 
on e.dept_no = d.dept_no
union all
select d.*, e.*
from emp e right outer join dept d 
on e.dept_no = d.dept_no;


/*42) Get only the non-matching records from DEPT table (matching records shouldn’t be selected).*/
select d.dept_no, d.dname, d.loc, e.ename
from dept d left outer join emp e 
on e.dept_no = d.dept_no
where d.dept_no not in (select dept_no from emp)
order by d.dept_no asc;


/*43) Select all the employees name along with their manager names, 
and if an employee does not have a manager, display him as “CEO”.*/


/* ASSIGNMENTS ON SELF-JOINS */
/*44) Get all the employees who work in the same departments as of SCOTT */
select distinct e.ename,e.job
from emp e, dept d 
where e.dept_no = (select dept_no from emp where ename = 'scott') 
                    and e.ename <> 'scott';


/*45) Display all the employees who have joined before their managers.*/
select e.ename, e.hiredate as "emp_date", b.hiredate as "mgr_date"
from emp e, emp b 
where e.mgr = b.emp_no and e.hiredate < b.hiredate;


/*46) List all the employees who are earning more than their managers.*/
select e.ename as "employees", e.sal as "emp_sal", 
b.ename as "managers", b.sal as "manager_Sal"
from emp e inner join emp b 
on e.mgr = b.emp_no 
where e.sal > b.sal;


/*47) Fetch all the employees who are earning same salaries.*/
select e1.ename as "emp_1" , e1.sal as "sal_1", e2.ename as "emp_2" , e2.sal as "sal_2"
from emp as e1 inner join emp as e2
where e1.sal = e2.sal and e1.ename <> e2.ename;

/*48) Select all the employees who are earning same as Scott.*/
select e.ename as emp, m.ename as same_sal_emp, e.sal as salary
from emp e inner join emp m 
on e.sal = m.sal 
where e.ename = 'scott' and m.ename <> 'scott';

/*49) Display employee name , his date of joining, his manager name & his manager's date of joining */