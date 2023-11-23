from flask import Flask, render_template, request, redirect, url_for
from flask_mysqldb import MySQL
from flask_sqlalchemy import SQLAlchemy
import MySQLdb.cursors
import datetime
import time
import random
from flask import jsonify
from flask_cors import CORS
#Flask Instance
app = Flask(__name__,template_folder='template')

#MYSQL DB


app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = 'anurag123'
app.config['MYSQL_DB'] = 'evoting-3'

mysql = MySQL(app)

@app.route('/', methods = ['GET', 'POST'])
def Home():
    msg = ''

    if request.method == 'POST':
        if all(x in request.form for x in ['username', 'password']):
            username = request.form['username']
            password = request.form['password']
            #creating variable for connection:
            cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
            cursor.execute('SELECT * FROM login where UserName = %s', (username,))
            result = cursor.fetchone()
            if result:
                if result['UserName'] == username and result['Password'] == password:
                    if result['UserType'] == 1:
                        return redirect(url_for('Voter', username = username))
                    else:
                        return redirect(url_for('Candidate', username = username))
                else:
                    msg = "Please enter correct password"
            else:
                msg = 'Username doesn\'t already exists!'
        else:
            msg = 'Please fill missing values!'
    return render_template('index.html', msg = msg)

@app.route('/display')
def Display():
    #creating variable for connection:
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute('SELECT * FROM login')
    result = cursor.fetchall()

    return render_template('home.html', datas = result)


@app.route('/register', methods=['GET','POST'])
def Register():
    msg = ''

    if request.method == 'POST':
        if all(x in request.form for x in ['fname', 'lname', 'gender', 'birthdate', 'citizenship',
         'province', 'district', 'municipality', 'ward', 'email', 'password', 'phone']):
            fname = request.form['fname']
            mname = request.form['mname']
            lname = request.form['lname']
            gender = request.form['gender']
            birthdate = request.form['birthdate']
            citizenship = request.form['citizenship']
            province = request.form['province']
            district = request.form['district']
            municipality = request.form['municipality']
            ward = request.form['ward']
            email = request.form['email']
            password = request.form['password']
            phone = request.form['phone']
            role = request.form['role']
            education = request.form['education']
            submit = request.form['submit']
            cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
            cursor.execute('SELECT * FROM login where Email = %s', (email,))
            result = cursor.fetchone()
            if gender == 'Male':
                gender = 0
            else:
                gender = 1

            if result:
                msg = 'Email already taken'
            else:
                # cursor.execute('SELECT * FROM voter_identity as c \
                # join login as l on c.Email = l.Email where c.PhoneNo = %s', (phone,))
                # result = cursor.fetchone()
                if result:
                    msg = 'PhoneNo already taken'
                else:
                    msg = "Registration Successful"
                    cursor.execute('SELECT AddressID FROM address where District = %s and Municipality = %s and WardNo = %s and Province = %s',
                    (district,municipality,ward,province,))
                    result = cursor.fetchone()
                    if not result:
                        cursor.execute('Insert into address values(null,%s,%s,%s,%s)',
                        (district,municipality,ward,province,))
                        mysql.connection.commit()

                        cursor.execute('SELECT AddressID FROM address where District = %s and Municipality = %s and WardNo = %s and Province = %s',
                        (district,municipality,ward,province,))
                        result = cursor.fetchone()
                    
                        
                    
                    address = result['AddressID']
                    year = datetime.datetime.today().year
                    age = int(year) - int(birthdate[:4])
                    if role == "candidate":
                        cursor.execute('SELECT EducationID FROM education where DegreeLevel = %s', (education,))
                        result = cursor.fetchone()
                        education = result['EducationID']
                        party = 'ABC'
                        cursor.execute('Insert into candidate_identity values(null,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)',
                        (fname,mname,lname,birthdate,age,email,phone,gender,citizenship,education,address,party))
                        mysql.connection.commit()

                        username = fname + '@' + str(random.randrange(1000))
                        usertype = 2
                        cursor.execute('INSERT INTO login VALUES (NULL,%s, %s, %s, %s)', (username,password,usertype,email))
                        mysql.connection.commit()
                    else:
                        cursor.execute('Insert into voter_identity values(null,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)',
                        (fname,mname,lname,birthdate,age,email,phone,gender,citizenship,address))
                        mysql.connection.commit()

                        username = fname + '@' + str(random.randrange(1000))
                        usertype = 1
                        cursor.execute('INSERT INTO login VALUES (NULL,%s, %s, %s, %s)', (username,password,usertype,email))
                        mysql.connection.commit()
        else:
            msg = 'Fill the missing values'
        
        if submit == "Register":
            if usertype == 1:
                return redirect(url_for('Voter', username=username))
            else:
                return redirect(url_for('Candidate', username=username))
                

    return render_template('register.html', msg = msg)


