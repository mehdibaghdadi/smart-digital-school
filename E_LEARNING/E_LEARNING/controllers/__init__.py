"""
Routes and views for the Hbabi application.
"""
import os 
import importlib as importlib   
from pathlib import Path
from flask import current_app as app 
from ..utilities.flask.flask_view import register_flaskviews 

"""
Import all views : ends with _view.py.
"""
def register_all_flaskviews():
    root = os.path.dirname(__file__)
    for dirpath, subdirs, files in os.walk(root, topdown=False, onerror=None, followlinks=True):
        for ffile in files:
            if ffile.endswith('_controller.py'):
                parent = Path(dirpath).name
                modulename = ( parent+"." if parent!="controllers" else "" ) + ffile.replace('.py','')
                try:
                    viewsfound = importlib.import_module('.' + modulename, package=__name__)

                    #register classes type flaskviews
                    register_flaskviews(app,viewsfound)
                    #print('OK... %s loaded.' % modulename)
                except Exception as ex:
                   print('KO... Module %s can`t be loaded!: ' % modulename)
                   raise Exception(ex) 

"""
register all flaskviews .
"""
register_all_flaskviews()

