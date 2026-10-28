import React, { useState, useEffect } from 'react';
import { motion } from 'motion/react';
import { CheckCircle2, AlertTriangle, Info } from 'lucide-react';
import { Language, translations } from '../translations';
import { getPricingPlans, PricingPlan } from '../services/pricingService';

export const Pricing = ({ lang }: { lang: Language }) => {
    const t = translations[lang].pricing;
    const [plans, setPlans] = useState<PricingPlan[]>([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const fetchPlans = async () => {
            try {
                const data = await getPricingPlans();
                setPlans(data);
            } catch (error) {
                console.error("Error fetching pricing plans:", error);
            } finally {
                setLoading(false);
            }
        };
        fetchPlans();
    }, []);

    if (loading) return <div className="text-center py-20">Loading...</div>;

    return (
        <section id="pricing" className="py-16 bg-white dark:bg-dark-bg transition-colors">
            <div className="max-w-7xl mx-auto px-3 lg:px-2">
                <h2 className="text-3xl uppercase font-extrabold text-slate-900 dark:text-white mb-12 text-center">
                    {t.title}
                </h2>

                <div className="grid md:grid-cols-2 lg:grid-cols-5 gap-4">
                    {plans.map((plan) => (
                        <motion.div
                            key={plan.id}
                            className={`relative p-6 rounded-[20px] border transition-all flex flex-col ${plan.popular
                                    ? 'bg-slate-800 text-white border-slate-800'
                                : 'bg-[#fffff0] dark:bg-black border-slate-200'
                                }`}
                        >
                            <div className={`text-center mb-4 p-2 rounded-lg font-bold ${plan.popular ? 'bg-slate-700' : 'bg-slate-200 dark:bg-slate-500'}`}>
                                {plan.name[lang]}
                            </div>
                            <div className="text-center text-xs text-slate-500 mb-6">{plan.subtitle[lang]}</div>

                            <div className="text-center mb-6  py-2 shadow-sm shadow-gray-300 rounded">
                                <div className="text-4xl font-extrabold">{plan.price}</div>
                            </div>

                            <ul className="space-y-4 mb-6 flex-grow text-sm">
                                <li className="flex items-center gap-2"><CheckCircle2 size={16} className="text-green-600 shrink-0" /> <div><div className="font-bold">{t.table.totalStudents}</div>{plan.totalStudents}</div></li>
                                <li className="flex items-center gap-2"><CheckCircle2 size={16} className="text-green-600 shrink-0" /> <div><div className="font-bold">{t.table.maxTeachers}</div>{plan.maxTeachers}</div></li>
                                <li className="flex items-center gap-2"><CheckCircle2 size={16} className="text-green-600 shrink-0" /> <div><div className="font-bold">{t.table.maxCoursesPerTeacher}</div>{plan.maxCoursesPerTeacher}</div></li>

                                {plan.id === 'demo' ? (
                                    <>
                                        <li className="flex items-center gap-2 text-slate-500"><Info size={16} /> {plan.support[lang]}</li>
                                        <li className="flex items-center gap-2 text-red-600"><AlertTriangle size={16} /> {plan.minDuration[lang]}</li>
                                    </>
                                ) : (
                                    <>
                                        <li className="flex items-center gap-2 text-slate-500"><Info size={16} /> {plan.support[lang]}</li>
                                        <li className="flex items-center gap-2 text-green-600"><CheckCircle2 size={16} /> {plan.discount}</li>
                                        <li className="text-xs text-center text-slate-500 mt-2"><small>{t.table.minDurationLabel}</small><br /><span className="font-bold text-lg">{plan.minDuration[lang]}</span></li>
                                    </>
                                )}
                            </ul>

                        </motion.div>
                    ))}
                </div>
            </div>
        </section>
    );
};
