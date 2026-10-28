import React from 'react';
import { motion } from 'motion/react';
import { Download } from 'lucide-react';
import { Language, translations } from '../translations';

export const CTA = ({ lang }: { lang: Language }) => {
    const t = translations[lang].cta;

    const loginUrl = {
        fr: import.meta.env.VITE_LOGIN_URL_FR,
        en: import.meta.env.VITE_LOGIN_URL_EN,
        es: import.meta.env.VITE_LOGIN_URL_ES,
    }[lang] || import.meta.env.VITE_LOGIN_URL_FR;

    const catalogUrl = {
        fr: import.meta.env.VITE_CATALOG_URL_FR,
        en: import.meta.env.VITE_CATALOG_URL_EN,
        es: import.meta.env.VITE_CATALOG_URL_ES,
    }[lang] || import.meta.env.VITE_CATALOG_URL_FR;

    return (
        <section className="py-5 relative overflow-hidden bg-white dark:bg-dark-bg transition-colors">
            <motion.div
                initial={{ opacity: 0, scale: 0.95 }}
                whileInView={{ opacity: 1, scale: 1 }}
                viewport={{ once: true }}
                transition={{ duration: 0.8, ease: "easeOut" }}
                className="max-w-7xl mx-auto px-6"
            >
                <div className="bg-brand-600 rounded-[48px] p-12 lg:p-24 text-center text-white relative overflow-hidden">
                    {/* Decorative circles */}
                    <div className="absolute top-0 left-0 -translate-x-1/2 -translate-y-1/2 w-96 h-96 bg-white/10 rounded-full blur-3xl" />
                    <div className="absolute bottom-0 right-0 translate-x-1/2 translate-y-1/2 w-96 h-96 bg-brand-400/20 rounded-full blur-3xl" />

                    <div className="relative z-10 max-w-3xl mx-auto">
                        <h2 className="text-4xl uppercase  font-extrabold mb-8">
                            {t.title}
                        </h2>
                        <p className="text-xl text-brand-100 mb-12">
                            {t.desc}
                        </p>
                        <div className="flex flex-col sm:flex-row gap-6 justify-center">
                            <a
                                href={loginUrl}
                                className="px-10 py-5 bg-white text-brand-600 font-extrabold rounded-2xl shadow-xl hover:scale-105 transition-transform"
                            >
                                {t.demo}
                            </a>
                            <a
                                href={catalogUrl}
                                target="_blank"
                                className="px-10 py-5 bg-brand-700 text-white font-extrabold rounded-2xl border border-brand-500 hover:bg-brand-800 transition-all flex items-center justify-center gap-2"
                            >
                                <Download size={20} />
                                {t.brochure}
                            </a>
                        </div>
                    </div>
                </div>
            </motion.div>
        </section>
    );
};
