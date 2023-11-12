from flask import Flask, render_template, request, redirect, url_for
from flask_mysqldb import MySQL
from flask_sqlalchemy import SQLAlchemy
import MySQLdb.cursors
import datetime
import time
import random

#Flask Instance
app = Flask(__name__,template_folder='template')

#MYSQL DB


app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = 'ananya123'
app.config['MYSQL_DB'] = 'evoting-3'

mysql = MySQL(app)

@app.route('/liveaction/<username>')
def LiveAction(username):
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute('SELECT * FROM candidate_identity c left join education e on c.EducationID = e.EducationID \
                    left join \
                    (SELECT CandidateID, COUNT(CandidateID) as Nvotes from vote group by CandidateID) as t \
                    on c.CandidateId = t.CandidateID ORDER BY Nvotes DESC;')
    result = cursor.fetchall()
    return render_template('liveaction.html', datas = result, username=username)

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


if __name__ == "__main__":
    app.run(debug=True)
