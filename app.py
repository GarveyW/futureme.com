#!/usr/bin/env python
import bottle

bottle.debug(True)

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
    forms = bottle.request.forms
    first_name = forms.get('firstName')
    last_name = forms.get('lastName')
    gender = forms.get('genderOptionsRadio')
    age = forms.get('ageField')
    weight = forms.get('weightField')
    height_feet = forms.get('heightFeet')
    height_inches = forms.get('heightInches')
    height_total = height_feet * 12 + height_inches
    bp_systolic  = forms.get('bloodPressureSystolic')
    bp_diastolic = forms.get('bloodPressureDiastolic')
    diseases = forms.get('diseasesCheckboxes')
    initial_data = [0.2, 0.3, 0.4, 0.5]
    adjusted_data = [0.3, 0.4, 0.5, 0.6]
    return template('chart', 
                    first_name = first_name,
                    last_name = last_name,
                    gender = gender,
                    age = age,
                    weight = weight,
                    height = height_total,
                    bp_systolic = bp_systolic,
                    bp_diastolic = bp_diastolic,
                    diseases = diseases,
                    initial_data = initial_data,
                    adjusted_data = adjusted_data,
                    )

@route('/static/<filepath:path>')
def server_static(filepath):
    return bottle.static_file(filepath, root='./static')

bottle.run(host='localhost', port=8080, reloader=True)
