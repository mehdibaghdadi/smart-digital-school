from importlib import import_module
import pkgutil

def get_all_routers():
    routers = []
    package = __name__

    # Parcourt les modules du package routers/
    for _, module_name, _ in pkgutil.iter_modules(__path__):
        module = import_module(f"{package}.{module_name}")
        if hasattr(module, "router"):
            routers.append(module.router)
    return routers
