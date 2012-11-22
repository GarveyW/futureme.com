#!/usr/bin/env python
import bottle
import webtools
import MySQLdb as db
import random
import re

CFG = webtools.ServerConfig()

bottle.debug(CFG.IS_DEV)

route = bottle.route
template = bottle.template
request = bottle.request
response = bottle.response

@route('/')
def index():
    return template('index')

@route('/about')
def about():
    return template('about')

@route('/contact')
def contact():
    return template('contact')

@route('/wizard')
def wizard():
    if request.get_cookie("visited"): 
        bottle.redirect('/chart')
    else:
        return template('wizard')

@route('/share_story', method='POST')
def share_story():
    if request.get_cookie("visited"):
        userdata = eval(request.get_cookie('userdata'))
        name = userdata['name']
    else:
        name = 'Anonymous'

    forms = bottle.request.forms
    search = re.search('watch\?v=(.*?)&', forms.youtubeurl)
    if search is not None:
        youtubehash = search.group(1)
        desc = forms.videodescription
        dbcon = db.connect(host='localhost', user=CFG.DB_USER, passwd=CFG.DB_PASSWD, db=CFG.DB_NAME)
        dbcur = dbcon.cursor()
        query = 'insert into sharedvideos (youtubehash, name, comment) values (%s, %s, %s)'
        dbcur.execute(query, (youtubehash, name, desc))
        dbcon.commit()
        dbcon.close()
 
        #save to database
        return template('share_story', success = True)
    else:
        return template('share_story', success = False)

@route('/share')
def share():
    dbcon = db.connect(host='localhost', user=CFG.DB_USER, passwd=CFG.DB_PASSWD, db=CFG.DB_NAME)
    dbcur = dbcon.cursor()
    query = 'select youtubehash, name, comment from sharedvideos order by s_id desc limit 10'
    dbcur.execute(query)
    videos = dbcur.fetchall()
    dbcon.close()
    print videos
    return template('share', videos = videos)

@route('/clear_cookies')
def clear_cookies():
    response.delete_cookie('userdata')
    response.delete_cookie('visited')
    bottle.redirect('/wizard')

@route('/education')
def education():
    if not request.get_cookie("visited"):
        display_tips = {'controlweight': True,
                        'fruits': True,
                        'salt': True,
                        'exercise': True,
                        'alcohol': True,
                        'smoking': True,
                        'aspirin': True,}
    else:
        userdata = eval(request.get_cookie("userdata"))

        controlweight = (userdata['bmi'] > 30)
        issmoker = (userdata['issmoker'])
        aspirin = (userdata['is_healthy'])
        salt = (userdata['is_healthy'])

        display_tips = {'controlweight': controlweight,
                        'fruits': (random.random() < 0.5),
                        'salt': salt,
                        'exercise': (random.random() < 0.5),
                        'alcohol': (random.random() < 0.5),
                        'smoking': issmoker,
                        'aspirin': aspirin,}

    return template('education', display_tips)

@route('/salt_smart')
def salt_smart():
    return template('salt_smart')

@route('/salt_smart_answer')
def salt_smart_answer():
    return template('salt_smart_answer')

@route('/million_hearts')
def million_hearts():
    return template('million_hearts')

@route('/smoking')
def smoking():
    return template('smoking')

@route('/smoking')
def smoking():
    return template('smoking')


@route('/chart', method=['GET', 'POST'])
def chart():
    if not request.get_cookie("visited"):
        dbcon = db.connect(host='localhost', user=CFG.DB_USER, passwd=CFG.DB_PASSWD, db=CFG.DB_NAME)
        dbcur = dbcon.cursor()

        BMI_RANGES = [0.0, 14.0, 18.0, 24.9, 29.9, 34.9, 1000.0]
        AGE_RANGE_RADIUS = 10
        AGE_RANGE_CENTER = 20

        forms = bottle.request.forms
        first_name = forms.firstName
        last_name = forms.lastName
        gender = forms.get('genderOptionsRadio')
        age = forms.get('ageField', 0, type = int)
        weight = forms.get('weightField', 0, type = int)
        height_feet = forms.get('heightFeet', 0, type = int)
        height_inches = forms.get('heightInches', 0, type = int)
        systolicbp = forms.get('bloodPressureSystolic', 0, type = int)
        diastolicbp = forms.get('bloodPressureDiastolic', 0, type = int)
        issmoker = forms.get('issmoker')
        disease_strings = forms.getall('diseasesCheckboxes')

        no_diseases = (len(disease_strings) == 0)

        name = first_name.capitalize() + (' ' + last_name.capitalize() if last_name else '')
        height_total = height_feet * 12 + height_inches
        start_year = 2011 - age - AGE_RANGE_CENTER - AGE_RANGE_RADIUS
        end_year = 2011 - age - AGE_RANGE_CENTER + AGE_RANGE_RADIUS
        
        target_diastolic = 75 if no_diseases else 90
        target_systolic = 125 if no_diseases else 140
        is_healthy = (diastolicbp <= target_diastolic and systolicbp <= target_systolic)

        bmi = weight * 703.0 / (height_total * height_total)
        bmi_min = max([b for b in BMI_RANGES if b < bmi])
        bmi_max = min([b for b in BMI_RANGES if b > bmi])

        #number of people above target blood pressure, number of people below
        count_above = [0] * 4
        count_below = [0] * 4

        for op in ['>', '<']:
            for jj in range(4):
                health_query = ''
                if jj == 0:
                    health_query = 'and heartdisease=0 and stroke=0 and kidneyproblem=0 '
                elif jj == 1:
                    health_query = 'and heartdisease=1 '
                elif jj == 2:
                    health_query = 'and stroke=1 '
                elif jj == 3:
                    health_query = 'and kidneyproblem=1 '

                query = 'select count(*) as count from visit2 where gender=\'%(gender)s\' and yearofbirth between %(startyear)d and %(endyear)d and bmi between %(bmimin)f and %(bmimax)f and systolicbp%(op)s%(targetsys)d and diastolicbp%(op)s%(targetdia)d '.replace('%(op)s', op) + health_query

                args = {'gender': gender, 
                        'startyear': int(start_year),
                        'endyear': int(end_year), 
                        'bmimin': float(bmi_min), 
                        'bmimax': float(bmi_max), 
                        'targetdia': int(target_diastolic), 
                        'targetsys': int(target_systolic)}
                query = query % args
                dbcur.execute(query, args)
                count = dbcur.fetchone()[0]
                if op == '>':
                    count_above[jj] = count
                elif op == '<':
                    count_below[jj] = count

        total_above = sum(count_above)
        total_below = sum(count_below)

        above_data = [1.0 * above / total_above for above in count_above]
        below_data = [1.0 * below / total_below for below in count_below]

        dbcon.close()
        response.set_cookie("visited", "yes")
        userdata = {'name': name,
                    'gender': gender,
                    'age': age,
                    'bmi': bmi,
                    'issmoker': issmoker,
                    'is_healthy': is_healthy,
                    'systolicbp': systolicbp,
                    'diastolicbp': diastolicbp,
                    'target_systolic': target_systolic,
                    'target_diastolic': target_diastolic,
                    'above_data': above_data,
                    'below_data': below_data,}


        response.set_cookie("userdata", str(userdata))
    else:
        userdata = eval(request.get_cookie("userdata"))

    return template('chart', userdata)

@route('/static/<filepath:path>')
def server_static(filepath):
    return bottle.static_file(filepath, root='./static')

bottle.run(host='localhost', port=CFG.PORT, reloader=CFG.IS_DEV)

