from flask_babel import lazy_gettext as _ 

class ApiResources():
    
    not_found= _("La ressource demandée est introuvable !")
    registration_canceled = _("Enregistrement annulé")
    deletion_canceled = _("Suppression annulée")    
    code_incorrect= _("Le code est incorrect !")
    captcha_incorrect= _("Le code est incorrect !")
    registration_canceled_data_incorrect = _("Enregistrement annulé, les données sont incorrectes.")
    too_many_attempts = _("Trop de tentative, veuillez patienter")
    
    login_password_incorrect= _("login ou mot de passe incorrectes !")
    login_conflict= _("Le login existe déjà, veuillez choisir un autre !")
    login_phone_incorrect= _("login ou téléphone incorrectes !")
    passwords_not_identical = _("Les mots de passe ne sont pas identiques")
    passwords_reset= _("Réinitialisation du mot de passe")
    passwords_reset_mail= _("Compte {}, <br/>Voici votre code de récupération: <b> {} </b>")
    passwords_reset_mail_warning= _("<br/>Si vous n'êtes pas à l'origine de cette demande, ne faîtes rien !")
    class_obligatory = _("La classe est obligatoire !")
    
    deletion_content_canceled = _("Le contenu ne peut pas être supprimer pour le moment")
    deletion_chapter_canceled = _("Le module ne peut pas être supprimer pour le moment")
    deletion_chapter_canceled_infos = _("Pour des raisons de sécurité, le module ne peut pas être supprimer: veuillez vous assurez que toutes les Leçons du Module sont supprimées.")
    deletion_course_canceled = _("Le cours ne peut pas être supprimer pour le moment")
    deletion_course_canceled_infos = _("Pour des raisons de sécurité, le cours ne peut pas être supprimer: veuillez vous assurez que tous les modules du cours sont supprimés.")
    
    account_ok_classes_incorrect= _("Le compte est bien enregistré, mais les classes ne sont pas insérées correctement, veuillez contacter l'administrateur.")
    deletion_prof_canceled = _("Le professeur ne peut pas être supprimer, il existe des données liées à son profil")
    deletion_student_canceled = _("L\'étudiant ne peut pas être supprimer, des données sont liées à son profil")
    deletion_classes_prof_canceled = _("Vous ne pouvez pas supprimer certaines classes, elles sont en cours d\'utilisation par les professeurs.")
    deletion_subjects_prof_canceled = _("Vous ne pouvez pas supprimer certaines matières, elles sont en cours d\'utilisation par les professeurs.")
