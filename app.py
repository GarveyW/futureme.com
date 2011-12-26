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
    #import pdb;pdb.set_trace()
    """
    dbcon = db.connect(host='localhost', user=DB_USER, passwd=DB_PASSWD, db=DB_DBNAME)
    dbcur = dbcon.cursor()

    statements = ['(diag.icd9code between 410 and 415 or diag.icd9code like "425%" or diag.icd9code between 428 and 430)',
              '(diag.icd9code between 430 and 439 or diag.icd9code between 440 and 449)',
              '(diag.icd9code between 580 and 590)',]
    statements.insert(0, 'not ' + ' and not '.join(statements))

    diastolic_thresholds = [90, 75, 75, 90]
    systolic_thresholds = [140, 125, 125, 140]
    bmi_ranges = [0, 14, 18, 24.9, 29.9, 34.9, 1000]
    age_range_radius = 10
    age_range_center = 20

    forms = bottle.request.forms
    first_name = forms.get('firstName')
    last_name = forms.get('lastName')
    gender = forms.get('genderOptionsRadio') #'male' or 'female'
    age = int(forms.get('ageField'))
    weight = int(forms.weightField)
    height_feet = int(forms.heightFeet)
    height_inches = int(forms.heightInches)
    height_total = height_feet * 12 + height_inches
    bp_systolic = int(forms.bloodPressureSystolic)
    bp_diastolic = int(forms.bloodPressureDiastolic)
    diseases = forms.dict['diseasesCheckboxes']
    chart_enable = [len(diseases)==0,
                    'heartdisease' in diseases,
                    'stroke' in diseases,
                    'kidneydisease' in diseases]
    user_is_healthy = chart_enable[0]
    
    target_diastolic = diastolic_thresholds[int(user_is_healthy)]
    target_systolic = systolic_thresholds[int(user_is_healthy)]

    bmi = weight * 703.0 / (height_total * height_total)
    bmi_index = 0
    while bmi_index < len(bmi_ranges) - 1:
            if bmi < bmi_ranges[bmi_index + 1]:
                break
            bmi_index += 1
    bmi_min = bmi_ranges[bmi_index]
    bmi_max = bmi_ranges[bmi_index + 1]

    count_under = [0]*4
    count_over = [0]*4

"""
    initial_data = [0.2, 0.3, 0.4, 0.5]

    adjusted_data = [0.3, 0.4, 0.5, 0.6]

    """
    for i in range(len(chart_enable)):
        diastolic_threshold = diastolic_thresholds[i]
        systolic_threshold = systolic_thresholds[i]
        statement = statements[i]

        query1 = """"""select count(diag.patientguid) as cnt from syncchart 
                as chart, syncpatient as pat, syncdiagnosis as 
                diag where chart.patientguid=pat.patientguid and 
                pat.patientguid=diag.patientguid and pat.yearofbirth 
                between 2011-($(age)d+$(age_range_center)d)+$(age_range_radius)d 
                and 2011-($(age)d+$(age_range_center)d)-$(age_range_radius)d and 
                pat.gender=$(gender)s and chart.bmi between $(bmimin)d and 
                $(bmimax)d and (chart.diastolicbp >= $(dia_thresh)d or 
                chart.systolicbp >= $(sys_thresh)d) and """""" + statement 
        print repr(query1)
        dbcur.execute(query1, {'age': age, 'age_range_center': age_range_center,
                               'age_range_radius': age_range_radius,
                               'gender': gender, 'bmimin': bmi_min,
                               'bmimax': bmi_max, 'dia_thresh': diastolic_threshold,
                               'sys_thresh': systolic_threshold})
        #return ''.join(str(res) for res in r)
        import pdb; pdb.set_trace()
        row = dbcur.fetchone()[0]
        count_over[i] = row.cnt
        query2 = "select count(diag.patientguid) as cnt from syncchart as chart, " \
                 "syncpatient as pat, syncdiagnosis as diag where " \
                 "chart.patientguid=pat.patientguid and pat.patientguid" \
                 "=diag.patientguid and pat.yearofbirth between 2011-" \
                 "($age+$age_range_center+$age_range_radius) and 2011-($age+" \
                 "$age_range_center-$age_range_radius) and pat.gender=$gender " \
                 "and chart.bmi between $bmimin and $bmimax and (chart.diastolicbp " \
                 "< $dia_thresh and chart.systolicbp < $sys_thresh) and " + statement
        print repr(query2)
        r = db.query(query2, vars = {'age': age, 'age_range_center': age_range_center,
                                     'age_range_radius': age_range_radius,
                                     'gender': gender, 'bmimin': bmi_min,
                                     'bmimax': bmi_max, 'dia_thresh': diastolic_threshold,
                                     'sys_thresh': systolic_threshold})
        row = r[0]
        count_under[i] = row.cnt
        print 'Under:', count_under[i], 'Over:', count_over[i]
    total_under = sum(count_under)
    total_over = sum(count_over)

    initial_data = [1.0 * over / total_over for over in count_over]
    adjusted_data = [1.0 * under / total_under for under in count_under]

    dbcon.close()

"""
    return template('chart', 
                    first_name = 'hi',#first_name,
                    last_name = 'hi',#last_name,
                    bp_systolic = 150,#bp_systolic,
                    bp_diastolic = 90,#bp_diastolic,
                    target_systolic = 140,#target_systolic,
                    target_diastolic = 80,#target_diastolic,
                    initial_data = initial_data,
                    adjusted_data = adjusted_data,
                    )

@route('/static/<filepath:path>')
def server_static(filepath):
    return bottle.static_file(filepath, root='./static')

bottle.run(host='localhost', port=PORT, reloader=(DEPLOYMENT == 'dev'))

