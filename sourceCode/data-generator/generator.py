import random
import string
from datetime import timedelta

import pyodbc
from faker import Faker
from faker.providers import lorem, company, address, person, phone_number, internet, date_time

server = 'dbmanage.lab.ki.agh.edu.pl'
database = 'u_pmarszal'
username = 'u_pmarszal'
password = 'bazybazy'
cnxn = pyodbc.connect(
   'DRIVER={ODBC Driver 17 for SQL Server};SERVER=' + server + ';DATABASE=' + database + ';UID=' + username + ';PWD=' + password
)
cursor = cnxn.cursor()

fake = Faker("pl_PL")
providers = [lorem, company, address, person, phone_number, internet, date_time]
for i in providers:
   fake.add_provider(i)


def fn_worshops(n):
   leng = [60, 120, 180]
   command = "insert into Workshops (name, syllabus, description, price, duration) values ('{}', '{}', '{}', '{}', '{}')"
   for i in range(1, n):
       name = fake.word() + " warsztat"
       syllabus = fake.text(200)
       description = fake.text(200)
       price = random.randint(0, 200)
       duration = random.choice(leng)
       cursor.execute(command.format(name, syllabus, description, price, duration))
   cursor.commit()
   return list(map(lambda x: (x.WorkshopID, x.duration),
                   cursor.execute("select WorkshopID, duration from Workshops").fetchall()))


def fn_states(n):
   for _ in range(n):
       cursor.execute("insert into States (state) values ('Polska')")
   cursor.commit()
   return list(map(lambda x: x.StateID, cursor.execute("select StateID from States").fetchall()))


def fn_persons(n):
   command1 = "insert into Persons (PersonID, firstname, lastname, email, phone) values ('{}', '{}', '{}', '{}', '{}')"
   command2 = "insert into Persons (PersonID, firstname, lastname, email, phone, StudentIDNumber) values ('{}', '{}', '{}', '{}', '{}', '{}')"
   for i in range(1, n):
       name = fake.first_name()
       surname = fake.last_name()
       phone = fake.phone_number().replace(" ", "")[3:]
       email = fake.email()
       if len(email) > 40:
           email = email[-40:]
       studentID = str(random.randint(100000, 999999)) if random.randint(0, 100) > 90 else 0
       if studentID == 0:
           cursor.execute(command1.format(i, name, surname, email, phone))
       else:
           cursor.execute(command2.format(i, name, surname, email, phone, studentID))
   cursor.commit()
   return list(map(lambda x: (x.PersonID, x.StudentIDNumber),
                   cursor.execute("select PersonID, StudentIDNumber from Persons").fetchall()))


def fn_companies(n):
   command = "insert into Companies (CompanyID, company_name, phone, email) values ('{}', '{}', '{}', '{}')"
   for i in range(n):
       name = fake.company()
       phone = fake.phone_number().replace(" ", "")[3:]
       email = fake.email()
       if len(email) > 40:
           email = email[-40:]
       cursor.execute(command.format(customers[i], name, phone, email))
   cursor.commit()
   return list(map(lambda x: x.CompanyID, cursor.execute("select CompanyID from Companies").fetchall()))


def fn_customers(n):
   command = "insert into Customers default values"
   for i in range(n):
       cursor.execute(command)
   cursor.commit()
   return list(map(lambda x: x.CustomerID, cursor.execute("select CustomerID from Customers").fetchall()))


def clear_all():
   command = "delete from [Workshops Enrollments]; delete from [Days Enrollments]; delete from [Workshops Reservations]; delete from [Days Reservations]; delete from [Reservations]; delete from [Private Customers]; delete from [Customers Employees]; delete from [Persons]; delete from [Companies]; delete from [Customers]; delete from [Workshops At Conferences]; delete from [Workshops]; delete from [Tresholds]; delete from [Days]; delete from [Conferences]; delete from [States]; "
   cursor.execute(command)
   cursor.commit()


def fn_private_customers():
   command = "insert into [Private Customers] (CustomerID, PersonID) values ('{}', '{}')"
   free = customers[(len(companies) + 1):]
   for i in range(len(free)):
       customer = free[i]
       person = persons[i][0]
       cursor.execute(command.format(customer, person))
   cursor.commit()
   return list(map(lambda x: (x.CustomerID, x.PersonID),
                   cursor.execute("select CustomerID, PersonID from [Private Customers]").fetchall()))


def fn_cus_empoy():
   command = "insert into [Customers Employees] (PersonID, CompanyID) values ('{}', '{}')"
   taken = len(private_costumers)
   for i in range(taken, len(persons)):
       cursor.execute(command.format(persons[i][0], random.choice(companies)))
   cursor.commit()
   return list(map(lambda x: (x.PersonID, x.CompanyID),
                   cursor.execute("select PersonID, CompanyID from [Customers Employees]").fetchall()))


def fn_con(n):
   command = "insert into Conferences (name, start_date, duration, StateID, city, street, description, daily_price, daily_limit, student_discount) values ('{}','{}','{}','{}','{}','{}','{}','{}','{}','{}')"
   for i in range(n):
       name = fake.word() + " konferencja"
       start_date = fake.date_between('-3y', 'today')
       duration = random.randint(2, 3)
       state = random.choice(states)
       city = fake.city()
       street = fake.street_name()
       description = fake.text(200)
       daily_price = random.randint(100, 200)
       daily_limit = random.randint(50, 150)
       student_discount = round(random.uniform(0, 0.5), 2)
       cursor.execute(
           command.format(name, start_date, duration, state, city, street, description, daily_price, daily_limit,
                          student_discount))
   cursor.commit()
   return list(map(lambda x: (x.conferenceid, x.duration, x.start_date, x.daily_limit), cursor.execute(
       "select conferenceid, duration, start_date, daily_limit from Conferences").fetchall()))