@app.route('/voter/<username>',methods=['GET','POST'])
def Voter(username):
    current_time = datetime.datetime.now()
    end_time = datetime.datetime(2023, 11, 25)  # Adjust the end time accordingly

    if current_time >= end_time:
        return redirect(url_for('calculate_results'))

    time_left = end_time - current_time
    time_left_datetime = datetime.datetime(1, 1, 1) + time_left
    timeLeft = time_left_datetime.strftime("%d days, %H:%M:%S")

    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute('SELECT * FROM candidate_identity c inner join education e on c.EducationID = e.EducationID')
    result = cursor.fetchall()

    return render_template('voter.html', time=timeLeft, datas=result, username=username)
@app.route('/guidelines')
def guidelines():
    return render_template('guidelines.html')
@app.route('/liveaction/<username>')
def LiveAction(username):
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute('SELECT * FROM candidate_identity c left join education e on c.EducationID = e.EducationID \
                    left join \
                    (SELECT CandidateID, COUNT(CandidateID) as Nvotes from vote group by CandidateID) as t \
                    on c.CandidateId = t.CandidateID ORDER BY Nvotes DESC;')
    result = cursor.fetchall()
    return render_template('liveaction.html', datas = result, username=username)
CORS(app)

@app.route('/get_time_remaining', methods=['GET'])
def get_time_remaining():
    current_time = datetime.datetime.now()
    future_time = datetime.datetime(2023, 11, 25)
    time_left = future_time - current_time

    days, seconds = time_left.days, time_left.seconds
    hours, remainder = divmod(seconds, 3600)
    minutes, seconds = divmod(remainder, 60)

    return jsonify({'time': {'days': days, 'hours': hours, 'minutes': minutes, 'seconds': seconds}})
@app.route('/faq')
def faq():
    return render_template('faq.html')
@app.route('/voted/<username>/<CandidateID>',methods=['GET','POST'])
def Voted(username,CandidateID):
    time = datetime.datetime.now()
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute('SELECT * FROM voter_identity v left join login l on v.Email = l.Email where username = %s',(username, ))
    result = cursor.fetchone()
    VoterID = result['VoterID'] 

    cursor.execute('SELECT * FROM vote WHERE VoterID = %s',(VoterID,))
    result = cursor.fetchone()
    if result:
        cursor.execute('DELETE FROM vote WHERE VoterID = %s',(VoterID,))
        mysql.connection.commit()
    
    cursor.execute('INSERT INTO vote values (null,%s,%s,%s)',(VoterID,CandidateID,time))
    mysql.connection.commit()
    return render_template('voted.html',username = username, CandidateID = CandidateID)

@app.route('/candidate/<username>')
def Candidate(username):
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute('SELECT * FROM login where username = %s', (username,))
    result = cursor.fetchone()
    Email = result['Email']
    cursor.execute('Select CandidateID from candidate_identity where Email = %s', (Email,))
    result = cursor.fetchone()
    CandidateID = result['CandidateID']
    cursor.execute('Select count(VoterID) as Nvote from vote where CandidateID = %s', (CandidateID,))
    result = cursor.fetchone()
    Nvote = result['Nvote']
    return render_template('candidate.html',username = username, Nvote = Nvote)

@app.route('/username/<username>')
def UserName(username):
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute('SELECT * FROM login where username = %s', (username,))
    result = cursor.fetchone()
    Email = result['Email']
    usertype = result['UserType']
    if usertype == 1:
         cursor.execute('SELECT * FROM voter_identity v inner join address a on v.AddressID = a.AddressID where Email=%s', (Email,))
         result = cursor.fetchone()
    else:
         cursor.execute('SELECT * FROM candidate_identity v inner join address a on v.AddressID = a.AddressID where Email=%s', (Email,))
         result = cursor.fetchone()
    if result['Sex'] == 0:
        result['Sex'] = 'Male'
    else: 
        result['Sex'] = 'Female'
    return render_template('username.html',username=username, data = result)

