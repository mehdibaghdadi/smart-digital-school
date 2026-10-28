import React from 'react';
import { motion } from 'motion/react';
import { Globe, ChevronRight, Play, TrendingUp, Users } from 'lucide-react';
import { Language, translations } from '../translations';

export const Hero = ({ lang }: { lang: Language }) => {
    const t = translations[lang].hero;
    const loginUrl = {
        fr: import.meta.env.VITE_LOGIN_URL_FR,
        en: import.meta.env.VITE_LOGIN_URL_EN,
        es: import.meta.env.VITE_LOGIN_URL_ES,
    }[lang] || import.meta.env.VITE_LOGIN_URL_FR;
    return (
        <section className="relative pt-16 pb-16 lg:pt-16 lg:pb-24 overflow-hidden bg-white dark:bg-dark-bg transition-colors">
            <div className="relative z-10 max-w-7xl mx-auto px-6 grid lg:grid-cols-2 gap-16 items-center">
                <motion.div
                    initial={{ opacity: 0, x: -30 }}
                    animate={{ opacity: 1, x: 0 }}
                    transition={{ duration: 0.6 }}
                >
                    <div className="inline-flex items-center gap-2 px-3 py-1 bg-brand-50 dark:bg-brand-900/30 text-brand-700 dark:text-brand-300 rounded-full text-xs font-bold uppercase tracking-wider mb-6">
                        <Globe size={14} />
                        {t.badge}
                    </div>
                    <h1 className="text-4xl uppercase  font-extrabold text-slate-900 dark:text-white leading-[1.1] mb-8">
                        {t.title.split('{span}')[0].split(' ').map((word, i) => (
                            <motion.span
                                key={i}
                                initial={{ opacity: 0, y: 20 }}
                                animate={{ opacity: 1, y: 0 }}
                                transition={{ duration: 0.5, delay: i * 0.1 }}
                                className="inline-block mr-2"
                            >
                                {word}
                            </motion.span>
                        ))}
                        <motion.span
                            initial={{ opacity: 0, scale: 0.8 }}
                            animate={{ opacity: 1, scale: 1 }}
                            transition={{ duration: 0.5, delay: 0.5 }}
                            className="text-brand-600 dark:text-brand-500 inline-block mr-3"
                        >
                            {t.span}
                        </motion.span>
                        {t.title.split('{span}')[1].split(' ').map((word, i) => (
                            <motion.span
                                key={i}
                                initial={{ opacity: 0, y: 20 }}
                                animate={{ opacity: 1, y: 0 }}
                                transition={{ duration: 0.5, delay: 0.6 + i * 0.1 }}
                                className="inline-block mr-3"
                            >
                                {word}
                            </motion.span>
                        ))}
                    </h1>
                    <p className="text-xl text-slate-600 dark:text-slate-300 leading-relaxed mb-10 max-w-xl">
                        {t.desc}
                    </p>
                    <div className="flex flex-col sm:flex-row gap-4">
                        <a
                            href="#solution"
                            className="px-8 py-4 bg-brand-600 text-white font-bold rounded-2xl hover:bg-brand-700 transition-all shadow-lg shadow-brand-600/20 flex items-center justify-center gap-2 group"
                        >
                            {t.ctaStart}
                            <ChevronRight size={20} className="group-hover:translate-x-1 transition-transform" />
                        </a>
                        <a
                            href={loginUrl}
                            className="px-8 py-4 bg-white dark:bg-dark-card border-2 border-slate-100 dark:border-slate-600 text-slate-900 dark:text-white font-bold rounded-2xl hover:border-brand-200 transition-all flex items-center justify-center gap-2"
                        >
                            {t.ctaDemo}
                        </a>
                    </div>

                    <div className="mt-12 lg:flex items-center gap-6">
                        <div className="flex -space-x-3">
                            {[1, 2, 3, 4].map((i) => (
                                <img
                                    key={i}
                                    src={`https://picsum.photos/seed/user${i}/100/100`}
                                    alt="User"
                                    className="w-10 h-10 rounded-full border-2 border-white dark:border-dark-card"
                                    referrerPolicy="no-referrer"
                                />
                            ))}
                        </div>
                        <p className="text-sm text-slate-500 dark:text-slate-400">
                            {t.users.split('{span}')[0]}
                            <span className="font-bold text-slate-900 dark:text-white">{t.usersSpan}</span>
                            {t.users.split('{span}')[1]}
                        </p>
                    </div>
                </motion.div>

                <motion.div
                    initial={{ opacity: 0, scale: 0.9 }}
                    animate={{ opacity: 1, scale: 1 }}
                    transition={{ duration: 0.6, delay: 0.2 }}
                    className="relative"
                >
                    <div className="relative flex justify-center z-10 rounded-3xl overflow-hidden shadow-2xl bg-white border-8 border-white dark:border-dark-card">
                        <img
                            src="/anime-learning.gif"
                            alt="Platform Preview"
                            className="w-full lg:w-96 h-auto"
                            referrerPolicy="no-referrer"
                        />

                    </div>

                    {/* Floating Cards */}
                    <motion.div
                        animate={{ y: [0, -10, 0] }}
                        transition={{ duration: 4, repeat: Infinity, ease: "easeInOut" }}
                        className="absolute -top-6 -right-6 bg-white dark:bg-dark-card p-4 rounded-2xl shadow-xl z-20  sm:block"
                    >
                        <div className="flex items-center gap-3">
                            <div className="w-10 h-10 bg-blue-100 dark:bg-blue-900/30 rounded-lg flex items-center justify-center text-blue-600">
                                <TrendingUp size={20} />
                            </div>
                            <div>
                                <p className="text-xs text-slate-500 dark:text-slate-400 font-medium">Croissance</p>
                                <p className="text-sm font-bold text-slate-900 dark:text-white">+124% ce mois</p>
                            </div>
                        </div>
                    </motion.div>

                    <motion.div
                        animate={{ y: [0, 10, 0] }}
                        transition={{ duration: 5, repeat: Infinity, ease: "easeInOut" }}
                        className="absolute -bottom-6 -left-6 bg-white dark:bg-slate-800 p-4 rounded-2xl shadow-xl z-20  sm:block"
                    >
                        <div className="flex items-center gap-3">
                            <div className="w-10 h-10 bg-brand-100 dark:bg-brand-900/30 rounded-lg flex items-center justify-center text-brand-600">
                                <Users size={20} />
                            </div>
                            <div>
                                <p className="text-xs text-slate-500 dark:text-slate-400 font-medium">Étudiants actifs</p>
                                <p className="text-sm font-bold text-slate-900 dark:text-white">1,240 inscrits</p>
                            </div>
                        </div>
                    </motion.div>
                </motion.div>
            </div>
        </section>
    );
};
