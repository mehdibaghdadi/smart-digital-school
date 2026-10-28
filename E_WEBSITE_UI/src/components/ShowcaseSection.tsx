import React, { useState } from 'react';
import { motion, AnimatePresence } from 'motion/react';
import { Play, X, ChevronRight } from 'lucide-react';
import { Language, translations } from '../translations';

export const ShowcaseSection = ({ lang }: { lang: Language }) => {
    const t = translations[lang].showcase;
    const [isVideoOpen, setIsVideoOpen] = useState(false);
    const images = [
        "/anime-book.gif",
        "/quiz.gif",
        "/ai.gif",
        "/online.gif",
        "/computer.gif",
        "/working.gif",
    ];

    const videoUrls = {
        fr: import.meta.env.VITE_VIDEO_URL_FR || 'https://www.youtube.com/watch?v=1v6sHcCX1JU',
        en: import.meta.env.VITE_VIDEO_URL_EN || 'https://www.youtube.com/watch?v=O6-i249gHEo',
        es: import.meta.env.VITE_VIDEO_URL_ES || 'https://www.youtube.com/watch?v=O6-i249gHEo',
    };
    const videoUrl = videoUrls[lang] || videoUrls.en;
    const videoId = videoUrl ? (videoUrl.includes('v=') ? videoUrl.split('v=')[1]?.split('&')[0] : videoUrl.split('/').pop()) : '1v6sHcCX1JU';

    const words = t.title.split(" ");

    return (
        <section className="relative w-full bg-white dark:bg-slate-950 pt-24 overflow-hidden transition-colors">
            {/* Background Glows */}
            <div className="absolute top-0 left-1/4 w-96 h-96 bg-brand-600/10 dark:bg-brand-600/20 rounded-full blur-[120px] -z-0" />
            <div className="absolute bottom-0 right-1/4 w-96 h-96 bg-blue-600/10 dark:bg-blue-600/20 rounded-full blur-[120px] -z-0" />

            <div className="max-w-7xl mx-auto px-6 grid lg:grid-cols-2 gap-16 items-center relative z-10">
                {/* Animated Text Block */}
                <div className="space-y-8">
                    <div className="flex flex-wrap gap-x-4">
                        {words.map((word, i) => (
                            <motion.span
                                key={i}
                                initial={{ opacity: 0, y: 30, filter: 'blur(10px)' }}
                                whileInView={{ opacity: 1, y: 0, filter: 'blur(0px)' }}
                                viewport={{ once: true }}
                                transition={{ duration: 0.6, delay: i * 0.1, ease: "easeOut" }}
                                className="text-4xl uppercase  font-black text-slate-900 dark:text-white tracking-tighter"
                            >
                                {word}
                            </motion.span>
                        ))}
                    </div>
                    <motion.p
                        initial={{ opacity: 0 }}
                        whileInView={{ opacity: 1 }}
                        viewport={{ once: true }}
                        transition={{ delay: 1, duration: 1 }}
                        className="text-xl text-slate-600 dark:text-slate-400 max-w-lg leading-relaxed"
                    >
                        {t.desc}
                    </motion.p>
                    <motion.div
                        initial={{ opacity: 0, scale: 0.8 }}
                        whileInView={{ opacity: 1, scale: 1 }}
                        viewport={{ once: true }}
                        transition={{ delay: 1.2 }}
                        className="flex gap-4"
                    >
                        <a href="#solution" className="inline-flex items-center gap-2 px-8 py-4 bg-brand-600 text-white font-bold rounded-2xl hover:bg-brand-500 transition-all shadow-xl shadow-brand-600/20">
                            {t.cta}
                            <ChevronRight size={20} />
                        </a>
                        <button
                            onClick={() => setIsVideoOpen(true)}
                            className="inline-flex items-center gap-2 px-8 py-4 bg-yellow-200 dark:bg-yellow-500 text-slate-900 font-bold rounded-2xl hover:bg-slate-200 dark:hover:bg-slate-700 transition-all"
                        >
                            <Play size={20} />
                            {lang === 'fr' ? 'Voir la vidéo' : lang === 'es' ? 'Ver video' : 'Watch video'}
                        </button>
                    </motion.div>
                </div>

                {/* 3D Carousel Block */}
                <div className="relative h-[450px] flex items-center justify-center [perspective:1500px]">
                    <motion.div
                        animate={{ rotateY: 360 }}
                        transition={{ duration: 25, repeat: Infinity, ease: "linear" }}
                        className="relative w-72 h-44 [transform-style:preserve-3d]"
                    >
                        {images.map((src, i) => (
                            <div
                                key={i}
                                className="absolute flex justify-center inset-0 rounded-2xl overflow-hidden border-2 border-slate-200 dark:border-white/10 shadow-xl bg-white"
                                style={{
                                    transform: `rotateY(${i * (360 / images.length)}deg) translateZ(350px)`,
                                    backfaceVisibility: 'visible'
                                }}
                            >
                                <img
                                    src={src}
                                    alt={`Feature ${i}`}
                                    className="h-full opacity-100 hover:opacity-50 transition-opacity"
                                    referrerPolicy="no-referrer"
                                />
                            </div>
                        ))}
                    </motion.div>

                    {/* Central Glow */}
                    <div className="absolute w-32 h-32 bg-brand-500/30 rounded-full blur-[60px] animate-pulse" />
                </div>
            </div>
            {/* Video Modal */}
            <AnimatePresence>
                {isVideoOpen && (
                    <motion.div
                        initial={{ opacity: 0 }}
                        animate={{ opacity: 1 }}
                        exit={{ opacity: 0 }}
                        className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/80 backdrop-blur-sm"
                        onClick={() => setIsVideoOpen(false)}
                    >
                        <motion.div
                            initial={{ scale: 0.9 }}
                            animate={{ scale: 1 }}
                            exit={{ scale: 0.9 }}
                            className="relative w-full max-w-4xl aspect-video bg-black rounded-3xl overflow-hidden shadow-2xl"
                            onClick={(e) => e.stopPropagation()}
                        >
                            <button
                                onClick={() => setIsVideoOpen(false)}
                                className="absolute top-4 right-4 z-10 p-2 bg-white/10 hover:bg-white/20 rounded-full text-white transition-colors"
                            >
                                <X size={24} />
                            </button>
                            <iframe
                                className="w-full h-full"
                                src={`https://www.youtube.com/embed/${videoId}?autoplay=1`}
                                title="YouTube video player"
                                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                                allowFullScreen
                            />
                        </motion.div>
                    </motion.div>
                )}
            </AnimatePresence>
        </section>
    );
};