@app.route('/useredit/<username>', methods = ['GET', 'POST'])
def UserEdit(username):
    msg = ''

    if request.method == 'POST':
        if all(x in request.form for x in ['fname', 'lname', 'gender', 'birthdate', 'citizenship',
         'province', 'district', 'municipality', 'ward', 'email', 'password', 'phone']):
            fname = request.form['fname']
            mname = request.form['mname']
            lname = request.form['lname']
            gender = request.form['gender']
            birthdate = request.form['birthdate']
            citizenship = request.form['citizenship']
            province = request.form['province']
            district = request.form['district']
            municipality = request.form['municipality']
            ward = request.form['ward']
            email = request.form['email']
            password = request.form['password']
            phone = request.form['phone']
            role = request.form['role']
            education = request.form['education']
            party = request.form['party']
            submit = request.form['submit']

            gender = 0 if gender == 'Male' else 1

            cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
            cursor.execute('SELECT * FROM login where Username = %s', (username,))
            result = cursor.fetchone()
            prev_email = result['Email']
            msg = "Update Successful"
            cursor.execute('SELECT AddressID FROM address where District = %s and Municipality = %s and WardNo = %s and Province = %s',
            (district,municipality,ward,province,))
            result = cursor.fetchone()
            if not result:
                cursor.execute('Insert into address values(null,%s,%s,%s,%s)',
                (district,municipality,ward,province,))
                mysql.connection.commit()

                cursor.execute('SELECT AddressID FROM address where District = %s and Municipality = %s and WardNo = %s and Province = %s',
                (district,municipality,ward,province,))
                result = cursor.fetchone()      

            address = result['AddressID']
            year = datetime.datetime.today().year
            age = int(year) - int(birthdate[:4])

            if role == "candidate":
                cursor.execute('SELECT EducationID FROM education where DegreeLevel = %s', (education,))
                result = cursor.fetchone()
                education = result['EducationID']

                # cursor.execute('UPDATE candidate_identity SET(null,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s) where Email = %s',
                # (fname,mname,lname,birthdate,age,email,phone,gender,citizenship,education,address,party, prev_email))
                # mysql.connection.commit()
                sql = "UPDATE candidate_identity SET FirstName=%s, MiddleName=%s, LastName=%s, DOB=%s, \
                Age=%s, Email=%s, PhoneNo=%s, Sex=%s, CitizenshipID=%s, EducationID=%s, AddressID=%s, PartyID=%s WHERE Email=%s"
                data = (fname,mname,lname,birthdate,age,email,phone,gender,citizenship,education,address,party,prev_email,)
                cursor.execute(sql,data)
                mysql.connection.commit()
                usertype = 2
            else:
                # cursor.execute('UPDATE voter_identity SET(null,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s) where Email = %s',
                # (fname,mname,lname,birthdate,age,email,phone,gender,citizenship,address,prev_email))
                # mysql.connection.commit()
                sql = 'UPDATE voter_identity SET FirstName=%s, MiddleName=%s, LastName=%s, DOB=%s, \
                    Age=%s, Email=%s, PhoneNo=%s, Sex=%s, CitizenshipNo=%s, AddressID=%s WHERE Email=%s'
                data = (fname,mname,lname,birthdate,age,email,phone,gender,citizenship,address,prev_email,)
                cursor.execute(sql,data)
                mysql.connection.commit()
                usertype = 1
                        
        else:
            msg = 'Fill the missing values'
        msg = prev_email
        if submit == "Update":
            if usertype == 1:
                return redirect(url_for('Voter', username=username))
            else:
                return redirect(url_for('Candidate', username=username))
    return render_template('useredit.html',username = username)
# Calculate and display results route
@app.route('/calculate_results')
def calculate_results():
    # Connect to the database
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)

    # Query to get the candidate names and their total votes
    cursor.execute('SELECT ci.FirstName, ci.LastName, COUNT(v.CandidateID) as VoteCount FROM candidate_identity ci LEFT JOIN vote v ON ci.CandidateID = v.CandidateID GROUP BY ci.CandidateID ORDER BY VoteCount DESC LIMIT %s', (3,))

    # Fetch the results
    results = cursor.fetchall()

    # Close the database connection
    cursor.close()

    # Render the template with the results
    return render_template('results.html', results=results)
if __name__ == "__main__":
    app.run(debug=True)
