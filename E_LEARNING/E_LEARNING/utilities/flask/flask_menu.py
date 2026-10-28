from flask import g , current_app as app
from collections import OrderedDict


def is_visible(bool):
    return bool

class FlaskMenu(object):
   
    def __init__(self, menu_id=None, title_header=None, title=None, icon=None, endpoint=None, is_visible=None, children=None):
        self.menu_id = menu_id
        self.title_header = title_header
        self.title = title
        self.icon = icon
        self.endpoint = endpoint
        self.is_visible_callback = is_visible or (lambda menu_instance:True)
        self.child_entries = OrderedDict()
        if children and isinstance(children, (list, tuple)):
            for child in children:
                if isinstance(child, dict) and child.get('menu_id') and child.get('title'):
                    self.child_entries[child.get('menu_id')] = self.__class__(
                        menu_id=child.get('menu_id'),
                        title=child.get('title'),
                        title_header=child.get('title_header'),
                        icon=child.get('icon'),
                        endpoint=child.get('endpoint'),
                        is_visible=child.get('is_visible'),
                        children=child.get('children'),
                    )

    @property
    def children(self):
        return self.child_entries.values()

    @property
    def children(self):
        return self.child_entries.values()

    @staticmethod
    def set_active(menu_id):
        setattr(g, 'menu_id', menu_id)

    @staticmethod
    def get_active():
        return getattr(g, 'menu_id', None)

    def is_active(self):
        return self.menu_id == self.get_active()

    def has_active_child(self, recursive=True):
        for child in self.child_entries.values():
            if child.is_active():
                return True
        if recursive:
            for child in self.child_entries.values():
                if child.has_active_child(recursive=recursive):
                    return True
        return False

    def is_visible(self):
        return self.is_visible_callback(self)

    def has_visible_child(self, recursive=True):
        for child in self.child_entries.values():
            if child.is_visible():
                return True
        if recursive:
            for child in self.child_entries.values():
                if child.has_visible_child(recursive=recursive):
                    return True
        return False

    def get(self,menu_id):
        for c in self.child_entries.values():
            if c.menu_id==menu_id:
                return c

        for c in self.child_entries.values():
            item = c.get(menu_id)
            if  item:
                return item
        return None

    def get_by_end_point(self,end_point):
        for c in self.child_entries.values():
            if c.endpoint==end_point:
                return c

        for c in self.child_entries.values():
            item = c.get_by_end_point(end_point)
            if  item:
                return item
        return None