def fn_day():
   command = "insert into Days (ConferenceID, day_of_conference) values ('{}', '{}')"
   for conf in conferences:
       id = conf[0]
       days = conf[1]
       for i in range(days):
           cursor.execute(command.format(id, i))
   cursor.commit()
   return list(
       map(lambda x: (x.DayID, x.ConferenceID), cursor.execute("select DayID, ConferenceID from Days").fetchall()))


def fn_thresh():
   command = "insert into Tresholds (ConferenceID, starts_before, ends_before, discount) values ('{}', '{}', '{}', '{}')"
   for conf in conferences:
       id = conf[0]
       n = random.randint(1, 4)
       days = [random.randint(0, 100) for _ in range(n - 1)]
       days.extend([0, 128])
       dis = [round(random.uniform(0, 0.5), 2) for _ in range(n)]
       days.sort()
       dis.sort()
       for i in range(n):
           cursor.execute(command.format(id, days[i + 1], days[i], dis[i]))
   cursor.commit()


def fn_woc():
   command = "insert into [Workshops At Conferences] (WorkshopID, DayID, start_time, price, participants_limit) values ('{}','{}','{}','{}','{}')"
   for conf in conferences:
       id = conf[0]
       ds = list(filter(lambda x: x[1] == id, days))
       for d in ds:
           n = random.randint(4, 8)
           for _ in range(n):
               wid = random.choice(workshops)[0]
               time = fake.time()
               par_lim = random.randint(20, 50)
               price = random.randint(0, 200)
               cursor.execute(command.format(wid, d[0], time, price, par_lim))
   cursor.commit()
   return list(map(lambda x: (x.workatconfid, ws_to_dur[x.workshopid], x.dayid, x.start_time, x.participants_limit),
                   cursor.execute(
                       "select workatconfid, workshopid, dayid, start_time, participants_limit from [Workshops At Conferences]").fetchall()))


def fn_reserve():
   for conf in conferences:
       create_reservations(conf)


def create_reservations(conf):
   date = conf[2]
   c_id = conf[0]
   ds = list(map(lambda x: x[0], filter(lambda x: x[1] == c_id, days)))
   ws = list(filter(lambda x: x[2] in ds, woc))
   free_ds = [conf[3] for _ in ds]
   free_ws = [w[4] for w in ws]

   def reserve_company(comp):
       pers = get_workers(comp)
       if not free_ds[0] >= len(pers) or len(pers) == 0:
           return
       free_ds[0] = free_ds[0] - len(pers)
       command = "insert into Reservations (CustomerID, reservation_date, payment_date) values ('{}','{}','{}')"
       between = fake.date_between(date - timedelta(days=100), date - timedelta(days=20))
       cursor.execute(command.format(comp, between, between + timedelta(days=1)))
       cursor.commit()
       r_id = cursor.execute("select top 1 ReservationID from Reservations order by 1 DESC").fetchall()[
           0].ReservationID
       for ds_id in ds:
           command = "insert into [Days Reservations] (DayID, ReservationID, number_of_bookings) values ('{}', '{}', '{}')"
           cursor.execute(command.format(ds_id, r_id, len(pers)))
           cursor.commit()

           dr_id = cursor.execute("select top 1 DayReservationID from [Days Reservations] order by 1 DESC").fetchall()[
               0].DayReservationID

           command = "insert into [Days Enrollments] (DayReservationID, PersonID) values ('{}', '{}')"
           for p in pers:
               cursor.execute(command.format(dr_id, p[0]))
           cursor.commit()

           command = "select DayEnrollmentID from [Days Enrollments] where DayReservationID = '{}'"
           de_ids = list(map(lambda x: x.DayEnrollmentID, cursor.execute(command.format(dr_id)).fetchall()))

           for i in range(len(ws)):
               if ws[i][2] == ds_id and free_ws[i] >= len(pers):
                   free_ws[i] =  free_ws[i] - len(pers)
                   command = "insert into [Workshops Reservations] (DayReservationID, WorkAtConfID, number_of_bookings) values ('{}', '{}', '{}')"
                   cursor.execute(command.format(dr_id, ws[i][0], len(pers)))
                   cursor.commit()

                   ws_id = cursor.execute(
                       "select top 1 WorkshopReservationID from [Workshops Reservations] order by 1 DESC").fetchall()[
                       0].WorkshopReservationID
                   command = "insert into [Workshops Enrollments] (WorkshopReservationID, DayEnrollmentID) values ('{}', '{}')"
                   for e in de_ids:
                       cursor.execute(command.format(ws_id, e))
                   cursor.commit()

   for _ in range(random.randint(10, 40)):
       reserve_company(random.choice(customers)[0])


clear_all()

workshops = fn_worshops(100)
ws_to_dur = dict()
for ws in workshops:
   ws_to_dur[ws[0]] = ws[1]

states = fn_states(1)
persons = fn_persons(1000)
customers = fn_customers(100)
companies = fn_companies(30)
private_costumers = fn_private_customers()
customers_employees = fn_cus_empoy()

c_to_p = dict()
for pc in private_costumers:
   c_to_p[pc[0]] = pc[1]


def get_workers(comp):
   if comp in c_to_p:
       return [[c_to_p[comp], 0]]
   return list(filter(lambda x: x[1] == comp, customers_employees))


conferences = fn_con(72)
days = fn_day()
fn_thresh()
woc = fn_woc()

fn_reserve()


