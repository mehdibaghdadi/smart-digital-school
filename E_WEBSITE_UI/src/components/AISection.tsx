 import React from 'react';
import { motion } from 'motion/react';
import { Sparkles, CheckCircle2, Wand2 } from 'lucide-react';
import { Language, translations } from '../translations';

export const AISection = ({ lang }: { lang: Language }) => {
    const t = translations[lang].ai;
    const images = [
        "/slides/1.jpg",
        "/slides/2.jpg",
        "/slides/3.jpg",
        "/slides/loading.gif",
        "/slides/5.jpg",
        "/slides/6.jpg",
        "/slides/7.jpg",

    ];

    return (
        <section id="ai" className="py-24 bg-white dark:bg-dark-bg transition-colors overflow-hidden">
            <div className="max-w-7xl mx-auto px-6">
                <div className="grid lg:grid-cols-2 gap-16 items-center">
                    <motion.div
                        initial={{ opacity: 0, x: -30 }}
                        whileInView={{ opacity: 1, x: 0 }}
                        viewport={{ once: true }}
                        transition={{ duration: 0.6 }}
                    >
                        <div className="inline-flex items-center gap-2 px-3 py-1 bg-purple-50 dark:bg-purple-900/30 text-purple-700 dark:text-purple-300 rounded-full text-xs font-bold uppercase tracking-wider mb-6">
                            <Sparkles size={14} />
                            {t.badge}
                        </div>
                        <h2 className="text-4xl uppercase  font-extrabold text-slate-900 dark:text-white leading-tight mb-8">
                            {t.title}
                        </h2>
                        <p className="text-xl text-slate-600 dark:text-slate-300 leading-relaxed mb-10">
                            {t.desc}
                        </p>
                        <ul className="space-y-4">
                            {t.features.map((feature, i) => (
                                <li key={i} className="flex items-center gap-3 text-slate-700 dark:text-slate-200 font-medium">
                                    <div className="w-6 h-6 bg-purple-100 dark:bg-purple-900/50 rounded-full flex items-center justify-center text-purple-600 dark:text-purple-400">
                                        <CheckCircle2 size={14} />
                                    </div>
                                    {feature}
                                </li>
                            ))}
                        </ul>
                    </motion.div>

                    <motion.div
                        initial={{ opacity: 0, scale: 0.9 }}
                        whileInView={{ opacity: 1, scale: 1 }}
                        viewport={{ once: true }}
                        transition={{ duration: 0.8 }}
                        className="relative"
                    >
                        <div className="absolute -inset-4 bg-purple-500/10 blur-3xl rounded-full" />
                        <div className="relative bg-slate-900 rounded-[40px] p-4 shadow-2xl border border-slate-800">
                            <div className="flex items-center gap-2 mb-4 px-4">
                                <div className="flex gap-1.5">
                                    <div className="w-3 h-3 rounded-full bg-red-500" />
                                    <div className="w-3 h-3 rounded-full bg-yellow-500" />
                                    <div className="w-3 h-3 rounded-full bg-green-500" />
                                </div>
                                <div className="mx-auto bg-slate-800 rounded-lg px-3 py-1 text-[10px] text-slate-400 font-mono">
                                    ai-course-generator.sh
                                </div>
                            </div>
                            <div className="aspect-video bg-slate-950 rounded-2xl overflow-hidden relative">
                                <motion.div
                                    className="absolute inset-0 flex"
                                    animate={{
                                        // On répète le "0%" au début pour créer la pause
                                        x: ["0%", "0%", "-100%", "-200%", "-300%", "-400%", "-500%", "-600%","-600%", "0%"]
                                    }}
                                    transition={{
                                        duration: 30, // Durée totale augmentée
                                        repeat: Infinity,
                                        ease: "easeInOut",
                                        // 0 à 0.375 représente les 3 premières secondes (3s / 8s = 0.375)
                                        times: [0,0, 0.5, 0.5, 0.6, 0.3,0.6, 0.3,0]
                                    }}
                                >
                                    {images.map((src, i) => (
                                        <div key={i} className="w-full h-full shrink-0 relative">
                                            <div className="absolute uppercase top-0 left-0 right-0 text-center text-white font-bold text-lg z-10 bg-black/80 py-2">
                                                {t.steps[i] || "Done !!! 👍"}
                                            </div>
                                            <img
                                                src={src}
                                                alt="AI Generation"
                                                className="w-full h-full object-cover"
                                                referrerPolicy="no-referrer"
                                            />
                                        </div>
                                    ))}
                                </motion.div>
                                <div className="absolute inset-0 bg-gradient-to-t from-slate-950/80 to-transparent flex flex-col justify-end p-8">
                                    <div className="flex items-center gap-3 mb-2">
                                        <div className="w-8 h-8 bg-purple-600 rounded-lg flex items-center justify-center text-white">
                                            <Wand2 size={18} />
                                        </div>
                                        <div className="h-2 w-32 bg-slate-700 rounded-full overflow-hidden">
                                            <motion.div
                                                className="h-full bg-purple-500"
                                                animate={{ width: ["0%", "100%", "0%"] }}
                                                transition={{
                                                    duration: 3, repeat: Infinity,
                                                }}
                                            />
                                        </div>
                                    </div>
                                    <div className="space-y-2">
                                        <div className="h-2 w-full bg-slate-800 rounded-full" />
                                        <div className="h-2 w-3/4 bg-slate-800 rounded-full" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </motion.div>
                </div>
            </div>
        </section>
    );
};
