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
    #TODO: implement
    return 'Check back soon!'

@route('/education')
def education():
    return template('education')
    #TODO: implement
    return 'Check back soon!'

@route('/salt_smart')
def salt_smart():
    #TODO: implement
    return 'Check back soon!'

@route('/salt_smart_answer')
def salt_smart_answer():
    #TODO: implement
    return 'Check back soon!'

@route('/static/<filepath:path>')
def server_static(filepath):
    return bottle.static_file(filepath, root='./static')

bottle.run(host='localhost', port=8080, reloader=True)
