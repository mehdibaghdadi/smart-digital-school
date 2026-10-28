from ...utilities.flask.flask_menu import FlaskMenu,is_visible
app_menu_admin = FlaskMenu(children=[
    dict(
        menu_id='0',
        title='Tableau de bord',
        icon='nav-icon fas fa-th',
        endpoint='IndexAdminView:index',
        is_visible=lambda menu_instance:is_visible(menu_instance),
    )
   
    
])
