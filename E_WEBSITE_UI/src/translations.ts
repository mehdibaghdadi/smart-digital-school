export type Language = 'fr' | 'en' | 'es';

export const translations = {
  fr: {
    nav: {
      presentation: 'Présentation',
      solution: 'Solution',
      howItWorks: 'Fonctionnement',
      pricing: 'Tarifs',
      ai: 'IA',
      contact: 'Contact',
      login: 'Connexion',
    },
    hero: {
      badge: "L'éducation du futur, aujourd'hui",
      title: "Créez votre {span} performante.",
      span: "école en ligne",
      desc: "Transformez votre passion en succès digital. Smart Digital School est la plateforme tout-en-un pour lancer et gérer votre activité d'enseignement en ligne.",
      ctaStart: "Commencez ici",
      ctaDemo: "Essayer la Démo",
      users: "Rejoignez {span} de l'éducation",
      usersSpan: "+500 entrepreneurs",
    },
    mission: {
      title: "Notre mission",
      desc: "Nous révolutionnons la manière dont les gens perçoivent et vivent la formation. Nous bâtissons une communauté d’entrepreneurs innovants.",
      items: [
        {
          title: "Accompagnement",
          desc: "De l'idée à la réalisation, nous vous guidons à chaque étape de votre projet éducatif.",
        },
        {
          title: "Innovation",
          desc: "Une plateforme Smart Digital School pensée pour les besoins de demain.",
        },
        {
          title: "Communauté",
          desc: "Rejoignez un écosystème d'enseignants et d'entrepreneurs passionnés.",
        }
      ]
    },
    whyUs: {
      title: "Pourquoi choisir {span} ?",
      span: "Smart Digital School",
      tabs: [
        {
          title: "Efficacité",
          content: "Une plateforme tout-en-un pensée pour les entrepreneurs de l’éducation, qu’ils soient novices ou expérimentés. Gérez tout depuis un seul endroit.",
          features: ["Gestion centralisée", "Outils intuitifs", "Tableaux de bord KPI"]
        },
        {
          title: "Coût",
          content: "Nous croyons que le succès ne doit pas coûter une fortune. Tarifs transparents et compétitifs adaptés à vos ambitions.",
          features: ["Pas de frais cachés", "Excellent ROI", "Formules flexibles"]
        },
        {
          title: "Rapidité",
          content: "Lancez votre activité en un temps record. Installation simplifiée sans compétences techniques nécessaires.",
          features: ["Mise en place immédiate", "Support réactif", "Résultats rapides"]
        }
      ],
      ecosystemTitle: "Un Écosystème au Service de l'Éducation",
      ecosystemItems: [
        { title: "Cours digital", desc: "Cours structurés en matières et chapitres pour faciliter l’apprentissage." },
        { title: "Classe Virtuelle", desc: "Un cadre habituel pour permettre aux étudiants de se retrouver." },
        { title: "Interaction", desc: "Interaction fluide et optimale entre professeurs et élèves." }
      ]
    },
    howItWorks: {
      title: "Comment ça fonctionne ?",
      desc: "Notre application est conçue pour répondre aux besoins de trois profils principaux. Chaque rôle dispose d'un accès personnalisé.",
      status: "Plateforme active 24/7",
      roles: [
        { role: "Administrateur", desc: "Configurez votre école : classes, matières, professeurs et élèves." },
        { role: "Professeur", desc: "Créez vos cours en ligne et interagissez avec vos élèves." },
        { role: "Étudiant", desc: "Sélectionnez vos cours et demandez de l'assistance en cas de besoin." },
        { role: "Tableau de bord", desc: "Suivez l'ensemble des KPI pour un pilotage optimal de votre activité." }
      ]
    },
    ai: {
      badge: "Intelligence Artificielle",
      title: "Générez vos plans de cours avec l'IA",
      desc: "Gagnez un temps précieux grâce à notre IA intégrée. Elle analyse vos sujets et génère des structures de cours complètes, cohérentes et prêtes à l'emploi.",
      features: [
        "Génération de chapitres automatique",
        "Objectifs pédagogiques personnalisés",
        "Quiz et exercices suggérés"
        ],
        steps: [
            "Cadrage du module",
            "Paramétrage pédagogique",
            "Ingénierie du cursus",
            "Modélisation en cours",
            "Structure finalisée",
            "Publication ou Réitération"
        ]
    },
        pricing: {
            title: "Nos Tarifs",
            desc: "Choisissez le pack qui correspond le mieux à votre structure.",
            table: {
                totalStudents: "Total Étudiants",
                maxTeachers: "Max. Enseignant",
                maxCoursesPerTeacher: "Max. Cours / Enseignant",
                support: "Support",
                discount: "Remise",
                subscribe: "S'ABONNER",
                edit: "VOTRE ABONNEMENT : EDITER",
                minDurationLabel: "REMISE VALABLE POUR ABONNEMENT D'UNE DURÉE MINIMALE DE :"
            }
        },
    contact: {
      title: "Restons en contact",
      desc: "Une question ? Notre équipe est là pour vous aider.",
      form: {
        name: "Nom",
        email: "Email",
        message: "Message",
        send: "Envoyer le message"
      },
      info: {
          country: "Maroc",
          address: "Adresse",
        phone: "Téléphone",
        email: "E-mail"
      },
      notifications: {
        successTitle: "Message envoyé !",
        successText: "Merci pour votre message. Nous vous répondrons dans les plus brefs délais.",
        errorTitle: "Erreur",
        errorText: "Une erreur est survenue lors de l'envoi du message. Veuillez réessayer plus tard."
      }
    },
    cta: {
      title: "Prêt à transformer votre vision en réalité ?",
      desc: "Découvrez notre plateforme avec la version démo gratuite avant de choisir le pack qui correspond le mieux à votre structure.",
      demo: "S'inscrire à la Démo",
      brochure: "Télécharger la brochure"
    },
    footer: {
      desc: "La plateforme innovante qui simplifie la création de votre école digitale en quelques clics. Rejoignez la révolution de l'enseignement en ligne.",
      platform: "Plateforme",
      legal: "Légal",
      privacy: "Confidentialité",
      terms: "Conditions d'utilisation",
      rights: "Tous droits réservés.",
      powered: "Propulsé par"
    },
    showcase: {
      title: "L'excellence éducative à l'ère du digital",
      desc: "Découvrez la plateforme tout-en-un qui transforme la gestion de votre école et booste l'apprentissage de vos élèves.",
      cta: "Explorer la plateforme"
    }
  },
  en: {
    nav: {
      presentation: 'Presentation',
      solution: 'Solution',
      howItWorks: 'How it works',
      pricing: 'Pricing',
      ai: 'AI',
      contact: 'Contact',
      login: 'Login',
    },
    hero: {
      badge: "The education of the future, today",
      title: "Create your high-performance {span}.",
      span: "online school",
      desc: "Transform your passion into digital success. Smart Digital School is the all-in-one platform to launch and manage your online teaching activity.",
      ctaStart: "Start here",
      ctaDemo: "Try the Demo",
      users: "Join {span} of education",
      usersSpan: "+500 entrepreneurs",
    },
    mission: {
      title: "Our Mission",
      desc: "We are revolutionizing the way people perceive and experience training. We are building a community of innovative entrepreneurs.",
      items: [
        {
          title: "Support",
          desc: "From idea to realization, we guide you through every step of your educational project.",
        },
        {
          title: "Innovation",
          desc: "A Smart Digital School platform designed for tomorrow's needs.",
        },
        {
          title: "Community",
          desc: "Join an ecosystem of passionate teachers and entrepreneurs.",
        }
      ]
    },
    whyUs: {
      title: "Why choose {span}?",
      span: "Smart Digital School",
      tabs: [
        {
          title: "Efficiency",
          content: "An all-in-one platform designed for education entrepreneurs, whether they are novices or experienced. Manage everything from one place.",
          features: ["Centralized management", "Intuitive tools", "KPI dashboards"]
        },
        {
          title: "Cost",
          content: "We believe that success shouldn't cost a fortune. Transparent and competitive rates adapted to your ambitions.",
          features: ["No hidden fees", "Excellent ROI", "Flexible formulas"]
        },
        {
          title: "Speed",
          content: "Launch your activity in record time. Simplified installation without technical skills required.",
          features: ["Immediate setup", "Responsive support", "Fast results"]
        }
      ],
      ecosystemTitle: "An Ecosystem at the Service of Education",
      ecosystemItems: [
        { title: "Digital Course", desc: "Courses structured in subjects and chapters to facilitate learning." },
        { title: "Virtual Class", desc: "A familiar setting to allow students to meet." },
        { title: "Interaction", desc: "Fluid and optimal interaction between teachers and students." }
      ]
    },
    howItWorks: {
      title: "How does it work?",
      desc: "Our application is designed to meet the needs of three main profiles. Each role has personalized access.",
      status: "Platform active 24/7",
      roles: [
        { role: "Administrator", desc: "Configure your school: classes, subjects, teachers, and students." },
        { role: "Teacher", desc: "Create your online courses and interact with your students." },
        { role: "Student", desc: "Select your courses and request assistance if needed." },
        { role: "Dashboard", desc: "Follow all KPIs for optimal management of your activity." }
      ]
    },
    ai: {
      badge: "Artificial Intelligence",
      title: "Generate your course plans with AI",
      desc: "Save precious time with our integrated AI. It analyzes your subjects and generates complete, coherent, and ready-to-use course structures.",
      features: [
        "Automatic chapter generation",
        "Personalized pedagogical objectives",
        "Suggested quizzes and exercises"
        ],
        steps: [
            "Module Framework",
            "Pedagogical Settings",
            "Curriculum Engineering",
            "Modeling in Progress",
            "Finalized Structure",
            "Publication or Reiteration"
        ]
    },
      pricing: {
          title: "Our Pricing",
          desc: "Choose the pack that best fits your structure.",
          table: {
              totalStudents: "Total Students",
              maxTeachers: "Max. Teachers",
              maxCoursesPerTeacher: "Max. Courses / Teacher",
              support: "Support",
              discount: "Discount",
              subscribe: "SUBSCRIBE",
              edit: "YOUR SUBSCRIPTION: EDIT",
              minDurationLabel: "DISCOUNT VALID FOR SUBSCRIPTIONS WITH A MINIMUM TERM OF"
          }
      },
    contact: {
      title: "Get in touch",
      desc: "Any questions? Our team is here to help.",
      form: {
        name: "Name",
        email: "Email",
        message: "Message",
        send: "Send message"
      },
      info: {
        country: "Morocco",
        address: "Address",
        phone: "Phone",
        email: "E-mail"
      },
      notifications: {
        successTitle: "Message sent!",
        successText: "Thank you for your message. We will get back to you as soon as possible.",
        errorTitle: "Error",
        errorText: "An error occurred while sending the message. Please try again later."
      }
    },
    cta: {
      title: "Ready to transform your vision into reality?",
      desc: "Discover our platform with the free demo version before choosing the pack that best fits your structure.",
      demo: "Register for Demo",
      brochure: "Download brochure"
    },
    footer: {
      desc: "The innovative platform that simplifies the creation of your digital school in a few clicks. Join the online teaching revolution.",
      platform: "Platform",
      legal: "Legal",
      privacy: "Privacy",
      terms: "Terms of Use",
      rights: "All rights reserved.",
      powered: "Powered by"
    },
    showcase: {
      title: "Educational excellence in the digital age",
      desc: "Discover the all-in-one platform that transforms your school management and boosts your students' learning.",
      cta: "Explore the platform"
    }
  },
  es: {
    nav: {
      presentation: 'Presentación',
      solution: 'Solución',
      howItWorks: 'Funcionamiento',
      pricing: 'Precios',
      ai: 'IA',
      contact: 'Contacto',
      login: 'Iniciar sesión',
    },
    hero: {
      badge: "La educación del futuro, hoy",
      title: "Crea tu {span} de alto rendimiento.",
      span: "escuela en línea",
      desc: "Transforma tu pasión en éxito digital. Smart Digital School es la plataforma todo en uno pour lanzar y gestionar tu actividad de enseñanza en línea.",
      ctaStart: "Empieza aquí",
      ctaDemo: "Probar la Demo",
      users: "Únete a {span} de la educación",
      usersSpan: "+500 emprendedores",
    },
    mission: {
      title: "Nuestra Misión",
      desc: "Estamos revolucionando la forma en que las personas perciben y viven la formación. Estamos construyendo una comunidad de emprendedores innovadores.",
      items: [
        {
          title: "Acompañamiento",
          desc: "Desde la idea hasta la realización, te guiamos en cada paso de tu proyecto educativo.",
        },
        {
          title: "Innovación",
          desc: "Una plataforma Smart Digital School pensada para las necesidades del mañana.",
        },
        {
          title: "Comunidad",
          desc: "Únete a un ecosistema de profesores y emprendedores apasionados.",
        }
      ]
    },
    whyUs: {
      title: "¿Por qué elegir {span}?",
      span: "Smart Digital School",
      tabs: [
        {
          title: "Eficiencia",
          content: "Una plataforma todo en uno diseñada para emprendedores de la educación, ya sean novatos o experimentados. Gestiona todo desde un solo lugar.",
          features: ["Gestión centralizada", "Herramientas intuitivas", "Cuadros de mando KPI"]
        },
        {
          title: "Costo",
          content: "Creemos que el éxito no debe costar una fortuna. Tarifas transparentes y competitivas adaptadas a tus ambiciones.",
          features: ["Sin cargos ocultos", "Excelente ROI", "Fórmulas flexibles"]
        },
        {
          title: "Rapidez",
          content: "Lanza tu actividad en tiempo récord. Instalación simplificada sin necesidad de conocimientos técnicos.",
          features: ["Configuración inmediata", "Soporte receptivo", "Resultados rápidos"]
        }
      ],
      ecosystemTitle: "Un Ecosistema al Servicio de la Educación",
      ecosystemItems: [
        { title: "Curso Digital", desc: "Cursos estructurados en materias y capítulos para facilitar el aprendizaje." },
        { title: "Clase Virtual", desc: "Un entorno familiar para permitir que los estudiantes se encuentren." },
        { title: "Interacción", desc: "Interacción fluida y óptima entre profesores y alumnos." }
      ]
    },
    howItWorks: {
      title: "¿Cómo funciona?",
      desc: "Nuestra aplicación está diseñada para satisfacer las necesidades de tres perfiles principales. Cada rol tiene un acceso personalizado.",
      status: "Plataforma activa 24/7",
      roles: [
        { role: "Administrador", desc: "Configura tu escuela: clases, materias, profesores y alumnos." },
        { role: "Profesor", desc: "Crea tus cursos en línea e interactúa con tus alumnos." },
        { role: "Estudiante", desc: "Selecciona tus cursos y solicita asistencia si es necesario." },
        { role: "Panel de control", desc: "Sigue todos los KPI para una gestión óptima de tu actividad." }
      ]
    },
    ai: {
      badge: "Inteligencia Artificial",
      title: "Genera tus planes de curso con IA",
      desc: "Ahorra tiempo valioso con nuestra IA integrada. Analiza tus temas y genera estructuras de cursos completas, coherentes y listas para usar.",
      features: [
        "Generación automática de capítulos",
        "Objetivos pedagógicos personalizados",
        "Cuestionarios y ejercicios sugeridos"
        ],
        steps: [
           "Marco del módulo",
                "Configuración pedagógica",
                "Ingeniería curricular",
                "Modelado en curso",
                "Estructura finalizada",
            "Publicación o reiteración"
        ]
        
    },
pricing: {
      title: "Nuestros Precios",
      desc: "Elige el pack que mejor se adapte a tu estructura.",
      table: {
        totalStudents: "Total Estudiantes",
        maxTeachers: "Max. Profesores",
        maxCoursesPerTeacher: "Max. Cursos / Profesor",
        support: "Soporte",
        discount: "Descuento",
        subscribe: "SUSCRIBIRSE",
          edit: "TU SUSCRIPCIÓN: EDITAR",
          minDurationLabel: "DESCUENTO VÁLIDO PARA SUSCRIPCIONES CON UN PLAZO MÍNIMO DE"
      }
    },
    contact: {
      title: "Mantengámonos en contacto",
      desc: "¿Alguna pregunta? Nuestro equipo está aquí para ayudarte.",
      form: {
        name: "Nombre",
        email: "Correo electrónico",
        message: "Mensaje",
        send: "Enviar mensaje"
      },
      info: {
          country: "Marruecos",
          address: "Dirección",
          phone: "Teléfono",
        email: "E-mail"
      },
      notifications: {
        successTitle: "¡Mensaje enviado!",
        successText: "Gracias por su mensaje. Nos pondremos en contacto con usted lo antes posible.",
        errorTitle: "Error",
        errorText: "Se produjo un error al enviar el mensaje. Por favor, inténtelo de nuevo más tarde."
      }
    },
    cta: {
      title: "¿Listo para transformar tu visión en realidad?",
      desc: "Descubre nuestra plataforma con la versión demo gratuita antes de elegir el pack que mejor se adapte a tu estructura.",
      demo: "Registrarse para la Demo",
      brochure: "Descargar folleto"
    },
    footer: {
      desc: "La plataforma innovadora que simplifica la creación de tu escuela digital en unos pocos clics. Únete a la revolución de la enseñanza en línea.",
      platform: "Plataforma",
      legal: "Legal",
      privacy: "Privacidad",
      terms: "Condiciones de uso",
      rights: "Todos los derechos reservados.",
      powered: "Impulsado por"
    },
    showcase: {
      title: "Excelencia educativa en la era digital",
      desc: "Descubre la plataforma todo en uno que transforma la gestión de tu escuela y potencia el aprendizaje de tus alumnos.",
      cta: "Explorar la plataforma"
    }
  }
};
