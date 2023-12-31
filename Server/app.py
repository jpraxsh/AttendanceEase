# from unicodedata import name
import base64
import os
from pydoc import classname
from select import select
import pandas as pd
from flask import *
import json
# from select import select
import mysql.connector
import werkzeug
# import os
import io
import cv2
from PIL import Image
# from PIL import ImageEnhance
import uuid
from finalML.cropper import cropper
from werkzeug.utils import secure_filename


# mydb = mysql.connector.connect(
#     host="localhost",
#     user="root",
#     password="14072003jp",
#     database="test"
# )
# cursor = mydb.cursor()
app = Flask(__name__)
app.secret_key="?mvf3t56@345+1234BgTNDY636773!@#"
ALLOWED_EXTENSIONS={'jpeg','png','jpg'}
years=['2022','2021','2020','2023']
UPLOAD_FOLDER = '/images'
def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS
def delete():
    pass

def fetchstudents(class_name):
    query = f"select * from {class_name}"
    cursor.execute(query)       
    detail = cursor.fetchall()
    cursor.reset()
    details ={detail[i][0]:detail[i][1] for i in range(0,len(detail))}
    returner = json.dumps(details)
    return returner
## TESTING SESSION 

# @app.route("/test",methods=["POST","GET"])
# def test():
#     var=" "
#     if 'username' in session:
#         var=session['username']
#     return var

## ADD CLASS 

@app.route('/addclass',methods=['POST'])
def addclass():
    yr = int(request.form['yr'])
    batch = str(request.form['batch'])
    subcode = str(request.form['subjcode'])#subcode
    teacher_id = str(request.form['teacherId'])#teacherid
    year = year[yr+1]
    classname=dept+'_'+year+'_'+batch#class
    tablename=classname+'_'+subcode+'att'
    student=request.form['select_students']
    namelist=json.loads(student)
    strength=len(namelist)
    rollnum=[]
    query=f"select * from class_map where teacher_id='{teacher_id}' and class='{classname}' and subcode='{subcode}'"
    cursor.execute(query)
    check = cursor.fetchone
    cursor.reset()
    Query = ""
    if not check:
        insertQuery = f"insert into class_map values({teacher_id},{classname},{subcode},{strength})"
        cursor.execute(insertQuery)
        cursor.reset()
        Query = f"create table {tablename}(c_date date "
        for i in range(len(namelist)):
            Query+="%s varchar(1),"
            rollnum.append(namelist[i])
        Query=Query[:-1]
        Query+=")" 
    else:
        Query = f"Alter table {tablename} "
        for i in range(len(namelist)):
            Query+="Add column %s varchar(1),"
            rollnum.append(namelist[i])
        Query = Query[:-1]
    cursor.execute(Query,rollnum)
    cursor.reset()
    return "Sucessfully created / updated"

## DELETE CLASS

@app.route('/deleteclass',methods=['POST'])
def deleteclass():
    classname = str(request.form['tablename'])
    subjcode = str(request.form['subjcode'])
    # teacherId = str(request.form['teacherId'])
    Query = f"drop table {classname}_{subjcode}"
    cursor.execute(Query)
    cursor.reset()
    Query = f"Delete from classdetails where subjcode = '{subjcode}'"
    cursor.execute(Query)
    cursor.reset()
    return "Successfully  deleted"

## VIEW CLASS

@app.route('/viewclass',methods = ['POST'])
def viewclass():
    teacherId = str(request.form['teacher_id'])
    Query = f"select * from class_map where teacher_id='{teacherId}'"
    cursor.execute(Query)
    detail = cursor.fetchall()
    cursor.reset()
    res={}
    c=1
    for i in detail:
        res["class"+str(c)]={"class":i[1],"course":i[2],"strength":str(i[3])} 
        c=c+1
    return res

## LOGIN

@app.route('/login',methods=['POST'])
def login():
    user_name = str(request.form["uname"])
    pass_word = str(request.form["pass"])   #getting name and pass
    Query = "select * from login_details where user_id = %s and pass = %s"
    val =[user_name,pass_word]
    cursor.execute(Query,val)
    account = cursor.fetchone()
    cursor.reset()
    if account:
        # session['username']=user_name
        # print(session)
        return "true"
    else :
        return "false"    

## GETTING STUDENT DETAILS

@app.route("/studentdetails",methods=["POST"]) 
def stduentdetails():
    # dept = str(request.form['dept'])
    # yr = int(request.form['yr'])
    # batch = str(request.form['batch'])
    # year = years[yr-1]
    # class_name=dept+'_'+year+'_'+'batch'+str(batch)#class
    
    class_name = str(request.form["classname"])
    print(class_name)
    query = f"select * from {class_name}"
    cursor.execute(query)       
    detail = cursor.fetchall()
    cursor.reset()
    details ={detail[i][0]:detail[i][1] for i in range(0,len(detail))}
    returner = json.dumps(details)
    return returner

## IMAGE UPLOAD


# @app.route("/imageUpload",methods=["Post"])
# def imageUpload():
#     imgdata=base64.b64decode(request.form['image'])
#     img = Image.open(io.BytesIO(imgdata))
#     img.save(f"finalML/frames/{uuid.uuid1()}.jpeg",quality=100)
#     student =  cropper()
#     students = {"s"+str(i):student[i] for i in range(0,len(student))}
#     return students
    
@app.route("/imageUpload",methods=["GET","POST"])
def imageUpload():
    if request.method == 'POST':
        if 'pic' not in request.files:
             print("No file")
             return "no file"
        file = request.files['pic']
        class_name = request.form["classname"]
        print(class_name)
        if file.filename == '':
            print("No filename")
            return "No selected file"
        if file and allowed_file(file.filename):
            filename = secure_filename(file.filename)
            file.save(f"finalML/frames/{filename}.jpeg")
            pressented_students =  cropper()
            students = fetchstudents(class_name)
            students=json.loads(students)
            for i in students:
                students[i]={students[i]:"0"}
            for i in pressented_students:
                for j in students[i]:
                    students[i][j]=1
            students=json.dumps(students)
            print(students)
            # return "helo"
            return students
    # return "Invalid Format"



## UPDATE ATTENDENCE

@app.route("/updateattendance",methods=["POST"])
def updateattendance():
    up_atten = str(request.form["att"])
    print(up_atten)
    atten = json.loads(up_atten)
    print(atten)
    print(request.form["tablename"])
    tab=str(request.form["tablename"])+'_att'
    query =f"select * from {tab} where c_date = curdate()"
    cursor.execute(query)
    check = cursor.fetchone()
    cursor.reset()
    if not check:
        insert =f"insert into {tab} values(curdate(),"
        val=[]
        for i in atten:
            insert+="%s," 
            val.append(atten[i])
        insert=insert[:-1]
        insert+=")"
        print(insert)
        print(val)
        cursor.execute(insert,val)
        mydb.commit()
        cursor.reset()
        return "Attendence updated sucessfully"
    else:
        return "Attendance already taken"
    return "duck"


if __name__ == "__main__":
    app.run(host="0.0.0.0",debug="True")