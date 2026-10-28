export const mapApiToPricingPlan = (apiData: any): PricingPlan => {
    return {
        id: apiData.id.toString(),
        name: {
            fr: apiData.name,
            en: apiData.name,
            es: apiData.name
        },
        subtitle: {
            fr: apiData.name === "DEMO" ? "Version d'essai" : "Étudiant / Mois",
            en: apiData.name === "DEMO" ? "Trial Version" : "Student / Month",
            es: apiData.name === "DEMO" ? "Versión de prueba" : "Estudiante / Mes"
        },
        price: `${apiData.price_per_student} DH`,
        unit: { fr: "DH", en: "DH", es: "DH" },
        totalStudents: `${apiData.min_students} - ${apiData.max_students}`,
        maxTeachers: apiData.max_teachers.toString(),
        maxCoursesPerTeacher: apiData.max_courses_per_prof.toString(),
        support: {
            fr: `Support : ${apiData.name}`,
            en: `Support: ${apiData.name}`,
            es: `Soporte: ${apiData.name}`
        },
        discount: apiData.discount_percentage > 0 ? `Remise : ${apiData.discount_percentage}%` : "",
        minDuration: {
            fr: apiData.duration_days > 0 ? `Durée : ${apiData.duration_days} jours` : `Engagement : ${apiData.discount_start_month} mois`,
            en: apiData.duration_days > 0 ? `Duration: ${apiData.duration_days} days` : `Commitment: ${apiData.discount_start_month} months`,
            es: apiData.duration_days > 0 ? `Duración: ${apiData.duration_days} días` : `Compromiso: ${apiData.discount_start_month} meses`
        },
        popular: apiData.featured === 1,
        isEnterprise: apiData.name === "ENTERPRISE"
    };
};


export interface PricingPlan {
    id: string;
    name: { fr: string; en: string; es: string };
    subtitle: { fr: string; en: string; es: string };
    price: string;
    unit: { fr: string; en: string; es: string };
    totalStudents: string;
    maxTeachers: string;
    maxCoursesPerTeacher: string;
    support: { fr: string; en: string; es: string };
    discount: string;
    minDuration: { fr: string; en: string; es: string };
    popular?: boolean;
    isEnterprise?: boolean;
}

export const getPricingPlans = async (): Promise<PricingPlan[]> => {
    try {
        const response = await fetch(import.meta.env.VITE_PACKAGES_API_URL, {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json',
            },
        });

        if (!response.ok) {
            throw new Error(`Erreur serveur: ${response.status}`);
        }

        const rawData = await response.json();

        // On transforme et on retourne le tableau mappé
        return rawData.map((item: any) => mapApiToPricingPlan(item));

    } catch (error) {
        console.error("Erreur lors de la récupération des prix :", error);
        // Retourner un tableau vide permet à l'UI de ne pas crash
        // Ou vous pouvez retourner 'dummyPricing' en fallback si l'API échoue
        return [];
    }
};
