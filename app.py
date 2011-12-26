#!/usr/bin/env python
import bottle
import ConfigParser as configparser
import MySQLdb as db

config = configparser.ConfigParser()
config.read('app.conf')
DEPLOYMENT = config.get('server', 'deployment')
PORT = config.getint('server', 'port')
DB_DBNAME = config.get('database', 'dbname')
DB_USER = config.get('database', 'username')
DB_PASSWD = config.get('database', 'passwd')

bottle.debug(DEPLOYMENT != 'prod')

route = bottle.route
template = bottle.template

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
    return template('wizard')

@route('/education')
def education():
    return template('education')

@route('/salt_smart')
def salt_smart():
    return template('salt_smart')

@route('/salt_smart_answer')
def salt_smart_answer():
    return template('salt_smart_answer')

@route('/chart', method = 'POST')
def chart():
    dbcon = db.connect(host='localhost', user=DB_USER, passwd=DB_PASSWD, db=DB_DBNAME)
    dbcur = dbcon.cursor()

    disease_statements = ['icd9code between 410 and 415 or icd9code between 425 and 426 or icd9code between 428 and 430',
                          'icd9code between 430 and 439 or icd9code between 440 and 449',
                          'icd9code between 580 and 590']

    BMI_RANGES = [0, 14, 18, 24.9, 29.9, 34.9, 1000]
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

    BIOGRAPHICAL_COHORT = '(select patientguid from syncpatient2 where gender=%(gender)s and yearofbirth between %(startyear)d and %(endyear)d) '
    
    for op in ['>', '<']:
        for jj in range(4):
            query = 'select count(distinct chartguid) as count from syncchart2 where patientguid in ' + BIOGRAPHICAL_COHORT + \
                    ('and patientguid in (select distinct patientguid from syncdiagnosis2 where ' + disease_statements[jj] + ') ') if (jj < 3) else '' + \
                    'and bmi between %(bmimin)d and %(bmimax)d ' + \
                    'and systolicbp %(op)s %(targetsys)d and diastolicbp %(op)s %(targetdia)d'
            dbcur.execute(query, {'gender': gender, 
                                  'startyear': start_year,
                                  'endyear': end_year,
                                  'bmimin': bmi_min,
                                  'bmimax': bmi_max, 
                                  'op': op,
                                  'targetdia': target_diastolic,
                                  'targetsys': target_systolic})
            import pdb;pdb.set_trace()

            row = dbcur.fetchone()[0]
            if op == '>':
                count_above[jj] = row.count
            elif op == '<':
                count_below[jj] = row.count

    total_above = sum(count_above)
    total_below = sum(count_below)

    above_data = [1.0 * above / total_above for above in count_above]
    below_data = [1.0 * below / total_below for below in count_below]

    dbcon.close()

    return template('chart', 
                    name = name,
                    is_healthy = is_healthy,
                    systolicbp = systolicbp,
                    diastolicbp = diastolicbp,
                    target_systolic = target_systolic,
                    target_diastolic = target_diastolic,
                    above_data = above_data,
                    below_data = below_data,
                    )

@route('/static/<filepath:path>')
def server_static(filepath):
    return bottle.static_file(filepath, root='./static')

bottle.run(host='localhost', port=PORT, reloader=(DEPLOYMENT == 'dev'))

